import "Doll.dart";
import "HomestuckDoll.dart";
import "HomestuckTrollDoll.dart";
import "dart:html";
import "SpriteLayer.dart";
import "includes/colour.dart";
import "includes/palette.dart";
import "random.dart";
import "loader/loader.dart";

class Renderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;
    static drawDoll(CanvasElement canvas, Doll doll, Palette source) {
        print("Drawing a doll");
        CanvasElement buffer = getBufferCanvas(querySelector("#doll_template"));
        for(SpriteLayer l in doll.layers) {
            drawWhatever(buffer, l.imgLocation);
        }
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



abstract class ReferenceColours {
    static Colour WHITE = new Colour.fromHex(0xFFFFFF);
    static Colour BLACK = new Colour.fromHex(0x000000);
    static Colour RED = new Colour.fromHex(0xFF0000);
    static Colour LIME = new Colour.fromHex(0x00FF00);

    static Colour LIME_CORRECTION = new Colour.fromHex(0x00FF2A);

    static Colour GRIM = new Colour.fromHex(0x424242);
    static Colour GREYSKIN = new Colour.fromHex(0xC4C4C4);
    static Colour GRUB = new Colour.fromHex(0x585858);
    static Colour ROBOT = new Colour.fromHex(0xB6B6B6);
    static Colour ECHELADDER = new Colour.fromHex(0x4A92F7);
    static Colour BLOOD_PUDDLE = new Colour.fromHex(0xFFFC00);
    static Colour BLOODY_FACE = new Colour.fromHex(0x440A7F);

    static Colour HAIR = new Colour.fromHex(0x313131);
    static Colour HAIR_ACCESSORY = new Colour.fromHex(0x202020);

    static HomestuckPalette SPRITE_PALETTE = new HomestuckPalette()
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00'
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..skin = '#ffffff';

    static HomestuckTrollPalette TROLL_PALETTE = new HomestuckTrollPalette()
        ..aspect_light = '#FEFD49'
        ..aspect_dark = '#FEC910'
        ..wing1 = '#00FF2A'
        ..wing2 = '#FF0000'
        ..aspect_dark = '#FEC910'
        ..shoe_light = '#10E0FF'
        ..shoe_dark = '#00A4BB'
        ..cloak_light = '#FA4900'
        ..cloak_mid = '#E94200'
        ..cloak_dark = '#C33700'
        ..shirt_light = '#FF8800'
        ..shirt_dark = '#D66E04'
        ..pants_light = '#E76700'
        ..pants_dark = '#CA5B00'
        ..hair_main = '#313131'
        ..hair_accent = '#202020'
        ..eye_white_left = '#ffba35'
        ..eye_white_right = '#ffba15'
        ..skin = '#ffffff';

    static HomestuckPalette PROSPIT_PALETTE = new HomestuckPalette()
        ..aspect_light = "#FFFF00"
        ..aspect_dark = "#FFC935"
    // no shoe colours here on purpose
        ..cloak_light = "#FFCC00"
        ..cloak_mid = "#FF9B00"
        ..cloak_dark = "#C66900"
        ..shirt_light = "#FFD91C"
        ..shirt_dark = "#FFE993"
        ..pants_light = "#FFB71C"
        ..pants_dark = "#C67D00";

    static HomestuckPalette DERSE_PALETTE = new HomestuckPalette()
        ..aspect_light = "#F092FF"
        ..aspect_dark = "#D456EA"
    // no shoe colours here on purpose
        ..cloak_light = "#C87CFF"
        ..cloak_mid = "#AA00FF"
        ..cloak_dark = "#6900AF"
        ..shirt_light = "#DE00FF"
        ..shirt_dark = "#E760FF"
        ..pants_light = "#B400CC"
        ..pants_dark = "#770E87";

    static HomestuckPalette ROBOT_PALETTE = new HomestuckPalette()
        ..aspect_light = "#0000FF"
        ..aspect_dark = "#0022cf"
        ..shoe_light = "#B6B6B6"
        ..shoe_dark = "#A6A6A6"
        ..cloak_light = "#484848"
        ..cloak_mid = "#595959"
        ..cloak_dark = "#313131"
        ..shirt_light = "#B6B6B6"
        ..shirt_dark = "#797979"
        ..pants_light = "#494949"
        ..pants_dark = "#393939";
}
