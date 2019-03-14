import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckSatyrDoll extends HomestuckDoll {

    @override
    String originalCreator = "Popo Merrygamz";


    @override
    int renderingType = 15;

    @override
    String name = "Satyr";
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    //these bodies look terrible with troll signs. if any of these use 47,48, or 49
    List<int> bannedRandomBodies = Doll.dataValue("Satyr.bannedBodies");//<int>[96,219,221,223,5,11,14,43,50,59,65,66,67,70,72,75,74,98,100,101,102,106,107,109,63,17];
    int defaultBody = Doll.dataValue("Satyr.defaultBody");//48;
    int maxHorn = 17;
    int maxFluff = 19;
    int maxFacePattern = 24;
    int maxSatyrSymbol = 21;
    int maxTail = 9;

    SpriteLayer leftHorn;
    SpriteLayer satyrSymbol; //can pick any color, but when randomized will be a canon color.
    SpriteLayer rightHorn;
    SpriteLayer fluff;
    SpriteLayer tail;

    @override
    String relativefolder = "images/Homestuck";

    @override
    List<SpriteLayer> get renderingOrderLayers => <SpriteLayer>[tail, extendedHairBack, extendedBody, facePaint, symbol, satyrSymbol, mouth, leftEye, rightEye, glasses, extendedHairTop, fluff, glasses2, rightHorn, leftHorn];

    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[leftEye, rightEye, mouth, symbol, glasses, glasses2,leftHorn, rightHorn, fluff, tail, satyrSymbol, facePaint,extendedBody, extendedHairTop, extendedHairBack];


    @override
    List<SpriteLayer>  get oldDataLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,leftHorn, rightHorn, fluff, tail, satyrSymbol, facePaint,extendedBody, extendedHairTop, extendedHairBack];




    HomestuckSatyrDoll([int sign]) :super() {
        if(sign != null) {
            satyrSymbol.imgNumber = sign;
            //makes sure palette is sign appropriate
            randomize();
        }
    }

    static int randomSignBetween(int minSign, int maxSign) {
        Random rand = new Random();
        int signNumber = rand.nextInt(maxSign - minSign) + minSign;
        return signNumber;
    }

    static int get randomBurgundySign => randomSignBetween(1,24);
    static int get randomBronzeSign => randomSignBetween(25,48);
    static int get randomGoldSign => randomSignBetween(49,72);
    static int get randomLimeSign => randomSignBetween(73,96);
    static int get randomOliveSign => randomSignBetween(97,120);
    static int get randomJadeSign => randomSignBetween(121,144);
    static int get randomTealSign => randomSignBetween(145,168);
    static int get randomCeruleanSign => randomSignBetween(169,192);
    static int get randomIndigoSign => randomSignBetween(193,216);
    static int get randomPurpleSign => randomSignBetween(217,240);
    static int get randomVioletSign => randomSignBetween(241,264);
    static int get randomFuchsiaSign => randomSignBetween(265,288);



    @override
     Palette source_palette = new HomestuckSatyrPalette()
        ..accent = '#FF9B00'
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
        ..eyeBags = "#9d9d9d"
        ..skin = '#ffffff';

    @override
    Palette palette = new HomestuckSatyrPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skin = '#ffffff';

    @override
    Palette purple = new HomestuckSatyrPalette()
        ..accent = '#5b0085'
        ..aspect_light = '#8400a6'
        ..aspect_dark = '#5b0085'
        ..shoe_light = '#5b0085'
        ..shoe_dark = '#4e0063'
        ..cloak_light = '#8400a6'
        ..cloak_mid = '#5b0085'
        ..cloak_dark = '#4e0063'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..eyeBags = '#ae00c8'
        ..skin = '#ffffff';


    @override
    Palette cerulean = new HomestuckSatyrPalette()
        ..accent = '#155e9a'
        ..aspect_light = '#006ec8'
        ..aspect_dark = '#006185'
        ..shoe_light = '#006185'
        ..shoe_dark = '#003462'
        ..cloak_light = '#006ec8'
        ..cloak_mid = '#006185'
        ..cloak_dark = '#003462'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..eyeBags  = "#0a78d2"
        ..skin = '#ffffff';

    @override
    Palette jade = new HomestuckSatyrPalette()
        ..accent = '#008250'
        ..aspect_light = '#00a666'
        ..aspect_dark = '#008543'
        ..shoe_light = '#008543'
        ..shoe_dark = '#005d3a'
        ..cloak_light = '#00a666'
        ..cloak_mid = '#008543'
        ..cloak_dark = '#005d3a'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..eyeBags  = "#00c88c"
        ..skin = '#ffffff';

    @override
    Palette gold = new HomestuckSatyrPalette()
        ..accent = '#856600'
        ..aspect_light = '#a69100'
        ..aspect_dark = '#856600'
        ..shoe_light = '#856600'
        ..shoe_dark = '#714c00'
        ..cloak_light = '#a69100'
        ..cloak_mid = '#856600'
        ..cloak_dark = '#714c00'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..eyeBags  = "#c8bc00"
        ..hair_main = '#000000'
        ..skin = '#ffffff';

    @override
    Palette maroon = new HomestuckSatyrPalette()
        ..accent = '#850022'
        ..aspect_light = '#a60019'
        ..aspect_dark = '#850022'
        ..shoe_light = '#850022'
        ..shoe_dark = '#5c0018'
        ..cloak_light = '#a60019'
        ..cloak_mid = '#850022'
        ..cloak_dark = '#5c0018'
        ..shirt_light = '#ffffff'
        ..shirt_dark = '#000000'
        ..pants_light = '#ffffff'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#000000'
        ..hair_accent = '#aa0000'
        ..eyeBags  = "#c80010"
        ..hair_main = '#000000'
        ..skin = '#ffffff';

    @override
    List<Palette> get validPalettes => <Palette>[maroon, gold, jade, cerulean, purple];
    Map<String, Palette> get validPalettesMap {
        Map<String, Palette> ret  = new Map<String, Palette>();
        ret["SatyrMaroon"] = maroon;
        ret["SatyrGold"] = gold;
        ret["SatyrJade"] = jade;
        ret["SatyrCerulean"] = cerulean;
        ret["SatyrPurple"] = purple;
        return ret;
    }


    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        satyrSymbol = layer("Satyr.SatyrSymbol", "SatyrSymbol/", 0, mb:true);//new SpriteLayer("SatyrSymbol", "$folder/SatyrSymbol/", 0, maxSatyrSymbol, supportsMultiByte: true);
        fluff = layer("Satyr.Fluff", "SatyrFluff/", 1);//new SpriteLayer("Fluff", "$folder/SatyrFluff/", 1, maxFluff);
        tail = layer("Satyr.Tail", "SatyrTail/", 0);//new SpriteLayer("Tail", "$folder/SatyrTail/", 0, maxTail);
        leftHorn = layer("Satyr.LeftHorn", "SatyrLeftHorn/", 1);//new SpriteLayer("LeftHorn", "$folder/SatyrLeftHorn/", 1, maxHorn);
        rightHorn = layer("Satyr.RightHorn", "SatyrRightHorn/", 1);//new SpriteLayer("RightHorn", "$folder/SatyrRightHorn/", 1, maxHorn);
        facePaint = layer("Satyr.FacePattern", "SatyrFacePattern/", 0);//new SpriteLayer("FacePattern","$folder/SatyrFacePattern/", 0, maxFacePattern);
    }

    @override
    void randomize() {
        super.randomize();
        symbol.imgNumber = 0; //blank it out.
    }


    void randomizeColors() {

                if(rand == null) rand = new Random();;
        copyPalette(rand.pickFrom(validPalettes));

    }


}


/// Convenience class for getting/setting aspect palettes
class HomestuckSatyrPalette extends HomestuckPalette {
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
    static String EYE_BAGS = "eyeBags";

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


    Colour get eyeBags => this[EYE_BAGS];

    void set eyeBags(dynamic c) => this.add(EYE_BAGS, _handleInput(c), true);

    Colour get wing2 => this[_WING2];

    void set wing2(dynamic c) => this.add(_WING2, _handleInput(c), true);
}
