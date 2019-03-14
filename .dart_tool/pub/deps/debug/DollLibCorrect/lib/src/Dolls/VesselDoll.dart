import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class VesselDoll extends Doll{

  @override
  String originalCreator = "Popo Merrygamz";

  @override
  int renderingType =44;

  @override
  int width = 100;
  @override
  int height = 100;

  @override
  String name = "Vessel";

  @override
  String relativefolder = "images/Vessel";
  //final int maxHead = 9;
  //final int maxTorso = 4;
  //final int maxLegs = 3;

  SpriteLayer torso;
  SpriteLayer head;
  SpriteLayer legs;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[legs, torso, head];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[legs, torso, head];

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


  VesselDoll() {
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
      torso = layer("Vessel.Torso", "Torso/", 1);//new SpriteLayer("Torso","$folder/Torso/", 1, maxTorso);
      head = layer("Vessel.Head", "Head/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
      legs = layer("Vessel.Legs", "Legs/", 1);//new SpriteLayer("Legs","$folder/Legs/", 1, maxLegs);
    }
  }

}

