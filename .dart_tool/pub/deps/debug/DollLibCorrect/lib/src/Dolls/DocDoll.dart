import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class DocDoll extends Doll{

  @override
  String originalCreator = "spinningDisks";

  @override
  int renderingType =26;

  @override
  int width = 149;
  @override
  int height = 369;

  @override
  String name = "Doc";

  @override
  String relativefolder = "images/Doc";
  final int maxAccessory = 4;
  final int maxBody = 11;
  final int maxLeg = 14;
  final int maxHead = 37;




  SpriteLayer accessory;
  SpriteLayer body;
  SpriteLayer head;
  SpriteLayer legs;






  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[legs, body, head, accessory];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[legs, body, head, accessory];


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


  DocDoll() {
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
      body = layer("Doc.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      head = layer("Doc.Head", "Head/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
      accessory = layer("Doc.Accessory", "Accessory/", 1);//new SpriteLayer("Accessory","$folder/Accessory/", 1, maxAccessory);
      legs = layer("Doc.Legs", "Legs/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLeg);
    }
  }

}

