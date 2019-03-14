import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";



class OpenBoundDoll extends Doll{

  @override
  String originalCreator = "NER0";

  @override
  int renderingType =21;

  @override
  int width = 160;
  @override
  int height = 137;

  @override
  String name = "OpenBound";

  @override
  String relativefolder = "images/Homestuck/OpenBound";
  final int maxAccessory = 15;
  final int maxBody = 40;
  final int maxCape = 8;
  final int maxEye = 8;
  final int maxFin = 1;
  final int maxHair = 33;
  final int maxHorn = 14;
  final int maxMouth = 7;
  final int maxSymbol = 21;



  SpriteLayer accessory;
  SpriteLayer glasses;
  SpriteLayer body;
  SpriteLayer cape;
  SpriteLayer leftEye;
  SpriteLayer rightEye;
  SpriteLayer leftFin;
  SpriteLayer rightFin;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer leftHorn;
  SpriteLayer rightHorn;
  SpriteLayer mouth;
  SpriteLayer symbol;


  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, cape, body, mouth, rightEye, leftEye, glasses, hairFront,rightFin, leftFin, accessory, rightHorn, leftHorn, symbol];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, cape, rightFin, body, mouth, rightEye, leftEye, glasses, hairFront, leftFin, accessory, rightHorn, leftHorn, symbol];

  @override
  Palette paletteSource = new OpenBoundPalette();

  @override
  Palette palette = new OpenBoundPalette();


  OpenBoundDoll() {
    initPalette();
    initLayers();
    randomize();
  }

  void initPalette() {
    for(NCP ncp in OpenBoundPalette.sourceColors) {
      ncp.addToPalette(paletteSource);
      ncp.addToPalette(palette);
    }
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
    if(rand == null) rand = new Random();
    //todo have versions of the major palettes for this.
    //have doll builder know to pick default palettes depending on palette lengths
    List<Palette> paletteOptions = new List<Palette>();
    Palette newPallete = rand.pickFrom(paletteOptions);
    tackyColors();
  }



  void tackyColors() {
    OpenBoundPalette o = palette as OpenBoundPalette;
    //pick random colors for each of the main things, then make their related colors slightly darker
    //coat
    palette.add(OpenBoundPalette.COATLIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.COATLIGHT, <String>[OpenBoundPalette.COATLIGHT1, OpenBoundPalette.COATLIGHT2, OpenBoundPalette.COATLIGHTOUTLINE]);
    //shirt
    palette.add(OpenBoundPalette.SHIRTLIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.SHIRTLIGHT, <String>[OpenBoundPalette.SHIRTLIGHT1, OpenBoundPalette.SHIRTLIGHT2, OpenBoundPalette.SHIRTLIGHTOUTLINE]);

    //pants
    palette.add(OpenBoundPalette.PANTSLIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.PANTSLIGHT, <String>[OpenBoundPalette.PANTSLIGHT1, OpenBoundPalette.PANTSLIGHT2, OpenBoundPalette.PANTSLIGHTOUTLINE]);

    //shoes
    palette.add(OpenBoundPalette.SHOESLIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.SHOESLIGHT, <String>[OpenBoundPalette.SHOESLIGHT1, OpenBoundPalette.SHOESLIGHTOUTLINE]);

    //accent
    palette.add(OpenBoundPalette.ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.ACCENT, <String>[OpenBoundPalette.ACCENT1, OpenBoundPalette.ACCENT2, OpenBoundPalette.ACCENTOUTLINE]);

    //hair
    palette.add(OpenBoundPalette.HAIR, new Colour.fromStyleString("#333333"),true);
    makeOtherColorsDarker(o, OpenBoundPalette.HAIR, <String>[OpenBoundPalette.HAIR1, OpenBoundPalette.HAIR2]);

    //skin
    //skip this, it's fine

    //troll color
    palette.add(OpenBoundPalette.SKIN, new Colour.fromStyleString("#c4c4c4"),true);
    makeOtherColorsDarker(o, OpenBoundPalette.SKIN, <String>[OpenBoundPalette.SKIN1, OpenBoundPalette.SKIN2]);
    //aspect
    palette.add(OpenBoundPalette.ASPECT1, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
    makeOtherColorsDarker(o, OpenBoundPalette.ASPECT1, <String>[OpenBoundPalette.ASPECT2]);

    //eye left
    //skip this
    //eye right
    //skip this
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }

    if(leftEye.imgNumber ==0) leftEye.imgNumber = 1;
    if(mouth.imgNumber ==0) mouth.imgNumber = 1;
    rightHorn.imgNumber = leftHorn.imgNumber;
    rightEye.imgNumber = leftEye.imgNumber;

  }


  @override
  void initLayers() {

    {

      hairFront = layer("OpenBound.HairFront", "HairFront/", 1, mb:true);//new SpriteLayer("Hair","$folder/HairFront/", 1, maxHair, supportsMultiByte: true);
      hairBack = layer("OpenBound.HairBack", "HairBack/", 1, mb:true)..slaveTo(hairFront);//new SpriteLayer("Hair","$folder/HairBack/", 1, maxHair, syncedWith:<SpriteLayer>[hairFront], supportsMultiByte: true);
      //hairFront.syncedWith.add(hairBack);
      //hairBack.slave = true;

      leftFin = layer("OpenBound.FinLeft", "FinLeft/", 1, mb:true);//new SpriteLayer("Fin", "$folder/FinLeft/", 1, maxFin,supportsMultiByte: true);
      rightFin = layer("OpenBound.FinRight", "FinRight/", 1, mb:true)..slaveTo(leftFin);//new SpriteLayer("Fin", "$folder/FinRight/", 1, maxFin, syncedWith: <SpriteLayer>[leftFin],supportsMultiByte: true);
      //leftFin.syncedWith.add(rightFin);
      //rightFin.slave = true; //can't be selected on it's own

      body = layer("OpenBound.Body", "Body/", 0, mb:true);//new SpriteLayer("Body","$folder/Body/", 0, maxBody, supportsMultiByte: true);
      cape = layer("OpenBound.Cape", "Cape/", 1, mb:true);//new SpriteLayer("Cape","$folder/Cape/", 1, maxCape, supportsMultiByte: true);
      mouth = layer("OpenBound.Mouth", "Mouth/", 1, mb:true);//new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth, supportsMultiByte: true);
      leftEye = layer("OpenBound.EyeLeft", "EyeLeft/", 1, mb:true);//new SpriteLayer("Eye","$folder/EyeLeft/", 1, maxEye, supportsMultiByte: true);
      rightEye = layer("OpenBound.EyeRight", "EyeRight/", 1, mb:true);//new SpriteLayer("Eye","$folder/EyeRight/", 1, maxEye, supportsMultiByte: true);
      glasses = layer("OpenBound.Accessory", "Accessory/", 1, mb:true);//new SpriteLayer("Accessory","$folder/Accessory/", 1, maxAccessory, supportsMultiByte: true);
      accessory = layer("OpenBound.Accessory2", "Accessory/", 1, mb:true);//new SpriteLayer("Accessory2","$folder/Accessory/", 1, maxAccessory, supportsMultiByte: true);
      leftHorn = layer("OpenBound.HornLeft", "HornLeft/", 1, mb:true);//new SpriteLayer("Horns","$folder/HornLeft/", 1, maxHorn, supportsMultiByte: true);
      rightHorn = layer("OpenBound.HornRight", "HornRight/", 1, mb:true);//new SpriteLayer("Horns","$folder/HornRight/", 1, maxHorn, supportsMultiByte: true);
      symbol = layer("OpenBound.Symbol", "Symbol/", 1, mb:true);//new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol, supportsMultiByte: true);

    }
  }

}


/// Convenience class for getting/setting aspect palettes
class OpenBoundPalette extends Palette {

  //when changing color if you change main auto change 1,2,3,outline etc?

  static String COATLIGHT = "coat";
  static String COATLIGHT1 = "coat1";
  static String COATLIGHT2 = "coat2";
  static String COATLIGHTOUTLINE = "coatOutline";

  static String SHIRTLIGHT = "shirt";
  static String SHIRTLIGHT1 = "shirt1";
  static String SHIRTLIGHT2 = "shirt2";
  static String SHIRTLIGHTOUTLINE = "shirtOutline";

  static String PANTSLIGHT = "pants";
  static String PANTSLIGHT1 = "pants1";
  static String PANTSLIGHT2 = "pants2";
  static String PANTSLIGHTOUTLINE = "pantsOutline";

  static String SHOESLIGHT = "shoes";
  static String SHOESLIGHT1 = "shoes1";
  static String SHOESLIGHTOUTLINE = "shoesOutline";

  static String ACCENT = "accent";
  static String ACCENT1 = "accent1";
  static String ACCENT2 = "accent2";
  static String ACCENTOUTLINE = "accentOutline";

  static String HAIR = "hair";
  static String HAIR1 = "hair1";
  static String HAIR2 = "hair2";

  static String SKIN = "skin";
  static String SKIN1 = "skin1";
  static String SKIN2 = "skin2";
  static String SKINOUTLINE = "skinOutline";

  static String ASPECT1 = "aspect";
  static String ASPECT2 = "aspect1";

  static String EYELEFT = "eyeLeft";
  static String EYELEFTGLOW1 = "eyeLeftGlow";
  static String EYELEFTGLOW2 = "eyeLeftGlow1";
  static String EYELEFTGLOW3 = "eyeLeftGlow2";
  static String EYELEFTGLOW4 = "eyeLeftGlow3";

  static String EYERIGHT = "eyeRight";
  static String EYERIGHTGLOW1 = "eyeRightGlow";
  static String EYERIGHTGLOW2 = "eyeRightGlow1";
  static String EYERIGHTGLOW3 = "eyeRightGlow2";
  static String EYERIGHTGLOW4 = "eyeRightGlow3";


  //default colors are
  static List<NCP> sourceColors = <NCP>[new NCP(COATLIGHT,"#ff4e1b"),new NCP(COATLIGHT1,"#da4115"),new NCP(COATLIGHT2,"#ca3c13"),new NCP(COATLIGHTOUTLINE,"#bc3008")]
    ..addAll(<NCP>[new NCP(SHIRTLIGHT,"#ff892e"),new NCP(SHIRTLIGHT1,"#fa802a"),new NCP(SHIRTLIGHT2,"#f16f23"),new NCP(SHIRTLIGHTOUTLINE,"#cc5016")])
    ..addAll(<NCP>[new NCP(PANTSLIGHT,"#e76700"),new NCP(PANTSLIGHT1,"#cc5c00"),new NCP(PANTSLIGHT2,"#c05600"),new NCP(PANTSLIGHTOUTLINE,"#984400")])
    ..addAll(<NCP>[new NCP(SHOESLIGHT,"#12e5fb"),new NCP(SHOESLIGHT1,"#00abf8"),new NCP(SHOESLIGHTOUTLINE,"#0061c7")])
    ..addAll(<NCP>[new NCP(HAIR,"#2d2d2d"),new NCP(HAIR1,"#262626"),new NCP(HAIR2,"#212121")])
    ..addAll(<NCP>[new NCP(SKIN,"#ffffff"),new NCP(SKIN1,"#d9d9d9"),new NCP(SKIN2,"#b9b9b9"),new NCP(SKINOUTLINE,"#595959")])
    ..addAll(<NCP>[new NCP(ASPECT1,"#fefb6b"),new NCP(ASPECT2,"#ecbd48")])

    ..addAll(<NCP>[new NCP(EYELEFT,"#ffbb1c"),new NCP(EYELEFTGLOW1,"#f7368a"),new NCP(EYELEFTGLOW2,"#ff006e"),new NCP(EYELEFTGLOW3,"#e10061"),new NCP(EYELEFTGLOW4,"#c40055")])
    ..addAll(<NCP>[new NCP(EYERIGHT,"#ffbb00"),new NCP(EYERIGHTGLOW1,"#368af7"),new NCP(EYERIGHTGLOW2,"#006eff"),new NCP(EYERIGHTGLOW3,"#0061e0"),new NCP(EYERIGHTGLOW4,"#0055c4")])

    ..addAll(<NCP>[new NCP(ACCENT,"#ed1c24"),new NCP(ACCENT1,"#c91900"),new NCP(ACCENT2,"#ad050b"),new NCP(ACCENTOUTLINE,"#710e11")]);



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

}

