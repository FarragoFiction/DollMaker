import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class VirusDoll extends Doll{

  @override
  String originalCreator = "dystopicFuturism";


  @override
  int renderingType =18;

  @override
  int width = 548;
  @override
  int height = 558;

  @override
  String name = "Virus";

  @override
  String relativefolder = "images/Virus";
  final int maxBody = 2;
  final int maxCapsid = 3;
  final int maxDecoLegs = 2;
  final int maxLeg1 = 3;
  final int maxLeg2 = 3;
  final int maxLeg3 = 3;
  final int maxLeg4 = 3;



  SpriteLayer body;
  SpriteLayer capsid;
  SpriteLayer decoLegs;
  SpriteLayer leg1;
  SpriteLayer leg2;
  SpriteLayer leg3;
  SpriteLayer leg4;



  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[leg1, leg2, leg3, leg4, decoLegs, capsid, body];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[leg1, leg2, leg3, leg4, decoLegs, capsid, body];

  @override
  Palette paletteSource = new VirusPalette()
    ..armor1 = '#00fffa'
    ..armor2 = '#00d6d2'
    ..armor3 = '#00a8a5'
    ..claw1 = '#76e0db'
    ..claw2 = '#9bc9c7'
    ..capsid1 = '#0000ff'
    ..capsid2 = '#0000c4'
    ..capsid3 = '#000096'
    ..capsid4 = '#5151ff'
    ..accent1 = '#8700ff'
    ..accent2 = '#a84cff';
  @override
  Palette palette = new VirusPalette()
    ..armor1 = '#FF9B00'
    ..armor2 = '#FF9B00'
    ..armor3 = '#FF8700'
    ..claw1 = '#7F7F7F'
    ..claw2 = '#727272'
    ..capsid1 = '#A3A3A3'
    ..capsid2 = '#999999'
    ..capsid3 = '#898989'
    ..capsid4 = '#EFEFEF'
    ..accent1 = '#DBDBDB'
    ..accent2 = '#C6C6C6';


  VirusDoll() {
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
  void initLayers() {

    {
      capsid = layer("Virus.Capsid", "Capsid/", 1);//new SpriteLayer("Capsid","$folder/Capsid/", 1, maxCapsid);
      decoLegs = layer("Virus.DecoLegs", "DecoLegs/", 1);//new SpriteLayer("DecoLegs","$folder/DecoLegs/", 1, maxDecoLegs);
      body = layer("Virus.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      leg1 = layer("Virus.Leg1", "Leg1/", 1);//new SpriteLayer("Leg1","$folder/Leg1/", 1, maxLeg1);
      leg2 = layer("Virus.Leg2", "Leg2/", 1);//new SpriteLayer("Leg2","$folder/Leg2/", 1, maxLeg2);
      leg3 = layer("Virus.Leg3", "Leg3/", 1);//new SpriteLayer("Leg3","$folder/Leg3/", 1, maxLeg3);
      leg4 = layer("Virus.Leg4", "Leg4/", 1);//new SpriteLayer("Leg4","$folder/Leg4/", 1, maxLeg4);
    }
  }

}


/// Convenience class for getting/setting aspect palettes
class VirusPalette extends Palette {

  static String ARMOR1 = "armor1";
  static String ARMOR2 = "armor2";
  static String ARMOR3 = "armor3";
  static String CLAW1 = "claw1";
  static String CLAW2 = "claw2";
  static String CAPSID1 = "capsid1";
  static String CAPSID2 = "capsid2";
  static String CAPSID3 = "capsid3";
  static String CAPSID4 = "capsid4";
  static String ACCENT1 = "accent1";
  static String ACCENT2 = "accent2";

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



  Colour get armor1 => this[ARMOR1];

  void set armor1(dynamic c) => this.add(ARMOR1, _handleInput(c), true);

  Colour get armor2 => this[ARMOR2];

  void set armor2(dynamic c) => this.add(ARMOR2, _handleInput(c), true);

  Colour get armor3 => this[ARMOR3];

  void set armor3(dynamic c) => this.add(ARMOR3, _handleInput(c), true);

  Colour get claw1 => this[CLAW1];

  void set claw1(dynamic c) => this.add(CLAW1, _handleInput(c), true);

  Colour get claw2 => this[CLAW2];

  void set claw2(dynamic c) => this.add(CLAW2, _handleInput(c), true);

  Colour get capsid1 => this[CAPSID1];

  void set capsid1(dynamic c) => this.add(CAPSID1, _handleInput(c), true);

  Colour get capsid2 => this[CAPSID2];

  void set capsid2(dynamic c) => this.add(CAPSID2, _handleInput(c), true);

  Colour get capsid3 => this[CAPSID3];

  void set capsid3(dynamic c) => this.add(CAPSID3, _handleInput(c), true);

  Colour get capsid4 => this[CAPSID4];

  void set capsid4(dynamic c) => this.add(CAPSID4, _handleInput(c), true);

  Colour get accent1 => this[ACCENT1];

  void set accent1(dynamic c) => this.add(ACCENT1, _handleInput(c), true);

  Colour get accent2 => this[ACCENT2];

  void set accent2(dynamic c) => this.add(ACCENT2, _handleInput(c), true);


}