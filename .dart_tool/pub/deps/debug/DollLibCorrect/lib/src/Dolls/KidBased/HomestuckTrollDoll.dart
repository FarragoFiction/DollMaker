import "../../../DollRenderer.dart";
import "../../Rendering/ReferenceColors.dart";
import "../../commonImports.dart";
import '../../legacybytebuilder.dart' as OldByteBuilder;
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckTrollDoll extends HomestuckDoll {

    static String BURGUNDY = "Burgundy";
    static String BRONZE = "Bronze";
    static String GOLD = "Gold";
    static String LIME = "Lime";
    static String MUTANT = "Mutant";
    static String OLIVE = "Olive";
    static String JADE = "Jade";
    static String TEAL = "Teal";
    static String CERULEAN = "Cerulean";
    static String INDIGO = "Indigo";
    static String PURPLE = "Purple";
    static String VIOLET = "Violet";
    static String FUCHSIA = "Fuchsia";

    static String skinColor = "#C4C4C4";
    static String hairColor = "#000000";

    @override
    String name = "Troll";

    @override
    int renderingType = 2;
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    //these bodies look terrible with troll signs. if any of these use 47,48, or 49
    List<int> bannedRandomBodies = Doll.dataValue("Troll.bannedBodies");//<int>[238,252,256,259,235,226,227,230,96,219,221,223,5,11,14,43,50,59,65,66,67,70,72,75,74,98,100,101,102,106,107,109,63,17];
    //if a troll or grub has these eyes, they will be mutant
    List<int> mutantEyeList = Doll.dataValue("Troll.mutantEyes");//<int>[2,11,31,44,46,47,85];
    int defaultBody = Doll.dataValue("Troll.defaultBody", 0); //48;
    //int maxHorn = 347;
    int maxSecretHorn = 314;
    //int maxFin = 26;
    //int maxCanonSymbol = 288; //288 eventually
    int maxSecretCanonSymbol = 288;
    //int maxWing = 78;

    SpriteLayer leftHorn;
    SpriteLayer canonSymbol; //can pick any color, but when randomized will be a canon color.
    SpriteLayer rightHorn;
    SpriteLayer extendedLeftHorn;
    SpriteLayer extendedRightHorn;

    SpriteLayer leftFin;
    SpriteLayer rightFin;
    SpriteLayer wings;

    @override
    String relativefolder = "images/Homestuck";

    @override
    List<SpriteLayer> get renderingOrderLayers => <SpriteLayer>[wings, extendedHairBack, rightFin, extendedBody, facePaint, symbol, canonSymbol, mouth, leftEye, rightEye, glasses, extendedHairTop, leftFin, glasses2, extendedRightHorn, extendedLeftHorn];


    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[leftEye, rightEye, mouth, symbol, glasses, glasses2, leftFin, rightFin, wings, canonSymbol, facePaint, extendedBody, extendedHairTop, extendedHairBack, extendedLeftHorn, extendedRightHorn];

    @override
    List<SpriteLayer>  get oldDataLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,leftHorn, rightHorn, leftFin, rightFin, wings, canonSymbol, facePaint, extendedBody, extendedHairTop, extendedHairBack, extendedLeftHorn, extendedRightHorn];


    HomestuckTrollDoll([int sign]) :super() {
        if(sign != null) {
            canonSymbol.imgNumber = sign;
            //makes sure palette is sign appropriate
            randomize(false);
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


    static int casteToRandomSign(String caste) {
        if(caste == HomestuckTrollDoll.BURGUNDY) {
            return HomestuckTrollDoll.randomBurgundySign;
        }else if(caste == HomestuckTrollDoll.BRONZE) {
            return HomestuckTrollDoll.randomBronzeSign;
        }else if(caste == HomestuckTrollDoll.GOLD) {
            return HomestuckTrollDoll.randomGoldSign;
        }else if(caste == HomestuckTrollDoll.LIME) {
            return HomestuckTrollDoll.randomLimeSign;
        }else if(caste == HomestuckTrollDoll.OLIVE) {
            return HomestuckTrollDoll.randomOliveSign;
        }else if(caste == HomestuckTrollDoll.JADE) {
            return HomestuckTrollDoll.randomJadeSign;
        }else if(caste == HomestuckTrollDoll.TEAL) {
            return HomestuckTrollDoll.randomTealSign;
        }else if(caste == HomestuckTrollDoll.CERULEAN) {
            return HomestuckTrollDoll.randomCeruleanSign;
        }else if(caste == HomestuckTrollDoll.INDIGO) {
            return HomestuckTrollDoll.randomIndigoSign;
        }else if(caste == HomestuckTrollDoll.PURPLE) {
            return HomestuckTrollDoll.randomPurpleSign;
        }else if(caste == HomestuckTrollDoll.VIOLET) {
            return HomestuckTrollDoll.randomVioletSign;
        }else if(caste == HomestuckTrollDoll.FUCHSIA) {
            return HomestuckTrollDoll.randomFuchsiaSign;
        }

        return 0;
    }



    @override
    Palette paletteSource = ReferenceColours.TROLL_PALETTE;

    @override
    Palette palette = new HomestuckTrollPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..eye_white_left = '#ffba29'
        ..eye_white_right = '#ffba29'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skin = '#C4C4C4';

    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        canonSymbol = layer("Troll.CanonSymbol", "CanonSymbol/", 0, mb:true, secret:maxSecretCanonSymbol);//new SpriteLayer("CanonSymbol", "$folder/CanonSymbol/", 0, maxCanonSymbol, supportsMultiByte: true)..secretMax = 288;
        leftFin = layer("Troll.FinLeft", "LeftFin/", 1);//new SpriteLayer("FinLeft", "$folder/LeftFin/", 1, maxFin);
        rightFin = layer("Troll.FinRight", "RightFin/", 1)..slaveTo(leftFin);//new SpriteLayer("FinRight", "$folder/RightFin/", 1, maxFin, syncedWith: <SpriteLayer>[leftFin]);
        //leftFin.syncedWith.add(rightFin);
        //rightFin.slave = true; //can't be selected on it's own

        wings = layer("Troll.Wings", "Wings/", 0);//new SpriteLayer("Wings", "$folder/Wings/", 0, maxWing);
        leftHorn = new SpriteLayer("LeftHornOld", "$folder/LeftHorn/", 1, 255, legacy:true);
        rightHorn = new SpriteLayer("RightHornOld", "$folder/RightHorn/", 1, 255, legacy:true);
        extendedRightHorn = layer("Troll.RightHorn", "RightHorn/", 1, mb:true, secret:maxSecretHorn);//new SpriteLayer("RightHorn", "$folder/RightHorn/", 1, maxHorn, supportsMultiByte: true)..primaryPartner = false..secretMax = maxSecretHorn;
        extendedLeftHorn = layer("Troll.LeftHorn", "LeftHorn/", 1, mb:true, secret:maxSecretHorn)..addPartner(extendedRightHorn);//new SpriteLayer("LeftHorn", "$folder/LeftHorn/", 1, maxHorn, supportsMultiByte: true)..partners.add(extendedRightHorn)..secretMax = maxSecretHorn;

    }

    static List<String> get castes {
        return <String>[BURGUNDY, BRONZE, GOLD, LIME, OLIVE, JADE, TEAL, CERULEAN, INDIGO, PURPLE, VIOLET, FUCHSIA,MUTANT];
    }

    String get bloodColor {
        return bloodColorToWord((palette as HomestuckPalette).aspect_light);
    }

     String bloodColorToWord(Colour color) {
        List<String> bloodColors = <String>["#A10000", "#A25203", "#A1A100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021CB", "#631DB4", "#610061", "#99004D","#ff0000"];
        if(bloodColors.contains(color.toStyleString())) {
            return castes[bloodColors.indexOf(color.toStyleString())];
        }else {
            return MUTANT;
        }
    }

    @override
    String toDataBytesX([ByteBuilder builder = null]) {
        if (dollName == null || dollName.isEmpty) dollName = "${bloodColor} Blooded ${name}";
        return super.toDataBytesX(builder);
    }

    String chooseBlood(Random rand, [bool forceMutant = false]) {
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

        String chosenBlood = rand.pickFrom(bloodColors);
        if(canonSymbol.imgNumber <= 24) {
            chosenBlood = bloodColors[0];
        }else if(canonSymbol.imgNumber <= 24*2) {
            chosenBlood = bloodColors[1];
        }else if(canonSymbol.imgNumber <= 24*3) {
            chosenBlood = bloodColors[2];
        }else if(canonSymbol.imgNumber <= 24*4) {
            chosenBlood = bloodColors[3];
        }else if(canonSymbol.imgNumber <= 24*5) {
            chosenBlood = bloodColors[4];
        }else if(canonSymbol.imgNumber <= 24*6) {
            chosenBlood = bloodColors[5];
        }else if(canonSymbol.imgNumber <= 24*7) {
            chosenBlood = bloodColors[6];
        }else if(canonSymbol.imgNumber <= 24*8) {
            chosenBlood = bloodColors[7];
        }else if(canonSymbol.imgNumber <= 24*9) {
            chosenBlood = bloodColors[8];
        }else if(canonSymbol.imgNumber <= 24*10) {
            chosenBlood = bloodColors[9];
        }else if(canonSymbol.imgNumber <= 24*11) {
            chosenBlood = bloodColors[10];
        }else if(canonSymbol.imgNumber <= 24*12) {
            chosenBlood = bloodColors[11];
        }
        //it's just random if it somehow doesn't fit
        if((bloodColorToWord(new Colour.fromStyleString(chosenBlood)) == LIME && rand.nextDouble() > .9) || forceMutant) {
            chosenBlood = "#FF0000"; //mutant blood
        }

        return chosenBlood;
    }

    @override
    Doll hatch() {
        HomestuckDoll newDoll = new HomestuckDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.randomizeColors();
        (newDoll.palette as HomestuckPalette).skin = "#ffffff";
        (newDoll.palette as HomestuckPalette).eye_white_right = "#ffffff";
        (newDoll.palette as HomestuckPalette).eye_white_left = "#ffffff";

        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        return newDoll;
    }

    @override
    void setQuirk() {
        Random rand2  = new Random(seed);
        quirkButDontUse = Quirk.randomTrollQuirk(rand2);
    }


    void mutantWings([bool force = false]) {
        //print("force wing is $force");
        if(rand == null) rand = new Random(hairBack.imgNumber);
        rand.nextInt(); //init
       // print("checking wings");
        if(rand.nextDouble() > 0.99 || force) { //1 in a 100 will have them.
            //print("Red bull gives you WINGS!!!");
            wings.imgNumber = rand.nextInt(wings.maxImageNumber + 1);
        }
    }

    void mutantEyes([bool force = false, bool older = false]) {
        //print("force eyes is $force");
        // print("checking for mutant eyes for ${leftEye.imgNumber} and ${rightEye.imgNumber}");
        if(rand == null) rand = new Random(hairBack.imgNumber);


        if(force) {
            leftEye.imgNumber = rand.pickFrom(mutantEyeList);
            rightEye.imgNumber = leftEye.imgNumber;
        }
        if(mutantEyeList.contains(leftEye.imgNumber) || mutantEyeList.contains(rightEye.imgNumber)) {
            //print("I'm gonna make a mutant eye!!!");
            String bothRandom = "br";
            String bothAccent = "ba";
            String accentRandom = "ar";
            String randomAccent = "ra";
            String aspectAccent = 'aa';
            String accentAsspect = "AA2";
            HomestuckPalette hp = palette as HomestuckPalette;
            List<String> possibilities = <String>[bothRandom, bothAccent, accentRandom, randomAccent, aspectAccent, accentAsspect];
            String choice = rand.pickFrom(possibilities);
            if(choice == bothRandom) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
            }else if(choice == bothAccent) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, hp.accent, true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, hp.accent, true);
            }else if(choice == accentRandom) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, hp.accent, true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
            }else if(choice == randomAccent) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, hp.accent, true);
            }else if(choice == aspectAccent) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, hp.aspect_light, true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, hp.accent, true);
            }else if(choice == accentAsspect) {
                palette.add(HomestuckPalette.EYE_WHITE_LEFT, hp.accent, true);
                palette.add(HomestuckPalette.EYE_WHITE_RIGHT, hp.aspect_light, true);
            }
        }else {
            //this will fix the eyes failing to randomize
           // print("generating regular eyes");
            regularEyes(older);
        }

    }

    @override
    void initFromReaderOld(OldByteBuilder.ByteReader reader, [bool layersNeedInit = true]) {
        super.initFromReaderOld(reader, layersNeedInit);
        if(extendedRightHorn.imgNumber ==0) extendedRightHorn.imgNumber = rightHorn.imgNumber;
        if(extendedLeftHorn.imgNumber ==0) extendedLeftHorn.imgNumber = leftHorn.imgNumber;
    }

    @override
    void beforeSaving() {
        super.beforeSaving();
        //nothing to do but other dolls might sync old and new parts
        //print("old left horn was ${ leftHorn.imgNumber} should now be ${extendedLeftHorn.imgNumber%255}");
        leftHorn.imgNumber = extendedLeftHorn.imgNumber%255;
        rightHorn.imgNumber = extendedRightHorn.imgNumber%255;

    }

    void regularEyes(older) {
        palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#ffba29"), true);
        palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#ffba29"), true);
    }

    @override
    void randomize([bool chooseSign = true]) {
        if(rand == null) rand = new Random();
        int firstEye = -100;
        int firstHorn = -100;

        if(chooseSign)canonSymbol.imgNumber = rand.nextInt(canonSymbol.maxImageNumber)+1; //don't be zero
        //canonSymbol.imgNumber = maxCanonSymbol;

        String chosenBlood = chooseBlood(rand);
        //print("choose blood $chosenBlood");
        for (SpriteLayer l in renderingOrderLayers) {
            if (l == canonSymbol) {
                //ignore already chosen so i could get blood color
            } else {
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

                if (l.imgNumber == 0 && !l.imgNameBase.contains("Fin") && !l.imgNameBase.contains("Wings")) l.imgNumber = 1;
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
        symbol.imgNumber = 0; //no more regular layer.
        if(bannedRandomBodies.contains(body.imgNumber)) body.imgNumber = defaultBody;

        HomestuckTrollPalette h = palette as HomestuckTrollPalette;
        palette.add(HomestuckTrollPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

        palette.add(HomestuckTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
       // palette.add(HomestuckTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
       // palette.add(HomestuckTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckTrollPalette._CLOAK_LIGHT, new Colour.from(h.aspect_light), true);
        palette.add(HomestuckTrollPalette._CLOAK_DARK, new Colour.from(h.aspect_dark),true);
        palette.add(HomestuckTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckTrollPalette._WING1, new Colour.fromStyleString(chosenBlood), true);
        palette.add(HomestuckTrollPalette._WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value/2), true);
        palette.add(HomestuckTrollPalette._HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);
        if(rand.nextDouble() > .2) {
            facePaint.imgNumber = 0;
        }

        mutantEyes();
        mutantWings();
    }


    @override
    void randomizeNotColors() {
        if(rand == null) rand = new Random();
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

            if (l.imgNumber == 0 && !l.imgNameBase.contains("Fin") && !l.imgNameBase.contains("Wings")) l.imgNumber = 1;
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
        symbol.imgNumber = 0; //no more regular layer.
        if(bannedRandomBodies.contains(body.imgNumber)) body.imgNumber = defaultBody;
        if(rand.nextDouble() > .2) {
            facePaint.imgNumber = 0;
        }
        mutantWings();
    }

    @override
    void randomizeColors() {
        if(rand == null) rand = new Random();
        List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

        String chosenBlood = rand.pickFrom(bloodColors);
        HomestuckTrollPalette h = palette as HomestuckTrollPalette;

        palette.add(HomestuckTrollPalette._ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

        palette.add(HomestuckTrollPalette._ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value / 2), true);
        palette.add(HomestuckTrollPalette._SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value / 2), true);
        palette.add(HomestuckTrollPalette._CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value / 2), true);
        palette.add(HomestuckTrollPalette._CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value * 3), true);
        palette.add(HomestuckTrollPalette._PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckTrollPalette._PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value / 2), true);
        palette.add(HomestuckTrollPalette._WING1, new Colour.fromStyleString(chosenBlood), true);
        palette.add(HomestuckTrollPalette._WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value / 2), true);
        palette.add(HomestuckTrollPalette._HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);
        mutantEyes();
        (palette as HomestuckPalette)..pants_light = '#4b4b4b'
            ..shirt_light = '#111111'
            ..shirt_dark = '#000000'
            ..pants_dark = '#3a3a3a';
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
