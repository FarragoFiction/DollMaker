import "Dolls/Doll.dart";
import "Dolls/HomestuckDoll.dart";
import "Dolls/HomestuckTrollDoll.dart";
import "dart:html";
import 'dart:async';
import "SpriteLayer.dart";
import "includes/colour.dart";
import "includes/palette.dart";
import "random.dart";
import "loader/loader.dart";
import "Dolls/ConsortDoll.dart";

class Renderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;


    static  Future<bool>  drawDoll(CanvasElement canvas, Doll doll, Palette source) async {
        //print("Drawing a doll");
        CanvasElement buffer = getBufferCanvas(querySelector("#doll_template"));
        for(SpriteLayer l in doll.layers) {
            bool res = await drawWhateverFuture(buffer, l.imgLocation);
        }
        //print("done drawing images");
        swapPalette(buffer, source, doll.palette);
        copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);
    }


    static CanvasElement getBufferCanvas(CanvasElement canvas) {
        return new CanvasElement(width: canvas.width, height: canvas.height);
    }
    static void copyTmpCanvasToRealCanvasAtPos(CanvasElement canvas, CanvasElement tmp_canvas, int x, int y) {
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        ctx.drawImage(tmp_canvas, x, y);
    }

    static void swapPalette(CanvasElement canvas, Palette source, Palette replacement) {
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



    static void drawBoundingBox(CanvasElement canvas, ClickableSpriteLayer layer) {
        //print("drawing bounding box for ${layer.imgNameBase}: ${layer.topLeftX}, ${layer.topLeftY}, ${layer.width}, ${layer.height}");
        CanvasRenderingContext2D ctx = canvas.getContext('2d');
        Random rand = new Random();
        Colour color = new Colour.hsv(rand.nextDouble(), rand.nextDouble(), rand.nextDouble());
        //new Colour.hsv(random 0-1, some random saturation 0-1, some random value 0-1),
        ctx.fillStyle = color.toStyleString();
        ctx.fillRect(layer.topLeftX, layer.topLeftY, layer.width, layer.height);
        ctx.strokeRect(layer.topLeftX, layer.topLeftY, layer.width, layer.height);
    }

    static void drawWhatever(CanvasElement canvas, String imageString) {
        print("Trying to draw $imageString");
        Loader.getResource(imageString).then((ImageElement loaded) {
            print("image $loaded loaded");
            canvas.context2D.drawImage(loaded, 0, 0);
        });

    }

    static Future<bool>  drawWhateverFuture(CanvasElement canvas, String imageString) async {
        ImageElement image = await Loader.getResource((imageString));
        //print("got image $image");
        canvas.context2D.drawImage(image, 0, 0);
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

    static void loadHomestuckDollParts(HomestuckDoll doll, dynamic callback) {

        for(int i = 0; i<=doll.maxBody; i++) {
            loadImage("${doll.folder}/Body/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxMouth; i++) {
            loadImage("${doll.folder}/Mouth/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxSymbol; i++) {
            loadImage("${doll.folder}/Symbol/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHair; i++) {
            loadImage("${doll.folder}/HairTop/$i.png", callback);
            loadImage("${doll.folder}/HairBack/$i.png", callback);

        }


        for(int i = 0; i<=doll.maxEye; i++) {
            loadImage("${doll.folder}/LeftEye/$i.png", callback);
            loadImage("${doll.folder}/RightEye/$i.png", callback);
        }
    }

    static void loadHomestuckTrollDollParts(HomestuckTrollDoll doll, dynamic callback) {

        for(int i = 0; i<=doll.maxBody; i++) {
            loadImage("${doll.folder}/Body/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxMouth; i++) {
            loadImage("${doll.folder}/Mouth/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxWing; i++) {
            loadImage("${doll.folder}/Wings/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxSymbol; i++) {
            loadImage("${doll.folder}/Symbol/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHair; i++) {
            loadImage("${doll.folder}/HairTop/$i.png", callback);
            loadImage("${doll.folder}/HairBack/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxHorn; i++) {
            loadImage("${doll.folder}/LeftHorn/$i.png", callback);
            loadImage("${doll.folder}/RightHorn/$i.png", callback);
        }

        for(int i = 0; i<=doll.maxFin; i++) {
            loadImage("${doll.folder}/LeftFin/$i.png", callback);
            loadImage("${doll.folder}/RightFin/$i.png", callback);
        }


        for(int i = 0; i<=doll.maxEye; i++) {
            loadImage("${doll.folder}/LeftEye/$i.png", callback);
            loadImage("${doll.folder}/RightEye/$i.png", callback);
        }
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
            querySelector("#loading_stats").appendHtml("Error loading image: " + imageObj.src);
            print("Error loading image: " + imageObj.src);
        });
        imageObj.src = "images/"+img;
    }

    static void checkDone(dynamic callback){
        if(querySelector("#loading_stats") != null) querySelector("#loading_stats").text = ("Images Loaded: $imagesLoaded");
        if((imagesLoaded != 0 && imagesWaiting == imagesLoaded)){
            callback();
        }
    }


    static void addImageTagLoading(url){
        ////print(url);
        //only do it if image hasn't already been added.
        if(querySelector("#${escapeId(url)}") == null) {
            ////print("I couldn't find a document with id of: " + url);
            String tag = '<img id="' + escapeId(url) + '" src = "images/' + url + '" class="loadedimg">';
            //var urlID = urlToID(url);
            //String tag = '<img id ="' + urlID + '" src = "' + url + '" style="display:none">';
            querySelector("#loading_image_staging").appendHtml(tag,treeSanitizer: NodeTreeSanitizer.trusted);
        }else{
            ////print("I thought i found a document with id of: " + url);

        }

    }


}

