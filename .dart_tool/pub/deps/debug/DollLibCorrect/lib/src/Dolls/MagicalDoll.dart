import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class MagicalDoll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =45;

  @override
  int width = 600;
  @override
  int height = 600;

  @override
  String name = "MagicalDoll";

  @override
  String relativefolder = "images/MagicalDoll";

  SpriteLayer hairBack;
  SpriteLayer bowBack;
  SpriteLayer body;
  SpriteLayer socks;
  SpriteLayer shoes;
  SpriteLayer skirt;
  SpriteLayer frontBow;
  SpriteLayer eyes;
  SpriteLayer eyebrows;
  SpriteLayer mouth;
  SpriteLayer hairFront;
  SpriteLayer glasses;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, bowBack, body, socks, shoes, skirt,frontBow, eyes, eyebrows, mouth,hairFront, glasses];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, bowBack, body, socks, shoes, skirt,frontBow, eyes, eyebrows, mouth,hairFront, glasses];

  //definitely doesn't sound creepy
  //wait i can make worse
  List<String> jrs_skin_collection = <String>["#CFCFCF","#FFDBAC", "#F1C27D" ,"#E0AC69" ,"#C68642", "#8D5524"];
  List<String> human_hair_colors = <String>["#2C222B", "#FFF5E1", "#B89778", "#A56B46", "#B55239", "#8D4A43", "#3B3024", "#504444","#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

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
    ..eye_white_left = '#000000'
    ..eye_white_right = '#000000'
    ..pants_dark = '#ADADAD'
    ..hair_main = '#000000'
    ..hair_accent = '#ADADAD'
    ..skin = '#fdca0d';


  MagicalDoll() {
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
    HomestuckPalette hp = palette as HomestuckPalette;
    hp.skin = new Colour.fromStyleString(rand.pickFrom(jrs_skin_collection));
    hp.eye_white_right = new Colour(255,255,255);
    hp.eye_white_left = new Colour(255,255,255);

    if(newPallete != ReferenceColours.SKETCH) hp.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);

  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber)+1;
    }
  }

  @override
  void initLayers() {

    {
      /*
        SpriteLayer hairBack;
  SpriteLayer bowBack;
  SpriteLayer body;
  SpriteLayer socks;
  SpriteLayer shoes;
  SpriteLayer skirt;
  SpriteLayer frontBow;
  SpriteLayer eyes;
  SpriteLayer eyebrows;
  SpriteLayer mouth;
  SpriteLayer hair;
  SpriteLayer glasses;
       */
      hairBack = layer("$name.HairBack", "HairBack/", 1);
      bowBack = layer("$name.BowBack", "BowBack/", 1);
      body = layer("$name.Body", "Body/", 1);
      socks = layer("$name.Socks", "Socks/", 1);
      shoes = layer("$name.Shoes", "Shoes/", 1);
      skirt = layer("$name.Skirt", "Skirt/", 1);
      //HEY FUTURE JR, JUST BECAUSE THEY BOTH ARE NAMED 'BOW' DOESN'T MEAN THEY SHOULD BE SLAVED TO EACH OTHER
      frontBow = layer("$name.BowFront", "BowFront/", 1);
      eyes = layer("$name.Eyes", "Eyes/", 1);
      eyebrows = layer("$name.Eyebrows", "Eyebrows/", 1);;
      mouth = layer("$name.Mouth", "Mouth/", 1);
      hairFront = layer("$name.HairFront", "HairFront/", 1)..slaveTo(hairBack);
      glasses = layer("$name.Glasses", "Glasses/", 1);


    }
  }

}

