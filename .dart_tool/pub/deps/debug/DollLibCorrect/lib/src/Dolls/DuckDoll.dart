import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class DuckDoll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =39;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "Duck";

  @override
  String relativefolder = "images/Duck";
  final int maxBeaks = 6;
  final int maxBody = 42;
  final int maxEyes = 8;
  final int maxGlasses = 9;
  final int maxHair = 26;
  final int maxSymbols = 15;

  SpriteLayer beak;
  SpriteLayer body;
  SpriteLayer eyes;
  SpriteLayer glasses;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer symbol;



  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack,body, symbol, eyes, beak, glasses, hairFront];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack,body, symbol, eyes, beak, glasses, hairFront];


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


  DuckDoll() {
    initLayers();
    randomize();
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
            if(rand == null) rand = new Random();;
    List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);
    Palette newPallete = rand.pickFrom(paletteOptions);
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
  void initLayers() {

    {
      body = layer("Duck.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      /*
        SpriteLayer beak;
  SpriteLayer body;
  SpriteLayer eyes;
  SpriteLayer glasses;
  SpriteLayer hairFront;
  SpriteLayer hairBack;
  SpriteLayer symbol;
       */
      beak = layer("Duck.Beak", "Beak/", 1);//new SpriteLayer("Beak","$folder/Beak/", 1, maxBeaks);
      eyes = layer("Duck.Eyes", "Eyes/", 0);//new SpriteLayer("Eyes","$folder/Eyes/", 0, maxEyes);
      glasses = layer("Duck.Glasses", "Glasses/", 1);//new SpriteLayer("Glasses","$folder/Glasses/", 1, maxGlasses);
      hairFront = layer("Duck.HairFront", "HairFront/", 1);//new SpriteLayer("HairFront","$folder/HairFront/", 1, maxHair);
      //hairFront.slave = true;
      hairBack = layer("Duck.HairBack", "HairBack/", 1);//new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair);
      //hairFront.syncedWith.add(hairBack);
      //hairBack.syncedWith.add(hairFront);
      hairFront.slaveTo(hairBack);
      symbol = layer("Duck.Symbol", "Symbol/", 1);//new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbols);
    }
  }

}

