import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


class CatDoll extends Doll{

  @override
  String originalCreator = "CD and spinningDisks";

  @override
  int renderingType =23;

  @override
  int width = 300;
  @override
  int height = 300;

  @override
  String name = "Cat";

  @override
  String relativefolder = "images/Cat";
  final int maxAccessory = 0;
  final int maxbackLegs = 2;
  final int maxBody = 5;
  final int maxChestFur = 2;
  final int maxFrontLegs = 5;
  final int maxHead = 1;
  final int maxLeftEar = 6;
  final int maxLeftEye = 5;
  final int maxRightEar = 6;
  final int maxRightEye = 5;
  final int maxSnout = 5;
  final int maxTail = 25;
  final int maxHeadFur = 1;




  SpriteLayer accessory;
  SpriteLayer backLegs;
  SpriteLayer body;
  SpriteLayer chestFur;
  SpriteLayer frontLegs;
  SpriteLayer head;
  SpriteLayer leftEar;
  SpriteLayer leftEye;
  SpriteLayer rightEar;
  SpriteLayer rightEye;
  SpriteLayer snout;
  SpriteLayer tail;
  SpriteLayer rightHeadFur;
  SpriteLayer leftHeadFur;






  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,chestFur, head,rightHeadFur,leftHeadFur, leftEye, rightEye, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[tail, body,chestFur, head, leftEye, rightEye, leftEar, rightEar, snout, accessory, backLegs, frontLegs,rightHeadFur,leftHeadFur];


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


  CatDoll() {
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
    leftEye.imgNumber = rightEye.imgNumber;
    leftEar.imgNumber = rightEar.imgNumber;
    if(tail.imgNumber == 0) tail.imgNumber = 1;
  }


  @override
  void setQuirk() {
    int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
    Random rand  = new Random(seed);
    quirkButDontUse = Quirk.randomHumanQuirk(rand);
    quirkButDontUse.lettersToReplaceIgnoreCase = [["^.*\$", "Meow"],["[.]\$", "Nya"],["[.]\$", "Purr"],];

  }

  @override
  void initLayers() {

    {
      //leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
      tail = layer("Cat.Tail", "Tail/", 1);//new SpriteLayer("Tail","$folder/Tail/", 1, maxTail);
      body = layer("Cat.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      chestFur = layer("Cat.ChestFur", "chestFur/", 1);//new SpriteLayer("ChestFur","$folder/chestFur/", 1, maxChestFur);
      head = layer("Cat.Head", "Head/", 1);//new SpriteLayer("Head","$folder/Head/", 1, maxHead);
      leftEye = layer("Cat.LeftEye", "leftEye/", 1);//new SpriteLayer("LeftEye","$folder/leftEye/", 1, maxLeftEye);
      rightEye = layer("Cat.RightEye", "rightEye/", 1);//new SpriteLayer("RightEye","$folder/rightEye/", 1, maxRightEye);
      leftEar = layer("Cat.LeftEar", "leftEar/", 1);//new SpriteLayer("LeftEar","$folder/leftEar/", 1, maxLeftEar);
      rightEar = layer("Cat.RightEar", "rightEar/", 1);//new SpriteLayer("RightEar","$folder/rightEar/", 1, maxRightEar);
      snout = layer("Cat.Snout", "snout/", 1);//new SpriteLayer("Snout","$folder/snout/", 1, maxSnout);
      accessory = layer("Cat.Accessory", "accessory/", 1);//new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      backLegs = layer("Cat.BackLegs", "backLegs/", 1);//new SpriteLayer("BackLegs","$folder/backLegs/", 1, maxbackLegs);
      frontLegs = layer("Cat.FrontLegs", "frontLeg/", 1);//new SpriteLayer("FrontLegs","$folder/frontLeg/", 1, maxFrontLegs);

      rightHeadFur = layer("Cat.RightHeadFur", "rightHeadFur/", 1);//new SpriteLayer("HairFur","$folder/rightHeadFur/", 1, maxHeadFur);
      leftHeadFur = layer("Cat.LeftHeadFur", "leftHeadFur/", 1)..slaveTo(rightHeadFur);//new SpriteLayer("HairFur","$folder/leftHeadFur/", 1, maxHeadFur, syncedWith: <SpriteLayer>[rightHeadFur]);


      //rightHeadFur.syncedWith.add(leftHeadFur);
      //leftHeadFur.slave = true; //can't be selected on it's own

    }
  }

}

