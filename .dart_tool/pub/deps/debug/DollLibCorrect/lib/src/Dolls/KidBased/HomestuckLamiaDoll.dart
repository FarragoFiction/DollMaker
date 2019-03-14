import "../../../DollRenderer.dart";
import "../../Rendering/ReferenceColors.dart";
import "../../commonImports.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckLamiaDoll extends HomestuckTrollDoll {

    @override
    String originalCreator = "???";
    List<int> seadwellerBodies = Doll.dataValue("Lamia.seaDwellerBodies");//<int>[7,8,9,12,13,27,28,29,34,35,39,40,46,50,51,52,60,61];

    @override
    int renderingType =88;

    @override
  List<String> colorsToSkipIfProblem = <String>["horn1","horn2","horn3"];

    @override
    String relativeFolder = "images/Homestuck";
    @override
    final int maxBody = 74;


    @override
    String name = "Lamia";


    @override
    Palette palette = new HomestuckLamiaPalette()
        ..accent = '#FF9B00'
        ..shoe_light = '#ffa8ff'
        ..shoe_dark = '#ff5bff'
        ..cloak_light = '#f8dc57'
        ..cloak_mid = '#d1a93b'
        ..cloak_dark = '#ad871e'
        ..shirt_light = '#eae8e7'
        ..shirt_dark = '#bfc2c1'
        ..pants_light = '#03500e'
        ..pants_dark = '#00341a'
        ..eye_white_left = "#ffa8ff"
        ..eye_white_right = "#ffa8ff"
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skinDark = '#69b8c8'
        ..horn1 = "#000000"
        ..horn2 = "#000000"
        ..horn3 = "#000000"

        ..skin = '#8ccad6';

    @override
    Palette paletteSource = ReferenceColours.LAMIA_PALETTE;



    HomestuckLamiaDoll([int sign]) {
        initLayers();
        randomize();
        if(sign != null) {
           // print("sign is $sign");
            canonSymbol.imgNumber = sign;
            //print("used sign to set canon Symbol to ${canonSymbol.imgNumber}");

            //makes sure palette is sign appropriate
            randomize(false);
            //print("after randomize, canon symbol is ${canonSymbol.imgNumber}");

        }
    }




    void mutantWings([bool force = false]) {
        //grubs don't have wings. trolls do.
    }


    @override
    void regularEyes(older) {
        HomestuckPalette h = palette as HomestuckPalette;
        if(older) {
            palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#ffba29"), true);
            palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#ffba29"), true);
        }else {
            h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light, true);
            h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light, true);
        }
    }

    @override
    void randomize([bool chooseSign = true])

    {
        super.randomize(chooseSign);
        pickFin();
        randomizeColors();
    }


    @override
    void randomizeColors() {
        super.randomizeColors();
        HomestuckLamiaPalette h = palette as HomestuckLamiaPalette;
        copyPalette(ReferenceColours.PURIFIED);
        print("trying to set horn to ${h.aspect_light.toStyleString()}");
        String light = h.aspect_light.toStyleString();
        String dark = h.aspect_dark.toStyleString();
        if (rand.nextBool()) {
            h.horn1 = new Colour.fromStyleString(light);
        } else {
            h.horn1 = new Colour.fromStyleString(dark);
        }
        if (rand.nextBool()) {
            h.horn2 = new Colour.fromStyleString(light);
        } else {
            h.horn2 = new Colour.fromStyleString(dark);
        }

        if (rand.nextBool()) {
            h.horn3 = new Colour.fromStyleString(light);
        } else {
            h.horn3 = new Colour.fromStyleString(dark);
        }
    }

    @override
    void randomizeNotColors() {
        super.randomizeColors();
        pickFin();

    }

    void pickFin() {
        if(seadwellerBodies.contains(extendedBody.imgNumber)) {
            int chosenFin = rand.nextIntRange(1,leftFin.maxImageNumber);
            leftFin.imgNumber = chosenFin;
            rightFin.imgNumber = chosenFin;
        }
    }



    @override
    void setUpWays() {

    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/SnakeBody/", 0, maxBody, legacy: true);
        extendedBody = layer("Lamia.Body", "SnakeBody/", 0, mb:true);//new SpriteLayer("Body","$folder/SnakeBody/", 0, maxBody, supportsMultiByte: true);


    }








}

/// Convenience class for getting/setting aspect palettes
class HomestuckLamiaPalette extends HomestuckTrollPalette {
    static String _ACCENT = "accent";
    static String _HORN1 = "horn1";
    static String _HORN2 = "horn2";
    static String _HORN3 = "horn3";
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
    static String _SKINDARK = "skinDark";


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

    Colour get skinDark => this[_SKINDARK];

    void set skinDark(dynamic c) => this.add(_SKINDARK, _handleInput(c), true);

    Colour get horn1 => this[_HORN1];

    void set horn1(dynamic c) => this.add(_HORN1, _handleInput(c), true);

    Colour get horn2 => this[_HORN2];

    void set horn2(dynamic c) => this.add(_HORN2, _handleInput(c), true);

    Colour get horn3 => this[_HORN3];

    void set horn3(dynamic c) => this.add(_HORN3, _handleInput(c), true);
}