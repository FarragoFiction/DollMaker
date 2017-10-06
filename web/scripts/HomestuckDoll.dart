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
        SpriteLayer hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHairTop);
        SpriteLayer hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHairBack, <SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own

        layers.add(hairBack);
        layers.add(new SpriteLayer("Body","$folder/Body/", 1, maxBody));
        layers.add(hairTop);
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

        palette.add(HomestuckPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._ASPECT_DARK, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._SHOE_DARK, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._CLOAK_DARK, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._CLOAK_MID, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._SHIRT_DARK, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._PANTS_DARK, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._HAIR_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette._HAIR_MAIN, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
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
    static String _HAIR_MAIN = "hairMain";
    static String _HAIR_ACCENT = "hairAccent";

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

    Colour get hair_main => this[_HAIR_MAIN];

    void set hair_main(dynamic c) => this.add(_HAIR_MAIN, _handleInput(c), true);

    Colour get hair_accent => this[_HAIR_ACCENT];

    void set hair_accent(dynamic c) => this.add(_HAIR_ACCENT, _handleInput(c), true);
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
        ..hair_accent = '#202020';

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
