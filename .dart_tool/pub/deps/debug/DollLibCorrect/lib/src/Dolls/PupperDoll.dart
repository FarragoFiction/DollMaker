import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class PupperDoll extends Doll{

  @override
  String originalCreator = "The Law, spinningDisks, CD";

  @override
  int renderingType =24;

  @override
  int width = 300;
  @override
  int height = 300;

  @override
  String name = "Pupper";

  @override
  String relativefolder = "images/Pupper";
  final int maxAccessory = 1;
  final int maxbackLegs = 0;
  final int maxBody = 0;
  final int maxFrontLegs = 0;
  final int maxHead = 0;
  final int maxEar = 0;
  final int maxEye = 1;
  final int maxHeadFur = 1;
  final int maxSnout = 0;
  final int maxTail = 1;




  SpriteLayer accessory;
  SpriteLayer backLegs;
  SpriteLayer body;
  SpriteLayer frontLegs;
  SpriteLayer head;
  SpriteLayer leftEar;
  SpriteLayer leftEye;
  SpriteLayer leftHeadFur;
  SpriteLayer rightEar;
  SpriteLayer rightEye;
  SpriteLayer rightHeadFur;
  SpriteLayer snout;
  SpriteLayer tail;





  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,  head,rightHeadFur, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[tail, body, rightHeadFur, head, leftEye, rightEye, leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];


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


  PupperDoll() {
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
    quirkButDontUse.lettersToReplaceIgnoreCase = [["^.*\$", "Woof"],["[.]\$", "Bark"],["[.]\$", "Yip"],];

  }

  @override
  void initLayers() {

    {
      //leftHeadFur, leftEar, rightEar, snout, accessory, backLegs, frontLegs];
      tail = new SpriteLayer("Tail","$folder/Tail/", 1, maxTail);
      body = new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      rightHeadFur = new SpriteLayer("HairFur","$folder/rightHeadFur/", 1, maxHeadFur);
      head = new SpriteLayer("Head","$folder/head/", 1, maxHead);
      leftEye = new SpriteLayer("LeftEye","$folder/leftEye/", 1, maxEye);
      rightEye = new SpriteLayer("RightEye","$folder/rightEye/", 1, maxEye);
      leftHeadFur = new SpriteLayer("HairFur","$folder/leftHeadFur/", 1, maxHeadFur, syncedWith: <SpriteLayer>[rightHeadFur]);
      leftEar = new SpriteLayer("LeftEar","$folder/leftEar/", 1, maxEar);
      rightEar = new SpriteLayer("RightEar","$folder/rightEar/", 1, maxEar);
      snout = new SpriteLayer("Snout","$folder/snout/", 1, maxSnout);
      accessory = new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      backLegs = new SpriteLayer("BackLegs","$folder/backLegs/", 1, maxbackLegs);
      frontLegs = new SpriteLayer("FrontLegs","$folder/frontLeg/", 1, maxFrontLegs);


      rightHeadFur.syncedWith.add(leftHeadFur);
      leftHeadFur.slave = true; //can't be selected on it's own



    }
  }

}

