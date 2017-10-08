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

    int maxHorn = 79;
    int maxFin = 1;
    int maxWing = 13;
    @override
    String folder = "images/Homestuck";

    HomestuckTrollDoll():super();

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
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#C6C6C6'
        ..eye_white_left = '#ffba29'
        ..eye_white_right = '#ffba29'
        ..pants_dark = '#ADADAD'
        ..hair_accent = '#aa0000'
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

        layers.clear();
        layers.add(new SpriteLayer("Wings","$folder/Wings/", 0, maxWing));
        layers.add(hairBack);
        layers.add(finRight);
        layers.add(new SpriteLayer("Body","$folder/Body/", 1, maxBody));
        layers.add(new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol));
        layers.add(new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth));
        layers.add(new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye));
        layers.add(new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye));
        layers.add(new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass));
        layers.add(hairTop);
        layers.add(finLeft);
        layers.add(new SpriteLayer("LeftHorn","$folder/LeftHorn/", 1, maxHorn));
        layers.add(new SpriteLayer("RightHorn","$folder/RightHorn/", 1, maxHorn));
    }


    HomestuckTrollDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        initFromReader(reader);
    }

    HomestuckTrollDoll.fromReader(ByteReader reader){
        initFromReader(reader);
    }

    void randomize() {
        Random rand = new Random();
        int firstEye = -100;
        int firstHorn = -100;
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

        String chosenBlood = rand.pickFrom(bloodColors);
        for(SpriteLayer l in layers) {
            //don't have wings normally
            if(!l.imgNameBase.contains("Wings")) l.imgNumber = rand.nextInt(l.maxImageNumber+1);
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

            if(l.imgNumber == 0 && !l.imgNameBase.contains("Fin")&& !l.imgNameBase.contains("Wings")) l.imgNumber = 1;
            if(l.imgNameBase.contains("Fin")){
                //"#610061", "#99004d"
                if(chosenBlood == "#610061" || chosenBlood == "#99004d"){
                    l.imgNumber = 1;
                }else{
                    l.imgNumber = 0;
                }
            }
            if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }

        HomestuckTrollPalette h = palette as HomestuckTrollPalette;


        palette.add(HomestuckTrollPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

        palette.add(HomestuckTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(HomestuckTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckTrollPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(HomestuckTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckTrollPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
        palette.add(HomestuckTrollPalette._WING1, new Colour.fromStyleString(chosenBlood), true);
        palette.add(HomestuckTrollPalette._WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value/2), true);
        palette.add(HomestuckTrollPalette._HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);

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
    static String _WING1 = "wing1";
    static String _WING2 = "wing2";
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

    Colour get wing1 => this[_WING1];

    void set wing1(dynamic c) => this.add(_WING1, _handleInput(c), true);

    Colour get wing2 => this[_WING2];

    void set wing2(dynamic c) => this.add(_WING2, _handleInput(c), true);
}
