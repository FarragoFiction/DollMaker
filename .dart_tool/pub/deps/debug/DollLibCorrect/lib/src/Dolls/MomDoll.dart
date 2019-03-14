//unlike other dolls, moms have  a single, non chooseable base.
//also moms are mostly pastel colors.
import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


class MomDoll extends Doll {

    @override
    String originalCreator = "yogisticDoctor";

    @override
    int renderingType =9;

    @override
    int width = 210;
    @override
    int height = 455;

    @override
    String name = "Mom";

    @override
    String relativefolder = "images/Homestuck/Mom";

    final int maxHair = 14;
    final int maxDrink = 7;
    final int maxOutfit = 11;
    final int maxMouth = 9;
    final int maxBase = 0;

    SpriteLayer hair;
    SpriteLayer drink;
    SpriteLayer outfit;
    SpriteLayer mouth;
    SpriteLayer base;


    @override
    Palette palette = new MomPalette()
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
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#ADADAD'
        ..hair_main = '#ffffff'
        ..hair_accent = '#ADADAD'
        ..skin = '#ffffff';

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[base, mouth, hair, outfit, drink];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[drink, outfit, hair, mouth, base];


    MomDoll() {
        initLayers();
        randomize();
    }

    //moms like pastel pink
    @override
    Colour get associatedColor {
        return new Colour.fromStyleString("#ffa6e9");
    }

    @override
    void randomizeColors() {
                if(rand == null) rand = new Random();;
        //moms wear more pastel colors
        int colorAmount = rand.nextInt(100)+155;
        MomPalette h = palette as MomPalette;
        palette.add(MomPalette._ACCENT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._ASPECT_LIGHT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);

        palette.add(MomPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(MomPalette._SHOE_LIGHT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(MomPalette._CLOAK_LIGHT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(MomPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(MomPalette._SHIRT_LIGHT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
        palette.add(MomPalette._PANTS_LIGHT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
        palette.add(MomPalette._HAIR_ACCENT, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);
        palette.add(MomPalette._HAIR_MAIN, new Colour(rand.nextInt(colorAmount), rand.nextInt(colorAmount), rand.nextInt(colorAmount)), true);

    }




    @override
    void initLayers() {
        base = layer("Mom.Base", "Base/", 0);//new SpriteLayer("Base","$folder/Base/", 0, maxBase);
        outfit = layer("Mom.Outfit", "Outfit/", 1);//new SpriteLayer("Outfit","$folder/Outfit/", 1, maxOutfit);
        mouth = layer("Mom.Mouth", "Mouth/", 1);//new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
        drink = layer("Mom.Drink", "Drink/", 1);//new SpriteLayer("Drink","$folder/Drink/", 1, maxDrink);
        hair = layer("Mom.Hair", "Hair/", 1);//new SpriteLayer("Hair","$folder/Hair/", 1, maxHair);
    }


    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for(SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
        }
    }

}



/// Convenience class for getting/setting aspect palettes
class MomPalette extends Palette {
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
    static String _EYE_WHITE_LEFT = "eyeWhitesLeft";
    static String _EYE_WHITE_RIGHT = "eyeWhitesRight";
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

    Colour get eye_white_left => this[_EYE_WHITE_LEFT];

    void set eye_white_left(dynamic c) => this.add(_EYE_WHITE_LEFT, _handleInput(c), true);

    Colour get eye_white_right => this[_EYE_WHITE_RIGHT];

    void set eye_white_right(dynamic c) => this.add(_EYE_WHITE_RIGHT, _handleInput(c), true);

    Colour get skin => this[_SKIN];

    void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);
}