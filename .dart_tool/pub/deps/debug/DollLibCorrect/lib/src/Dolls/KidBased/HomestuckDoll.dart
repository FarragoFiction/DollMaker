import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import '../../legacybytebuilder.dart' as OldByteBuilder;
import "../Layers/SpriteLayer.dart";
import "HomestuckTrollDoll.dart";

class HomestuckDoll extends HatchableDoll {

    @override
    int width = 400;
    @override
    int height = 300;
    @override
    int renderingType =1;

    @override
    String name = "Kid";


    @override
    String relativefolder = "images/Homestuck";
    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.
    //final int maxBody = 646;
    final int maxSecretBody = 510; //the legacy limit
    //final int maxHair = 341; //don't go above this yet, but have
    final int maxSecretHair = 254; //old max
    //final int maxEye = 278;
    //final int maxMouth = 281; //actually
    final int maxSecretMouth = 254;
    //final int maxSymbol = 420;  //don't go above this yet, but have
    final int maxSecretSymbol = 254;
    //final int maxGlass = 275;
    //final int maxGlass2 = 310;
    final int maxSecretGlass2 = 254;
    //final int maxFacePaint = 187;

    SpriteLayer body;
    //need extended layers separate to keep  backwards compatibility with old data strings that had a single byte
    SpriteLayer extendedBody;
    SpriteLayer extendedHairTop;
    SpriteLayer extendedHairBack;

    SpriteLayer facePaint;
    SpriteLayer hairTop;
    SpriteLayer hairBack;
    SpriteLayer leftEye;
    SpriteLayer rightEye;
    SpriteLayer mouth;
    SpriteLayer symbol;
    SpriteLayer glasses;
    SpriteLayer glasses2;

    HomestuckDoll() {
        initLayers();
        randomize();
    }

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[extendedHairBack, extendedBody, facePaint,symbol, mouth, leftEye, rightEye, glasses, extendedHairTop, glasses2];

    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[leftEye, rightEye, mouth, symbol, glasses, glasses2,facePaint,extendedBody, extendedHairTop, extendedHairBack];

    @override
    List<SpriteLayer>  get oldDataLayers => <SpriteLayer>[body, hairTop, hairBack, leftEye, rightEye, mouth, symbol, glasses, glasses2,facePaint,extendedBody, extendedHairTop, extendedHairBack];



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
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#ADADAD'
        ..hair_main = '#ffffff'
        ..hair_accent = '#ADADAD'
        ..skin = '#ffffff';

    @override
    void beforeSaving() {
        super.beforeSaving();
        //nothing to do but other dolls might sync old and new parts
        //print("before saving, setting old parts to equal new parts where they can ");

        body.imgNumber = extendedBody.imgNumber%255;
        hairBack.imgNumber = extendedHairBack.imgNumber%255;
        hairTop.imgNumber = extendedHairTop.imgNumber%255;


    }

    @override
    void initLayers() {
        //old layers aren't rendered, but still exist so that data can be parsed
        hairTop = new SpriteLayer("HairOld","$folder/HairTop/", 1, 255, legacy:true);
        hairBack = new SpriteLayer("HairOldBack","$folder/HairBack/", 1, 255, legacy:true);
        //hairTop.syncedWith.add(hairBack);
       // hairBack.slave = true; //can't be selected on it's own

        extendedHairTop = layer("Kid.HairFront", "HairTop/", 1, mb:true, secret:maxSecretHair);
        //extendedHairTop = new SpriteLayer("HairFront","$folder/HairTop/", 1, maxHair, supportsMultiByte: true)..secretMax = maxSecretHair;
        extendedHairBack = layer("Kid.HairBack", "HairBack/", 1, mb:true, secret:maxSecretHair)..slaveTo(extendedHairTop);
        //extendedHairBack = new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[extendedHairTop], supportsMultiByte: true)..secretMax = maxSecretHair;
        //extendedHairTop.syncedWith.add(extendedHairBack);
        //extendedHairBack.slave = true;

        extendedBody = layer("Kid.Body", "Body/", 0, mb:true, secret:maxSecretBody);
        //extendedBody = new SpriteLayer("Body","$folder/Body/", 0, maxBody, supportsMultiByte: true)..secretMax = maxSecretBody;
        body = new SpriteLayer("BodyOld","$folder/Body/", 0, 255, legacy:true);

        facePaint = layer("Kid.FacePaint", "FacePaint/", 0);//new SpriteLayer("FacePaint","$folder/FacePaint/", 0, maxFacePaint);

        symbol = layer("Kid.Symbol", "Symbol/", 1, secret:maxSecretSymbol);//new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol)..secretMax = maxSecretSymbol;
        mouth = layer("Kid.Mouth", "Mouth/", 1, secret:maxSecretMouth);//new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth)..secretMax = maxSecretMouth;
        leftEye = layer("Kid.LeftEye", "LeftEye/", 1);//new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEye)..primaryPartner = false;
        rightEye = layer("Kid.RightEye", "RightEye/", 1)..addPartner(leftEye);//new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEye)..partners.add(leftEye);
        glasses = layer("Kid.Glasses", "Glasses/", 1);//new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlass);
        glasses2 = layer("Kid.Glasses2", "Glasses2/", 0, secret:maxSecretGlass2);//new SpriteLayer("Glasses2","$folder/Glasses2/", 0, maxGlass2)..secretMax = maxSecretGlass2;
    }


    void randomize() {
         randomizeColors();
         randomizeNotColors();
    }

    @override
    void initFromReaderOld(OldByteBuilder.ByteReader reader, [bool layersNeedInit = true]) {
        super.initFromReaderOld(reader, layersNeedInit);
        //print("overwritten load");
        if(extendedBody.imgNumber ==0) extendedBody.imgNumber = body.imgNumber;
        if(extendedHairBack.imgNumber ==0) extendedHairBack.imgNumber = hairBack.imgNumber;
        if(extendedHairTop.imgNumber ==0) extendedHairTop.imgNumber = hairTop.imgNumber;
    }

    void randomizeColors() {
        List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

                if(rand == null) rand = new Random();;
        HomestuckPalette h = palette as HomestuckPalette;
        List<HomestuckPalette> paletteOptions = new List<HomestuckPalette>.from(ReferenceColours.paletteList.values);
        HomestuckPalette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            tackyColors();
        }else {
            copyPalette(newPallete);
        }
        if(newPallete != ReferenceColours.SKETCH) h.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
    }

    void tackyColors() {
                if(rand == null) rand = new Random();;
        HomestuckPalette h = palette as HomestuckPalette;
        palette.add(HomestuckPalette.ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

        palette.add(HomestuckPalette.ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(HomestuckPalette.SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckPalette.SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
        palette.add(HomestuckPalette.PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
        palette.add(HomestuckPalette.HAIR_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

    }
     void randomizeNotColors() {
                 if(rand == null) rand = new Random();;
         int firstEye = -100;
         for(SpriteLayer l in renderingOrderLayers) {
             l.imgNumber = rand.nextInt(l.maxImageNumber+1);
             //keep eyes synced unless player decides otherwise
             if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
             if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
             if(l.imgNumber == 0 && l != body) l.imgNumber = 1;
             if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
         }
         if(rand.nextDouble() > .2) {
             facePaint.imgNumber = 0;
         }
     }



  @override
  Doll hatch() {
      HomestuckTrollDoll newDoll = new HomestuckTrollDoll();
      int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
      newDoll.rand = new Random(seed);
      newDoll.randomize();
      Doll.convertOneDollToAnother(this, newDoll);
      newDoll.randomizeColors();
      (newDoll.palette as HomestuckTrollPalette).skin = HomestuckTrollDoll.skinColor;
      (newDoll.palette as HomestuckTrollPalette).hair_main = HomestuckTrollDoll.hairColor;
      newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.

      (newDoll as HomestuckTrollDoll).mutantEyes(false);
      return newDoll;
  }
}

class CharSheetPalette extends Palette {
    static String _ASPECT_LIGHT = "aspect1";
    Colour get aspect_light => this[_ASPECT_LIGHT];

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

    void set aspect_light(dynamic c) => this.add(_ASPECT_LIGHT, _handleInput(c), true);
}

/// Convenience class for getting/setting aspect palettes
class HomestuckPalette extends Palette {
    static String ACCENT = "accent";
    static String ASPECT_LIGHT = "aspect1";
    static String ASPECT_DARK = "aspect2";
    static String SHOE_LIGHT = "shoe1";
    static String SHOE_DARK = "shoe2";
    static String CLOAK_LIGHT = "cloak1";
    static String CLOAK_MID = "cloak2";
    static String CLOAK_DARK = "cloak3";
    static String SHIRT_LIGHT = "shirt1";
    static String SHIRT_DARK = "shirt2";
    static String PANTS_LIGHT = "pants1";
    static String PANTS_DARK = "pants2";
    static String HAIR_MAIN = "hairMain";
    static String HAIR_ACCENT = "hairAccent";
    static String EYE_WHITE_LEFT = "eyeWhitesLeft";
    static String EYE_WHITE_RIGHT = "eyeWhitesRight";
    static String SKIN = "skin";

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

    Colour get text => this[ACCENT];

    Colour get accent => this[ACCENT];

    void set accent(dynamic c) => this.add(ACCENT, _handleInput(c), true);

    Colour get aspect_light => this[ASPECT_LIGHT];

    void set aspect_light(dynamic c) => this.add(ASPECT_LIGHT, _handleInput(c), true);

    Colour get aspect_dark => this[ASPECT_DARK];

    void set aspect_dark(dynamic c) => this.add(ASPECT_DARK, _handleInput(c), true);

    Colour get shoe_light => this[SHOE_LIGHT];

    void set shoe_light(dynamic c) => this.add(SHOE_LIGHT, _handleInput(c), true);

    Colour get shoe_dark => this[SHOE_DARK];

    void set shoe_dark(dynamic c) => this.add(SHOE_DARK, _handleInput(c), true);

    Colour get cloak_light => this[CLOAK_LIGHT];

    void set cloak_light(dynamic c) => this.add(CLOAK_LIGHT, _handleInput(c), true);

    Colour get cloak_mid => this[CLOAK_MID];

    void set cloak_mid(dynamic c) => this.add(CLOAK_MID, _handleInput(c), true);

    Colour get cloak_dark => this[CLOAK_DARK];

    void set cloak_dark(dynamic c) => this.add(CLOAK_DARK, _handleInput(c), true);

    Colour get shirt_light => this[SHIRT_LIGHT];

    void set shirt_light(dynamic c) => this.add(SHIRT_LIGHT, _handleInput(c), true);

    Colour get shirt_dark => this[SHIRT_DARK];

    void set shirt_dark(dynamic c) => this.add(SHIRT_DARK, _handleInput(c), true);

    Colour get pants_light => this[PANTS_LIGHT];

    void set pants_light(dynamic c) => this.add(PANTS_LIGHT, _handleInput(c), true);

    Colour get pants_dark => this[PANTS_DARK];

    void set pants_dark(dynamic c) => this.add(PANTS_DARK, _handleInput(c), true);

    Colour get hair_main => this[HAIR_MAIN];

    void set hair_main(dynamic c) => this.add(HAIR_MAIN, _handleInput(c), true);

    Colour get hair_accent => this[HAIR_ACCENT];

    void set hair_accent(dynamic c) => this.add(HAIR_ACCENT, _handleInput(c), true);

    Colour get eye_white_left => this[EYE_WHITE_LEFT];

    void set eye_white_left(dynamic c) => this.add(EYE_WHITE_LEFT, _handleInput(c), true);

    Colour get eye_white_right => this[EYE_WHITE_RIGHT];

    void set eye_white_right(dynamic c) => this.add(EYE_WHITE_RIGHT, _handleInput(c), true);

    Colour get skin => this[SKIN];

    void set skin(dynamic c) => this.add(SKIN, _handleInput(c), true);
}



