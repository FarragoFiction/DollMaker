import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class FekDoll extends Doll{

  @override
  String originalCreator = "nebulousHarmony and Firanka";

  @override
  int renderingType =28;

  @override
  int width = 214;
  @override
  int height = 214;

  @override
  String name = "Fek";

  @override
  String relativefolder = "images/fek";
  final int maxCanonSymbol = 288;
  final int maxBody = 22;
  final int maxFace = 15;
  final int maxFacePaint = 5;
  final int maxGlasses = 10;
  final int maxHair = 34;
  final int maxHorns = 17;
  final int maxSymbol = 20;
  final int maxText = 11;




  SpriteLayer canonSymbol;
  SpriteLayer body;
  SpriteLayer face;
  SpriteLayer text;
  SpriteLayer glasses;
  SpriteLayer hair;
  SpriteLayer horns;
  SpriteLayer symbol;
  SpriteLayer facePaint;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body, facePaint,face, hair, horns,symbol,canonSymbol, glasses, text];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body, face,facePaint, hair, horns,symbol,canonSymbol, glasses, text];


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


  FekDoll() {
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
    canonSymbol.imgNumber = 0;
    //roughly 50/50 shot of being human
    if(rand.nextBool()) {
        horns.imgNumber = 0;
    }
    if(horns.imgNumber == 0) {
        palette.add(HomestuckPalette.SKIN, new Colour.fromStyleString("#ffffff"), true);
        List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour.fromStyleString(rand.pickFrom(human_hair_colors)), true);
        palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#c4c4c4"), true);
        palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#c4c4c4"), true);



    }else {
        palette.add(HomestuckPalette.SKIN, new Colour.fromStyleString("#c4c4c4"), true);
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour.fromStyleString("#000000"), true);
        palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#000000"), true);
        palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#000000"), true);


    }
  }

  @override
  void setQuirk() {
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);

  }

  @override
  void initLayers() {
      body = layer("Fek.Body", "body/", 1);//new SpriteLayer("Body","$folder/body/", 1, maxBody);
      canonSymbol = layer("Fek.canonSymbol", "canonSymbol/", 1);//new SpriteLayer("canonSymbol","$folder/canonSymbol/", 1, maxCanonSymbol);
      face = layer("Fek.Face", "face/", 1);//new SpriteLayer("Face","$folder/face/", 1, maxFace);
      text = layer("Fek.Text", "text/", 1);//new SpriteLayer("Text","$folder/text/", 1, maxText);
      glasses = layer("Fek.Glasses", "glasses/", 1);//new SpriteLayer("Glasses","$folder/glasses/", 1, maxGlasses);
      hair = layer("Fek.Hair", "hair/", 1);//new SpriteLayer("Hair","$folder/hair/", 1, maxHair);
      horns = layer("Fek.Horns", "horns/", 1);//new SpriteLayer("Horns","$folder/horns/", 1, maxHorns);
      symbol = layer("Fek.Symbol", "symbol/", 1);//new SpriteLayer("Symbol","$folder/symbol/", 1, maxSymbol);
      facePaint = layer("Fek.FacePaint", "facepaint/", 1);//new SpriteLayer("FacePaint","$folder/facepaint/", 1, maxFacePaint);
  }

}

