import "random.dart";
import "includes/colour.dart";
import "Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "includes/bytebuilder.dart";
import "includes/palette.dart";
import "HomestuckDoll.dart";

class HomestuckTrollDoll extends HomestuckDoll {

    int maxHorn = 77;
    int maxFin = 1;
    int maxWing = 0;
    @override
    String folder = "Homestuck";

    @override
    Palette palette = new HomestuckTrollPalette()
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
        ..eye_whites = '#ffba29'
        ..pants_dark = '#ADADAD'
        ..hair_accent = '#FF9B00'
        ..hair_main = '#000000'
        ..skin = '#C4C4C4';

    @override
    void initLayers()

    {
        SpriteLayer hairTop = new SpriteLayer("Hair","$folder/HairTop/", 1, maxHair);
        SpriteLayer hairBack = new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, <SpriteLayer>[hairTop]);
        hairTop.syncedWith.add(hairBack);
        hairBack.slave = true; //can't be selected on it's own

        SpriteLayer finLeft = new SpriteLayer("Fin","$folder/LeftFin/", 1, maxFin);
        SpriteLayer finRight = new SpriteLayer("Fin","$folder/RightFin/", 1, maxFin, <SpriteLayer>[finLeft]);
        finLeft.syncedWith.add(finRight);
        finRight.slave = true; //can't be selected on it's own



        layers.add(hairBack);
        layers.add(finRight);
        layers.add(new SpriteLayer("Body","$folder/Body/", 1, maxBody));
        layers.add(new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol));
        layers.add(new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye));
        layers.add(new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye));
        layers.add(new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth));
        layers.add(hairTop);
        layers.add(finLeft);
        layers.add(new SpriteLayer("LeftHorn","$folder/LeftHorn/", 1, maxHorn));
        layers.add(new SpriteLayer("RightHorn","$folder/RightHorn/", 1, maxHorn));
    }

    void randomize() {
        Random rand = new Random();
        int firstEye = -100;
        int firstHorn = -100;
        for(SpriteLayer l in layers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            //keep eyes synced unless player decides otherwise
            if(l.imgNameBase.contains("Eye")) {
                if(firstEye < 0) {
                    firstEye = l.imgNumber;
                }else {
                    l.imgNumber = firstEye;
                }
            }

            if(l.imgNameBase.contains("Horn")) {
                if(firstHorn < 0) {
                    firstHorn = l.imgNumber;
                }else {
                    l.imgNumber = firstHorn;
                }
            }

            if(l.imgNumber == 0 && !l.imgNameBase.contains("Fin")) l.imgNumber = 1;
        }

        HomestuckPalette h = palette as HomestuckPalette;
        palette.add(HomestuckTrollPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

        palette.add(HomestuckTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(HomestuckTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckTrollPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(HomestuckTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckTrollPalette._SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
        palette.add(HomestuckTrollPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
    }


}




/// Convenience class for getting/setting aspect palettes
class HomestuckTrollPalette extends HomestuckPalette {
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
    static String _EYE_WHITES = "eyeWhites";
    static String _SKIN = "skin";

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

    Colour get eye_whites => this[_EYE_WHITES];

    void set eye_whites(dynamic c) => this.add(_EYE_WHITES, _handleInput(c), true);

    Colour get skin => this[_SKIN];

    void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);
}
