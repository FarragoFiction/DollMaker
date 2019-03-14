import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";

//MadCreativity championed this one.
class HiveswapDoll extends Doll {

    @override
    String originalCreator = "madCreativity";

    int maxBody = 12;
    int maxEyebrows = 6;
    int maxGlasses = 4;
    int maxFacepaint = 5;
    int maxHorn = 11;
    int maxHair = 19;
    int maxFin = 1;
    int maxEyes = 13;
    int maxMouth =22;

    @override
    String name = "Hiveswap";

    @override
    String relativefolder = "images/Homestuck/Hiveswap";

    SpriteLayer body;
    SpriteLayer glasses;
    SpriteLayer eyebrows;
    SpriteLayer leftEye;
    SpriteLayer rightEye;
    SpriteLayer hairTop;
    SpriteLayer hairBack;
    SpriteLayer leftHorn;
    SpriteLayer rightHorn;
    SpriteLayer mouth;
    SpriteLayer leftFin;
    SpriteLayer rightFin;
    SpriteLayer facepaint;




    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body,facepaint, rightFin, eyebrows,leftEye,rightEye,mouth, glasses,hairTop,leftHorn, rightHorn,leftFin];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body,eyebrows,leftEye, rightEye,hairBack,hairTop,leftHorn, rightHorn,mouth,leftFin,rightFin,glasses, facepaint];

    @override
    int width = 900;
    @override
    int height = 1000;

    @override
    int renderingType =14; //hiveswap release date is 9/14

    @override
    Palette paletteSource = new HiveswapTrollPalette()
        ..skin = '#C947FF'
        ..eye_white_left = '#5D52DE'
        ..eye_white_right = '#D4DE52'
        ..accent = "#9130BA"
        ..shirt_dark = "#3957C8"
        ..pants_light = "#6C47FF"
        ..pants_dark = "#87FF52"
        ..shoe_light = "#5CDAFF"
        ..hair_main = "#5FDE52"
        ..aspect_light = '#ff0000'
        ..aspect_dark = '#6a0000'
        ..wing1 = '#00ff00'
        ..wing2 = '#0000a9'
        ..shoe_dark = '#387f94'
        ..cloak_light = '#ffa800'
        ..cloak_mid = '#876a33'
        ..cloak_dark = '#3b2e15'
        ..hair_accent = '#2a5f25'
        ..shirt_light = '#3358FF';

    @override
    Palette palette = new HiveswapTrollPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..wing1 = '#FF9B00'
        ..wing2 = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#151515'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..eye_white_left = '#ffba29'
        ..eye_white_right = '#ffba29'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#aa0000'
        ..hair_main = '#151515'
        ..skin = '#C4C4C4';

    HiveswapDoll() {
        initLayers();
        randomize();
    }



    @override
    void setQuirk() {
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;        Random rand  = new Random(seed);
        quirkButDontUse = Quirk.randomTrollQuirk(rand);
    }


    String chooseBlood(Random rand) {
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];
        String chosenBlood = rand.pickFrom(bloodColors);
        return chosenBlood;
    }

    @override
    void randomize([bool chooseSign = true]) {
                if(rand == null) rand = new Random();;
        int firstEye = -100;
        int firstHorn = -100;

        //canonSymbol.imgNumber = maxCanonSymbol;

        String chosenBlood = chooseBlood(rand);
        for (SpriteLayer l in renderingOrderLayers) {
                //don't have wings normally
                if (!l.imgNameBase.contains("Wings")) l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
                //keep eyes synced unless player decides otherwise
                if (l.imgNameBase.contains("Eye")) {
                    if (firstEye < 0) {
                        firstEye = l.imgNumber;
                    } else {
                        l.imgNumber = firstEye;
                    }
                }

                if (l.imgNameBase.contains("Horn")) {
                    if (firstHorn < 0) {
                        firstHorn = l.imgNumber;
                    } else {
                        l.imgNumber = firstHorn;
                    }
                }

                avoidBlank();
                if (l.imgNameBase.contains("Fin")) {
                    //"#610061", "#99004d"
                    if (chosenBlood == "#610061" || chosenBlood == "#99004d") {
                        l.imgNumber = 1;
                    } else {
                        l.imgNumber = 0;
                    }
                }
                if (l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }

        HiveswapTrollPalette h = palette as HiveswapTrollPalette;
        palette.add(HiveswapTrollPalette._ACCENT, new Colour.fromStyleString("#969696"), true);
        palette.add(HiveswapTrollPalette._ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

        palette.add(HiveswapTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        // palette.add(HomestuckTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        // palette.add(HomestuckTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HiveswapTrollPalette._CLOAK_LIGHT, new Colour.from(h.aspect_light), true);
        palette.add(HiveswapTrollPalette._CLOAK_DARK, new Colour.from(h.aspect_dark),true);
        palette.add(HiveswapTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HiveswapTrollPalette._WING1, new Colour.fromStyleString(chosenBlood), true);
        palette.add(HiveswapTrollPalette._WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value/2), true);
        palette.add(HiveswapTrollPalette._HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);

        if(rand.nextDouble() > .2) {
            facepaint.imgNumber = 0;
        }
    }

    void avoidBlank() {
        if(mouth.imgNumber == 0) mouth.imgNumber = 1;
        if(leftEye.imgNumber == 0) leftEye.imgNumber = 1;
        if(leftHorn.imgNumber == 0) leftHorn.imgNumber = 1;
        if(rightEye.imgNumber == 0) rightEye.imgNumber = 1;
        if(rightHorn.imgNumber == 0) rightHorn.imgNumber = 1;
    }


    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        int firstEye = -100;
        int firstHorn = -100;
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

        String chosenBlood = rand.pickFrom(bloodColors);
        for (SpriteLayer l in renderingOrderLayers) {
            //don't have wings normally
            if (!l.imgNameBase.contains("Wings")) l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
            //keep eyes synced unless player decides otherwise
            if (l.imgNameBase.contains("Eye")) {
                if (firstEye < 0) {
                    firstEye = l.imgNumber;
                } else {
                    l.imgNumber = firstEye;
                }
            }

            if (l.imgNameBase.contains("Horn")) {
                if (firstHorn < 0) {
                    firstHorn = l.imgNumber;
                } else {
                    l.imgNumber = firstHorn;
                }
            }

            avoidBlank();
            if (l.imgNameBase.contains("Fin")) {
                //"#610061", "#99004d"
                if (chosenBlood == "#610061" || chosenBlood == "#99004d") {
                    l.imgNumber = 1;
                } else {
                    l.imgNumber = 0;
                }
            }
            if (l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }

    }

    @override
    void randomizeColors() {
                if(rand == null) rand = new Random();;
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

        String chosenBlood = rand.pickFrom(bloodColors);
        HiveswapTrollPalette h = palette as HiveswapTrollPalette;


        palette.add(HiveswapTrollPalette._ACCENT, new Colour.fromStyleString("#969696"), true);
        palette.add(HiveswapTrollPalette._ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

        palette.add(HiveswapTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value / 2), true);
        palette.add(HiveswapTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HiveswapTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value / 2), true);
        palette.add(HiveswapTrollPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HiveswapTrollPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value / 2), true);
        palette.add(HiveswapTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value * 3), true);
        palette.add(HiveswapTrollPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HiveswapTrollPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value / 2), true);
        palette.add(HiveswapTrollPalette._WING1, new Colour.fromStyleString(chosenBlood), true);
        palette.add(HiveswapTrollPalette._WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value / 2), true);
        palette.add(HiveswapTrollPalette._HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);
    }


    @override
    void initLayers() {
        hairTop = layer("Hiveswap.HairFront", "HairTop/", 1);//new SpriteLayer("HairFront","$folder/HairTop/", 1, maxHair);
        hairBack = layer("Hiveswap.HairBack", "HairBack/", 1)..slaveTo(hairTop);//new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[hairTop]);
        //hairTop.syncedWith.add(hairBack);
        //hairBack.slave = true; //can't be selected on it's own

        leftFin = layer("Hiveswap.LeftFin", "LeftFin/", 1);//new SpriteLayer("LeftFin", "$folder/LeftFin/", 1, maxFin);
        rightFin = layer("Hiveswap.RightFin", "RightFin/", 1)..slaveTo(leftFin);//new SpriteLayer("RightFin", "$folder/RightFin/", 1, maxFin, syncedWith: <SpriteLayer>[leftFin]);
        //leftFin.syncedWith.add(rightFin);
        //rightFin.slave = true; //can't be selected on it's own

        body = layer("Hiveswap.Body", "Body/", 1);//new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
        glasses = layer("Hiveswap.Glasses", "Glasses/", 1);//new SpriteLayer("Glasses", "$folder/Glasses/", 1, maxGlasses);
        facepaint = layer("Hiveswap.FacePaint", "Facepaint/", 1);//new SpriteLayer("FacePaint", "$folder/Facepaint/", 1, maxFacepaint);


        eyebrows = layer("Hiveswap.EyeBrows", "Eyebrows/", 1);//new SpriteLayer("EyeBrows", "$folder/Eyebrows/", 1, maxEyebrows);
        leftEye = layer("Hiveswap.LeftEye", "LeftEye/", 1);//new SpriteLayer("LeftEye", "$folder/LeftEye/", 1, maxEyes)..primaryPartner = false;
        rightEye = layer("Hiveswap.RightEye", "RightEye/", 1)..addPartner(leftEye);//new SpriteLayer("RightEye", "$folder/RightEye/", 1, maxEyes)..partners.add(leftEye);
        leftHorn = layer("Hiveswap.LeftHorn", "LeftHorn/", 1);//new SpriteLayer("LeftHorn", "$folder/LeftHorn/", 1, maxHorn)..primaryPartner = false;
        rightHorn = layer("Hiveswap.RightHorn", "RightHorn/", 1)..addPartner(leftHorn);//new SpriteLayer("RightHorn", "$folder/RightHorn/", 1, maxHorn)..partners.add(leftHorn);
        mouth = layer("Hiveswap.Mouth", "Mouth/", 1);//new SpriteLayer("Mouth", "$folder/Mouth/", 1, maxMouth);
    }

}




/// Convenience class for getting/setting aspect palettes
class HiveswapTrollPalette extends HomestuckPalette {
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

