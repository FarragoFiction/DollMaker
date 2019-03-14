import 'dart:async';
import "dart:html";
import "dart:math" as Math;
import "dart:typed_data";

import "package:LoaderLib/Loader.dart";
import "package:CommonLib/Colours.dart";
import "package:CommonLib/Random.dart";

class Renderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;

    //why doesn't this let me reset it???
    static bool debug = false;


    static void grayscale(CanvasElement canvas) {
        CanvasRenderingContext2D ctx = canvas.context2D;
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        //4 byte color array

        for (int i = 0; i < img_data.data.length; i += 4) {
            if (img_data.data[i + 3] > 0) {
                num brightness = 0.34 * img_data.data[i] + 0.5 * img_data.data[i + 1] + 0.16 * img_data.data[i + 2];
                int b = 5+(brightness/10).round();
                img_data.data[i] = b;
                img_data.data[i+1] = b;
                img_data.data[i+2] = b;
            }
        }
        ctx.putImageData(img_data, 0, 0);

    }

    static void emboss(CanvasElement canvas) {
        bool opaque = false;
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData pixels = ctx.getImageData(0, 0, canvas.width, canvas.height);
        List<int> weights = <int>[ -3, 2, 0, -3, 2, 2, 0, 2, 3];
        int side = (Math.sqrt(weights.length)).round();
        int halfSide = (side ~/ 2);
        List<int> src = pixels.data;
        int sw = pixels.width;
        int sh = pixels.height;
        // pad output by the convolution matrix
        int w = sw;
        int h = sh;
        ImageData output = ctx.getImageData(0, 0, canvas.width, canvas.height);
        List<int> dst = output.data;
        // go through the destination image pixels
        int alphaFac = opaque ? 1 : 0;
        for (int y = 0; y < h; y++) {
            for (int x = 0; x < w; x++) {
                int sy = y;
                int sx = x;
                int dstOff = (y * w + x) * 4;
                // calculate the weighed sum of the source image pixels that
                // fall under the convolution matrix
                int r = 0,
                    g = 0,
                    b = 0,
                    a = 0;
                for (int cy = 0; cy < side; cy++) {
                    for (int cx = 0; cx < side; cx++) {
                        int scy = sy + cy - halfSide;
                        int scx = sx + cx - halfSide;
                        if (scy >= 0 && scy < sh && scx >= 0 && scx < sw) {
                            int srcOff = (scy * sw + scx) * 4;
                            int wt = weights[cy * side + cx];
                            r += src[srcOff] * wt;
                            g += src[srcOff + 1] * wt;
                            b += src[srcOff + 2] * wt;
                            a += src[srcOff + 3] * wt;
                        }
                    }
                }
                dst[dstOff] = r;
                dst[dstOff + 1] = g;
                dst[dstOff + 2] = b;
                dst[dstOff + 3] = a + alphaFac * (255 - a);
            }
        }
        canvas.context2D.putImageData(output, 0, 0);
    }


    //the doll should fit into the canvas. use largest size
    static double scaleForSize(int sourcewidth, int sourceheight, int destwidth, int destheight) {
        double widthratio = destwidth / sourcewidth;
        double heightratio = destheight / sourceheight;
        return Math.min(widthratio, heightratio);
    }


    static void drawToFitCentered(CanvasElement destination, CanvasElement source) {
        //print("Drawing to fit width: ${destination.width}, height: ${destination.height}, native width is ${source.width} by ${source.height}");
        double ratio = scaleForSize(source.width, source.height, destination.width, destination.height);
        int newWidth = (source.width * ratio).ceil();
        int newHeight = (source.height * ratio).ceil();
        //doesn't look right :(
        //int x = (destination.width/2 - source.width/2).round();
        int x = (destination.width/2 - newWidth/2).ceil();
        //print("New dimensions: ${newWidth}, height: ${newHeight}");
        source.context2D.imageSmoothingEnabled = false;
        destination.context2D.imageSmoothingEnabled = false;


        destination.context2D.drawImageScaled(source, x,0,newWidth,newHeight);
    }


    static CanvasElement getBufferCanvas(CanvasElement canvas) {
        return new CanvasElement(width: canvas.width, height: canvas.height);
    }
    static void copyTmpCanvasToRealCanvasAtPos(CanvasElement canvas, CanvasElement tmp_canvas, int x, int y) {
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ctx.drawImage(tmp_canvas, x, y);
    }

    static void swapPaletteLegacy(CanvasElement canvas, Palette source, Palette replacement) {
        //print("swapping ${source.names} for ${replacement.names}");
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);

        for (int i = 0; i < img_data.data.length; i += 4) {
            Colour sourceColour = new Colour(img_data.data[i], img_data.data[i + 1], img_data.data[i + 2]);
            for (String name in source.names) {
                if (source[name] == sourceColour) {
                    Colour replacementColour = replacement[name];
                    img_data.data[i] = replacementColour.red;
                    img_data.data[i + 1] = replacementColour.green;
                    img_data.data[i + 2] = replacementColour.blue;
                    break;
                }
            }
        }
        ctx.putImageData(img_data, 0, 0);
    }

    static void swapPalette(CanvasElement canvas, Palette source, Palette replacement) {
        CanvasRenderingContext2D ctx = canvas.context2D;
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        Uint32List pixels = img_data.data.buffer.asUint32List();

        Map<int, int> mapping = <int,int>{};

        for (String col in source.names) {
            mapping[_swapPaletteFlipHex(source[col].toHex(true))] = _swapPaletteFlipHex(replacement[col].toHex(true));
        }

        int pixel, pixel_rgb, pixel_a;
        int swap, swap_a;

        for (int i = 0; i < pixels.length; i ++) {
            pixel = pixels[i];
            pixel_a = pixel & 0xFF000000;

            if (pixel_a > 0) {
                pixel_rgb = (pixel & 0x00FFFFFF) | 0xFF000000;

                if (mapping.containsKey(pixel_rgb)) {
                    swap = mapping[pixel_rgb];
                    swap_a = (swap & 0xFF000000) >> 24;

                    if (swap_a < 255) {
                        pixel_a = ((((pixel_a >> 24) / 255) * (swap_a / 255)) * 255).clamp(0, 255).floor() << 24;
                    }
                    pixels[i] = (swap & 0x00FFFFFF) | pixel_a;
                }
            }
        }
        ctx.putImageData(img_data, 0, 0);
    }

    static int _swapPaletteFlipHex(int col) {
        int r = (col & 0xFF000000) >> 24;
        int g = (col & 0x00FF0000) >> 16;
        int b = (col & 0x0000FF00) >> 8;
        int a = (col & 0x000000FF);

        return (a << 24) | (b << 16) | (g << 8) | r;
    }

    static void drawBGRadialWithWidth(CanvasElement canvas, num startX, num endX, num width, Colour color1, Colour color2) {
        CanvasRenderingContext2D ctx = canvas.getContext("2d");

        CanvasGradient grd = ctx.createRadialGradient(width / 2, canvas.height / 2, 5, width, canvas.height, width);
        grd.addColorStop(0, color1.toStyleString());
        grd.addColorStop(1, color2.toStyleString());

        ctx.fillStyle = grd;
        ctx.fillRect(startX, 0, endX, canvas.height);
    }

    static void drawBG(CanvasElement canvas, Colour color1, Colour color2) {
        CanvasRenderingContext2D ctx = canvas.getContext("2d");

        CanvasGradient grd = ctx.createLinearGradient(0, 0, 170, 0);
        grd.addColorStop(0, color1.toStyleString());
        grd.addColorStop(1, color2.toStyleString());

        ctx.fillStyle = grd;
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    }


    //anything not transparent becomes a shade
    static void swapColors(CanvasElement canvas, Colour newc) {
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ImageData img_data = ctx.getImageData(0, 0, canvas.width, canvas.height);
        //4 byte color array
        for (int i = 0; i < img_data.data.length; i += 4) {
            if (img_data.data[i + 3] > 100) {
                Colour replacementColor = new Colour(img_data.data[i],img_data.data[i + 1],img_data.data[i + 2],img_data.data[i + 3]);
                double value = 0.0;
                //keep black lines black, but otherwise let them somewhat pick their own brightness.
                if(replacementColor.value != 0.0)  value = (replacementColor.value + newc.value)/2;
                replacementColor.setHSV(newc.hue, newc.saturation, value);
                img_data.data[i] = replacementColor.red;
                img_data.data[i + 1] = replacementColor.green;
                img_data.data[i + 2] = replacementColor.blue;
                //img_data.data[i + 3] = alpha;
            }
        }
        ctx.putImageData(img_data, 0, 0);
    }

    static void drawUpsideDownAt(CanvasElement sourceCanvas, CanvasElement destinationCanvas, int x, int y, int divisor) {
        destinationCanvas.context2D.save();
        //put teh origin at the place the object will be
        destinationCanvas.context2D.translate(x, y);
        //rotate, which is always around the origin and not where i draw
        destinationCanvas.context2D.rotate(180*Math.PI/180);
        //draw the thing at zero zero
        destinationCanvas.context2D.drawImageScaled(sourceCanvas, 0, 0, sourceCanvas.width/divisor, sourceCanvas.height/divisor);
        destinationCanvas.context2D.restore();
    }


    static void drawWhatever(CanvasElement canvas, String imageString) {
        if(debug) print("Trying to draw $imageString");
        Loader.getResource(imageString).then((ImageElement loaded) {
            loaded.crossOrigin = "";
            //print("image $loaded loaded");
            canvas.context2D.imageSmoothingEnabled = false;
            canvas.context2D.drawImage(loaded, 0, 0);
        });

    }

    static Future<bool>  drawWhateverFuture(CanvasElement canvas, String imageString, [int x=0, int y = 0]) async {
        //print("drawing $imageString, debug is $debug");

        //if(debug) print("drawing $imageString");
        ImageElement image = await Loader.getResource((imageString));
        image.crossOrigin = "";
        //print("got image $image");
        canvas.context2D.imageSmoothingEnabled = false;
        canvas.context2D.drawImage(image, x, y);
        return true;
    }

    static Future<bool>  drawExistingElementFuture(CanvasElement canvas, ImageElement image, [int x=0, int y = 0]) async {
        //print("got image $image");
        canvas.context2D.imageSmoothingEnabled = false;
        canvas.context2D.drawImage(image, x, y);
        return true;
    }

    static ImageElement imageSelector(String path) {
        return querySelector("#${escapeId(path)}");
    }

    static String escapeId(String toEscape) {
        return toEscape.replaceAll(new RegExp(r"\.|\/"),"_");
    }

    static void clearCanvas(CanvasElement canvas) {
        CanvasRenderingContext2D ctx = canvas.context2D;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }



    static void loadImage(String img, dynamic callback) {
        ////print(img);
        imagesWaiting ++;
        ImageElement imageObj = new ImageElement();
        imageObj.onLoad.listen((Event e) {
            //  context.drawImage(imageObj, 69, 50); //i don't want to draw it. i could put it in image staging?
            addImageTagLoading(img);
            imagesLoaded ++;
            checkDone(callback);
        });

        imageObj.onError.listen((Event e){
            querySelector("#loading_stats").appendHtml("Error loading image: ${imageObj.src}");
            print("Error loading image: ${imageObj.src}");
        });
        imageObj.src = "images/$img";
    }

    static void checkDone(dynamic callback){
        if(querySelector("#loading_stats") != null) querySelector("#loading_stats").text = ("Images Loaded: $imagesLoaded");
        if((imagesLoaded != 0 && imagesWaiting == imagesLoaded)){
            callback();
        }
    }

    static CanvasElement cropToVisible(CanvasElement canvas) {
        int leftMostX = canvas.width; //if i find a pixel with an x value smaler than this, it is now leftMostX
        int rightMostX = 0; //if i find a pixel with an x value bigger than this, it is not rightMost X
        //or is it the other way around?
        int topMostY = canvas.height;
        int bottomMostY = 0;

        ImageData img_data = canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);

        for(int x = 0; x<canvas.width; x ++) {
            for(int y = 0; y<canvas.height; y++) {
                int i = (y * canvas.width + x) * 4;
                if(img_data.data[i+3] >100) {
                    if(x < leftMostX) leftMostX = x;
                    if(x > rightMostX) rightMostX = x;
                    if(y > bottomMostY) bottomMostY = y;
                    if(y < topMostY) topMostY = y;
                }
            }

        }

        return cropToCoordinates(canvas, leftMostX, rightMostX, topMostY, bottomMostY);

    }

    //https://stackoverflow.com/questions/45866873/cropping-an-html-canvas-to-the-width-height-of-its-visible-pixels-content
    static CanvasElement cropToCoordinates(CanvasElement canvas, int leftMostX, int rightMostX, int topMostY, int bottomMostY) {
        int width = rightMostX - leftMostX;
        int height = bottomMostY - topMostY;
        //print("old width is ${canvas.width} x is $leftMostX right x is $rightMostX width is: $width, height is $height");
        CanvasElement ret = new CanvasElement(width: width, height: height);
        ret.context2D.drawImageToRect(canvas,new Rectangle<int>(0,0,width,height), sourceRect: new Rectangle<int>(leftMostX,topMostY,width,height));
        return ret;
    }



    static void addImageTagLoading(String url){
        ////print(url);
        //only do it if image hasn't already been added.
        if(querySelector("#${escapeId(url)}") == null) {
            ////print("I couldn't find a document with id of: " + url);
            String tag = '<img id="${escapeId(url)}" src = "images/$url" class="loadedimg">';
            //var urlID = urlToID(url);
            //String tag = '<img id ="' + urlID + '" src = "' + url + '" style="display:none">';
            querySelector("#loading_image_staging").appendHtml(tag,treeSanitizer: NodeTreeSanitizer.trusted);
        }else{
            ////print("I thought i found a document with id of: " + url);

        }

    }

    static Future<Null> drawRandomPartOfImage(CanvasElement canvas, Random rand, int subSetWidth,String randomImageName) async {


        ImageElement image = await Loader.getResource((randomImageName));
        //print("got image $image");
        canvas.context2D.imageSmoothingEnabled = false;

        //int startXMin = 0;
        int startXMax = image.width -subSetWidth;
        //canvas.context2D.drawImage(image, 0, 0);
        canvas.context2D.drawImageToRect(image,new Rectangle<int>(0,0,canvas.width,canvas.height), sourceRect: new Rectangle<int>(rand.nextInt(startXMax),0,subSetWidth,image.height));

    }


    static int simulateWrapTextToGetFontSize(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, int maxHeight) {
        List<String> words = text.split(' ');
        List<String> lines = <String>[];
        int sliceFrom = 0;
        for (int i = 0; i < words.length; i++) {
            String chunk = words.sublist(sliceFrom, i).join(' ');
            bool last = i == words.length - 1;
            bool bigger = ctx
                .measureText(chunk)
                .width > maxWidth;
            if (bigger) {
                lines.add(words.sublist(sliceFrom, i).join(' '));
                sliceFrom = i;
            }
            if (last) {
                lines.add(words.sublist(sliceFrom, words.length).join(' '));
                sliceFrom = i;
            }
        }
        //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
        return lines.length;

    }


    //http://stackoverflow.com/questions/5026961/html5-canvas-ctx-filltext-wont-do-line-breaks
    static int wrap_text(CanvasRenderingContext2D ctx, String text, num x, num y, num lineHeight, int maxWidth, String textAlign) {
        if (textAlign == null) textAlign = 'center';
        ctx.textAlign = textAlign;
        List<String> words = text.split(' ');
        List<String> lines = <String>[];
        int sliceFrom = 0;
        for (int i = 0; i < words.length; i++) {
            String chunk = words.sublist(sliceFrom, i).join(' ');
            bool last = i == words.length - 1;
            bool bigger = ctx
                .measureText(chunk)
                .width > maxWidth;
            if (bigger) {
                lines.add(words.sublist(sliceFrom, i).join(' '));
                sliceFrom = i;
            }
            if (last) {
                lines.add(words.sublist(sliceFrom, words.length).join(' '));
                sliceFrom = i;
            }
        }
        num offsetY = 0.0;
        num offsetX = 0;
        if (textAlign == 'center') offsetX = maxWidth ~/ 2;
        for (int i = 0; i < lines.length; i++) {
            ctx.fillText(lines[i], x + offsetX, y + offsetY);
            offsetY = offsetY + lineHeight;
        }
        //need to return how many lines i created so that whatever called me knows where to put ITS next line.;
        return lines.length;
    }

    static WordWrapMetaData wrapLoop(List<String> words, CanvasRenderingContext2D ctx, int maxWidth) {
        List<String> lines = new List<String>();
        int sliceFrom = 0;
        for (int i = 0; i < words.length; i++) {
            String chunk = words.sublist(sliceFrom, i).join(' ');
            bool last = i == words.length - 1;
            if (ctx.measureText(chunk).width > maxWidth || chunk.contains("\n")) {
                lines.add(words.sublist(sliceFrom, i).join(' '));
                sliceFrom = i;
            }
            if (last) {
                lines.add(words.sublist(sliceFrom, words.length).join(' '));
                sliceFrom = i;
            }
        }
        return new WordWrapMetaData(lines, ctx);
    }



//first, make sure no line will go off screen width
//second, make sure all lines don't go off screen height
//canvas.context2D, s, font, 10, 30, fontsize, width-buffer, height-bufferY
    static int wrapTextAndResizeIfNeeded(CanvasRenderingContext2D ctx, String text, String font, num x, num y, num fontSize, int maxWidth, int maxHeight, [int lineBuffer = 0]) {
        List<String> words = text.split(' ');
        WordWrapMetaData data = wrapLoop(words, ctx, maxWidth);
        //loop to keep within width. no easy calc for this, i THINK
        while(data.largestLine > maxWidth) {
            //print("Biggest line is ${data.largestLine} but can't be bigger than ${maxWidth}");
            fontSize = fontSize - 1.0;
            data.ctx.font = "${fontSize}px $font"; //since the data's context is what matters, make sure you use it
        }

        //take care of keeping in height
        if((data.lines.length * fontSize)>maxHeight) {
            int size = (maxHeight/data.lines.length).floor();
            ctx.font = "${size}px $font";
            fontSize = size;
        }

        num offsetY = 0.0;
        num offsetX = 0;
        if ( ctx.textAlign == 'center') offsetX = maxWidth ~/ 2;
        for (int i = 0; i < data.lines.length; i++) {
            ctx.fillText(data.lines[i], x + offsetX, y + offsetY);
            offsetY = offsetY + fontSize + lineBuffer;
        }
        return data.lines.length;
    }



}


class Size2D {
    int width;
    int height;

    Size2D(int this.width, int this.height);

}

class WordWrapMetaData {
    List<String> lines;
    CanvasRenderingContext2D ctx;

    WordWrapMetaData(this.lines, this.ctx) {
        //print("made word wrap meta data with ${lines.length} lines");
    }

    num get largestLine {
        num biggestWidth = 0.0;
        for(String line in lines) {
            num size = ctx.measureText(line).width;
            if(size > biggestWidth) biggestWidth = size;
        }

        return biggestWidth;

    }
}