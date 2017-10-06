import "random.dart";
import "includes/colour.dart";
import "Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "includes/bytebuilder.dart";
import "includes/palette.dart";

class HomestuckDoll extends Doll {

    @override
    String folder = "Homestuck";
    final int maxBody = 65; //holy shit, is tht really how many we have?
    final int maxHairBack = 74;
    final int maxHairTop = 74;


    @override
    Palette palette = new HomestuckPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#7F7F7F'
        ..shoe_dark = '#727272'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#EFEFEF'
        ..shirt_dark = '#DBDBDB'
        ..pants_light = '#C6C6C6'
        ..pants_dark = '#ADADAD';



    HomestuckDoll() {
        layers.add(new SpriteLayer("$folder/HairBack/", 1, maxHairBack));
        layers.add(new SpriteLayer("$folder/Body/", 1, maxBody));
        layers.add(new SpriteLayer("$folder/HairTop/", 1, maxHairTop));
        randomize();
    }

    HomestuckDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        //initFromReader(reader);
    }

     HomestuckDoll.fromReader(ByteReader reader){
         //initFromReader(reader);
     }

    String toDataBytesX([ByteBuilder builder = null]) {
        if(builder == null) builder = new ByteBuilder();
         int length = layers.length + 3;  //3 for colors
         builder.appendExpGolomb(length); //for length
         //builder.appendByte(color.red);
         //builder.appendByte(color.green);
         //builder.appendByte(color.blue);
        // builder.appendByte(quality);
         for(SpriteLayer l in layers) {
             print("adding ${l.imgNameBase} to data string builder.");
             builder.appendByte(l.imgNumber);
         }
         return BASE64URL.encode(builder.toBuffer().asUint8List());
     }




    void randomize() {
        Random rand = new Random();
        //color = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
        for(SpriteLayer l in layers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            if(l.imgNumber == 0) l.imgNumber = 1;
        }
        palette = new HomestuckPalette()
            ..accent = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..aspect_light = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..aspect_dark = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..shoe_light = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..shoe_dark = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..cloak_light =new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..cloak_mid = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..cloak_dark = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..shirt_light = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..shirt_dark = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..pants_light = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255))
            ..pants_dark = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
    }

     void randomizeNoColor() {
         Random rand = new Random();
         for(SpriteLayer l in layers) {
             l.imgNumber = rand.nextInt(l.maxImageNumber+1);
             if(l.imgNumber == 0) l.imgNumber = 1;
         }
     }



}

/// Convenience class for getting/setting aspect palettes
class HomestuckPalette extends Palette {
    static String _ACCENT = "accent";
    static String _ASPECT_LIGHT = "aspect1";
    static String _ASPECT_DARK = "aspect2";
    static String _SHOE_LIGHT = "shoe1";
    static String _SHOE_DARK = "shoe2";
    static String _CLOAK_LIGHT = "cloak1";
    static String _CLOAK_MID = "cloak2";
    static String _CLOAK_DARK = "cloak3";
    static String _SHIRT_LIGHT = "shirt1";
    static String _SHIRT_DARK = "shirt2";
    static String _PANTS_LIGHT = "pants1";
    static String _PANTS_DARK = "pants2";

    static Colour _handleInput(Object input) {
        if (input is Colour) {
            return input;
        }
        if (input is int) {
            return new Colour.fromHex(input, input
                .toRadixString(16)
                .padLeft(6, "0")
                .length > 6);
        }
        if (input is String) {
            if (input.startsWith("#")) {
                return new Colour.fromStyleString(input);
            } else {
                return new Colour.fromHexString(input);
            }
        }
        throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
    }

    Colour get text => this[_ACCENT];

    Colour get accent => this[_ACCENT];

    void set accent(dynamic c) => this.add(_ACCENT, _handleInput(c), true);

    Colour get aspect_light => this[_ASPECT_LIGHT];

    void set aspect_light(dynamic c) => this.add(_ASPECT_LIGHT, _handleInput(c), true);

    Colour get aspect_dark => this[_ASPECT_DARK];

    void set aspect_dark(dynamic c) => this.add(_ASPECT_DARK, _handleInput(c), true);

    Colour get shoe_light => this[_SHOE_LIGHT];

    void set shoe_light(dynamic c) => this.add(_SHOE_LIGHT, _handleInput(c), true);

    Colour get shoe_dark => this[_SHOE_DARK];

    void set shoe_dark(dynamic c) => this.add(_SHOE_DARK, _handleInput(c), true);

    Colour get cloak_light => this[_CLOAK_LIGHT];

    void set cloak_light(dynamic c) => this.add(_CLOAK_LIGHT, _handleInput(c), true);

    Colour get cloak_mid => this[_CLOAK_MID];

    void set cloak_mid(dynamic c) => this.add(_CLOAK_MID, _handleInput(c), true);

    Colour get cloak_dark => this[_CLOAK_DARK];

    void set cloak_dark(dynamic c) => this.add(_CLOAK_DARK, _handleInput(c), true);

    Colour get shirt_light => this[_SHIRT_LIGHT];

    void set shirt_light(dynamic c) => this.add(_SHIRT_LIGHT, _handleInput(c), true);

    Colour get shirt_dark => this[_SHIRT_DARK];

    void set shirt_dark(dynamic c) => this.add(_SHIRT_DARK, _handleInput(c), true);

    Colour get pants_light => this[_PANTS_LIGHT];

    void set pants_light(dynamic c) => this.add(_PANTS_LIGHT, _handleInput(c), true);

    Colour get pants_dark => this[_PANTS_DARK];

    void set pants_dark(dynamic c) => this.add(_PANTS_DARK, _handleInput(c), true);
}