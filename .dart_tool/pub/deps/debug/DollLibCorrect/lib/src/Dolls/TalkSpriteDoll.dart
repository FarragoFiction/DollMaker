import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


//saving and loading isn't working .why?


class TalkSpriteDoll extends Doll{

  @override
  String originalCreator = "Azuki";

  @override
  int renderingType =20;

  @override
  int width = 350;
  @override
  int height = 350;

  @override
  String name = "TalkSprite";

  @override
  String relativefolder = "images/TalkSprite";
  final int maxAccessory = 1;
  final int maxSymbol = 15;
  final int maxBrows = 2;
  final int maxEyes = 3;
  final int maxHair = 6;
  final int maxHood = 11;
  final int maxMouth = 3;
  final int maxNose = 2;
  final int maxShirt = 7;
  final int maxBody = 0;
  final int maxFacePaint = 2;

  SpriteLayer accessory;
  SpriteLayer symbol;
  SpriteLayer hood;
  SpriteLayer brows;
  SpriteLayer leftEye;
  SpriteLayer hairBack;
  SpriteLayer hairFront;
  SpriteLayer rightEye;
  SpriteLayer mouth;
  SpriteLayer nose;
  SpriteLayer shirt;
  SpriteLayer body;
  SpriteLayer facePaint;


  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[hairBack, body, facePaint,  brows, mouth,nose,shirt, symbol, hood,leftEye, rightEye, hairFront,accessory];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[hairBack, body, facePaint,accessory, leftEye, rightEye, brows, mouth,nose, shirt, symbol, hood, hairFront];

  @override
  Palette paletteSource = new TalkSpritePalette()
    ..hair1 = '#00ffff'
    ..hair2 = '#00a0a1'
    ..skin1 = '#ffffff'
    ..skin2 = "#c8c8c8"
    ..hoodLight = "#fa4900"
    ..hoodMid = "#e94200"
    ..hoodDark = "#c33700"
    ..shirtLight = "#ff8800"
    ..shirtDark = "#d66e04"
    ..aspect1 = "#fefd49"
    ..aspect2 = "#fec910"
    ..blood = "#ff0000"
    ..blood2 = "#00ff00"
    ..theme = "#ff00ff"
    ..bowties = "#ffff00"
    ..eye_white_left = '#ffba35'
    ..eye_white_right = '#ffba15'
    ..antiBowties = "#a0a000";

  @override
  Palette palette = new TalkSpritePalette()
    ..hair1 = '#00ffff'
    ..hair2 = '#00a0a1'
    ..skin1 = '#ffffff'
    ..skin2 = "#c8c8c8"
    ..eye_white_left = '#000000'
    ..eye_white_right = '#000000'
    ..hoodLight = "#fa4900"
    ..hoodMid = "#e94200"
    ..hoodDark = "#c33700"
    ..shirtLight = "#ff8800"
    ..shirtDark = "#d66e04"
    ..aspect1 = "#fefd49"
    ..aspect2 = "#fec910"
    ..blood = "#ff0000"
    ..blood2 = "#00ff00"
    ..theme = "#ff00ff"
    ..bowties = "#ffff00"
    ..antiBowties = "#a0a000";

  TalkSpriteDoll() {
    initLayers();
    randomize();
  }

  //HELL YES i found the source of the save bug.
  //i'm not supposed to use premade palettes like this, instead,
  //how does the drop downs work?
  @override
  void randomizeColors() {
            if(rand == null) rand = new Random();;
    List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

    List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);
    Palette newPallete = rand.pickFrom(paletteOptions);
    if(newPallete == ReferenceColours.INK) {
      super.randomizeColors();
    }else {
      copyPalette(newPallete);
    }

    TalkSpritePalette p = palette as TalkSpritePalette;
    p.skin1 = "#ffffff";
    p.skin2 = "#c8c8c8";
    p.eye_white_left = "#ffffff";
    p.eye_white_right = "#ffffff";
    p.bowties = new Colour(255-p.blood.red, 255-p.blood.green, 255-p.blood.blue);
    p.antiBowties = new Colour(p.bowties.red, p.bowties.green, p.bowties.blue)..setHSV(p.bowties.hue, p.bowties.saturation, p.bowties.value/2);


    palette.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
    palette.add(TalkSpritePalette.HAIR2, new Colour(p.hair1.red, p.hair1.green, p.hair1.blue)..setHSV(p.hair1.hue, p.hair1.saturation, p.hair1.value/2), true);


  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
      if(l.imgNumber ==0 && l.maxImageNumber >=1) l.imgNumber = 1;
    }
    leftEye.imgNumber = rightEye.imgNumber;
    facePaint.imgNumber = 0;
  }


  @override
  void initLayers() {

    {
      hairFront = layer("TalkSprite.HairFront", "HairFront/", 1);//new SpriteLayer("HairFront","$folder/HairFront/", 1, maxHair);
      hairBack = layer("TalkSprite.HairBack", "HairBack/", 1)..slaveTo(hairFront);//new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair, syncedWith: <SpriteLayer>[hairFront]);
      //hairFront.syncedWith.add(hairBack);
      //hairBack.slave = true; //can't be selected on it's own

      body = layer("TalkSprite.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);

      facePaint = layer("TalkSprite.FacePaint", "FacePaint/", 1);//new SpriteLayer("FacePaint","$folder/FacePaint/", 1, maxFacePaint);
      brows = layer("TalkSprite.Brows", "Brows/", 1);//new SpriteLayer("Brows","$folder/Brows/", 1, maxBrows);
      mouth = layer("TalkSprite.Mouth", "Mouth/", 1);//new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
      leftEye = layer("TalkSprite.LeftEye", "LeftEye/", 1);//new SpriteLayer("LeftEye","$folder/LeftEye/", 1, maxEyes)..primaryPartner = false;
      rightEye = layer("TalkSprite.RightEye", "RightEye/", 1)..addPartner(leftEye);//new SpriteLayer("RightEye","$folder/RightEye/", 1, maxEyes)..partners.add(leftEye);

      nose = layer("TalkSprite.Nose", "Nose/", 1);//new SpriteLayer("Nose","$folder/Nose/", 1, maxNose);
      accessory = layer("TalkSprite.Accessory", "accessory/", 1);//new SpriteLayer("Accessory","$folder/accessory/", 1, maxAccessory);
      shirt = layer("TalkSprite.Shirt", "Shirt/", 1);//new SpriteLayer("Shirt","$folder/Shirt/", 1, maxShirt);
      symbol = layer("TalkSprite.Symbol", "Symbol/", 1);//new SpriteLayer("Symbol","$folder/Symbol/", 1, maxSymbol);
      hood = layer("TalkSprite.Hood", "Hood/", 1);//new SpriteLayer("Hood","$folder/Hood/", 1, maxHood);

    }
  }

}

class TalkSpritePalette extends Palette {
  static String EYE_WHITE_LEFT = "eyeWhitesLeft";
  static String EYE_WHITE_RIGHT = "eyeWhitesRight";
  static String HAIR1 = "hairMain";
  static String HAIR2 = "hairAccent";
  static String SKIN1 = "skin";
  static String SKIN2 = "skin2";
  static String HOODLIGHT = "cloak1";
  static String HOODMID = "cloak2";
  static String HOODDARK = "cloak3";
  static String SHIRTLIGHT = "shirt1";
  static String SHIRTDARK = "shirt2";
  static String ASPECT1 = "aspect1";
  static String ASPECT2 = "aspect2";
  static String BLOOD = "wing1";
  static String BLOOD2 = "wing2";
  static String THEME = "accent";
  static String BOWTIES = "bowties";
  static String ANTIBOWTIES = "antibowties";

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

  Colour get hair1 => this[HAIR1];
  void set hair1(dynamic c) => this.add(HAIR1, _handleInput(c), true);

  Colour get hair2 => this[HAIR2];
  void set hair2(dynamic c) => this.add(HAIR2, _handleInput(c), true);

  Colour get skin1 => this[SKIN1];
  void set skin1(dynamic c) => this.add(SKIN1, _handleInput(c), true);

  Colour get skin2 => this[SKIN2];
  void set skin2(dynamic c) => this.add(SKIN2, _handleInput(c), true);

  Colour get hoodLight => this[HOODLIGHT];
  void set hoodLight(dynamic c) => this.add(HOODLIGHT, _handleInput(c), true);

  Colour get hoodMid => this[HOODMID];
  void set hoodMid(dynamic c) => this.add(HOODMID, _handleInput(c), true);

  Colour get hoodDark => this[HOODDARK];
  void set hoodDark(dynamic c) => this.add(HOODDARK, _handleInput(c), true);

  Colour get shirtLight => this[SHIRTLIGHT];
  void set shirtLight(dynamic c) => this.add(SHIRTLIGHT, _handleInput(c), true);

  Colour get shirtDark => this[SHIRTDARK];
  void set shirtDark(dynamic c) => this.add(SHIRTDARK, _handleInput(c), true);

  Colour get aspect1 => this[ASPECT1];
  void set aspect1(dynamic c) => this.add(ASPECT1, _handleInput(c), true);

  Colour get aspect2 => this[ASPECT2];
  void set aspect2(dynamic c) => this.add(ASPECT2, _handleInput(c), true);

  Colour get blood => this[BLOOD];
  void set blood(dynamic c) => this.add(BLOOD, _handleInput(c), true);

  Colour get blood2 => this[BLOOD2];
  void set blood2(dynamic c) => this.add(BLOOD2, _handleInput(c), true);

  Colour get theme => this[THEME];
  void set theme(dynamic c) => this.add(THEME, _handleInput(c), true);

  Colour get bowties => this[BOWTIES];
  void set bowties(dynamic c) => this.add(BOWTIES, _handleInput(c), true);

  Colour get antiBowties => this[ANTIBOWTIES];
  void set antiBowties(dynamic c) => this.add(ANTIBOWTIES, _handleInput(c), true);

  Colour get eye_white_left => this[EYE_WHITE_LEFT];
  void set eye_white_left(dynamic c) => this.add(EYE_WHITE_LEFT, _handleInput(c), true);

  Colour get eye_white_right => this[EYE_WHITE_RIGHT];
  void set eye_white_right(dynamic c) => this.add(EYE_WHITE_RIGHT, _handleInput(c), true);




}