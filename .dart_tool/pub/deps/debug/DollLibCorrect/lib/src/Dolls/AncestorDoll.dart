import 'package:DollLibCorrect/src/Dolls/KidBased/HomestuckTrollDoll.dart';
import 'package:CommonLib/Random.dart';
import 'package:CommonLib/Colours.dart';

import "../Dolls/Doll.dart";
import "../Dolls/KidBased/HomestuckDoll.dart";
import "../Dolls/Layers/SpriteLayer.dart";
import "../Rendering/ReferenceColors.dart";
import "Quirk.dart";


//saving and loading isn't working .why?


class AncestorDoll extends Doll{

  //being lazy, just a copy from homestucktroll palette, won't let me unprivatize them cuz it would step on homestuck palettee???
  static String _ACCENT = "accent";
  static String _ASPECT_LIGHT = "aspect1";
  static String _ASPECT_DARK = "aspect2";
  static String _SHOE_LIGHT = "shoe1";
  static String _SHOE_DARK = "shoe2";
  static String _CLOAK_LIGHT = "cloak1";
  static String _CLOAK_MID = "cloak2";
  static String _CLOAK_DARK = "cloak3";
  static String _SHIRT_LIGHT = "shirt1";
  static String _SHIRT_DARK = "shirt2";
  static String _PANTS_LIGHT = "pants1";
  static String _PANTS_DARK = "pants2";
  static String _WING1 = "wing1";
  static String _WING2 = "wing2";
  static String _HAIR_MAIN = "hairMain";
  static String _HAIR_ACCENT = "hairAccent";
  static String _EYE_WHITES = "eyeWhites";
  static String _SKIN = "skin";


  @override
  String originalCreator = "Ner0 and agressiveArchenemy";


  @override
  int renderingType =27;

  @override
  int width = 744;
  @override
  int height = 1101;

  @override
  String name = "Ancestor";

  @override
  String relativefolder = "images/Ancestors";
  final int maxAccessoryBehind = 4;
  final int maxAccessoryFront = 5;
  final int maxBody = 36;
  final int maxEye = 7;
  final int maxPaint = 2;
  final int maxHair = 18;
  final int maxHorn = 17;
  final int maxMouth = 13;
  final int maxFin = 1;

  SpriteLayer accessoryFront;
  SpriteLayer accessoryBack;
  SpriteLayer body;
  SpriteLayer eyeLeft;
  SpriteLayer eyeRight;
  SpriteLayer hornLeft;
  SpriteLayer hornRight;
  SpriteLayer mouth;
  SpriteLayer facepaint;
  SpriteLayer hairBack;
  SpriteLayer hairFront;
  SpriteLayer fin;

  @override
  List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[accessoryBack, hairBack, body,fin, facepaint, mouth, eyeLeft, eyeRight, accessoryFront, hairFront, hornLeft, hornRight ];
  @override
  List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[fin, accessoryBack, hairBack, body,facepaint, mouth, eyeLeft, eyeRight, accessoryFront, hairFront, hornLeft, hornRight];


  @override
  Palette paletteSource = ReferenceColours.TROLL_PALETTE;

  @override
  Palette palette = new HomestuckTrollPalette()
    ..accent = '#FF9B00'
    ..aspect_light = '#FF9B00'
    ..aspect_dark = '#FF8700'
    ..shoe_light = '#111111'
    ..shoe_dark = '#333333'
    ..cloak_light = '#A3A3A3'
    ..cloak_mid = '#999999'
    ..cloak_dark = '#898989'
    ..shirt_light = '#111111'
    ..shirt_dark = '#000000'
    ..pants_light = '#4b4b4b'
    ..eye_white_left = '#ffba29'
    ..eye_white_right = '#ffba29'
    ..pants_dark = '#3a3a3a'
    ..hair_accent = '#aa0000'
    ..hair_main = '#000000'
    ..skin = '#000000';


  AncestorDoll() {
    initLayers();
    randomize();
  }

  @override
  void randomizeColors() {
    if(rand == null) rand = new Random();
    List<String> bloodColors = <String>["#A10000", "#a25203", "#a1a100", "#658200", "#416600", "#078446", "#008282", "#004182", "#0021cb", "#631db4", "#610061", "#99004d"];

    String chosenBlood = rand.pickFrom(bloodColors);
    HomestuckTrollPalette h = palette as HomestuckTrollPalette;

    palette.add(_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(_ASPECT_LIGHT, new Colour.fromStyleString(chosenBlood), true);

    palette.add(_ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value / 2), true);
    palette.add(_SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(_SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value / 2), true);
    palette.add(_CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(_CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value / 2), true);
    palette.add(_CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value * 3), true);
    palette.add(_PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
    palette.add(_PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value / 2), true);
    palette.add(_WING1, new Colour.fromStyleString(chosenBlood), true);
    palette.add(_WING2, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue)..setHSV(h.wing1.hue, h.wing1.saturation, h.wing1.value / 2), true);
    palette.add(_HAIR_ACCENT, new Colour(h.wing1.red, h.wing1.green, h.wing1.blue), true);
    //mutantEyes();
    (palette as HomestuckPalette)..pants_light = '#4b4b4b'
      ..shirt_light = '#111111'
      ..shirt_dark = '#000000'
      ..pants_dark = '#3a3a3a';
  }

  @override
  void randomizeNotColors() {
    for(SpriteLayer l in renderingOrderLayers) {
      l.imgNumber = rand.nextInt(l.maxImageNumber+1);
    }
    hornLeft.imgNumber = hornRight.imgNumber;
    eyeLeft.imgNumber = eyeRight.imgNumber;
    if(associatedColor.toStyleString() == "#610061" || associatedColor.toStyleString() == "#99004d"){
      fin.imgNumber = 1;
    }else {
      fin.imgNumber = 0;
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

     // hairFront, hornLeft, hornRight
      body = layer("Ancestor.Body", "Body/", 1);//new SpriteLayer("Body","$folder/Body/", 1, maxBody);
      fin = layer("Ancestor.Fin", "Fin/", 1);//new SpriteLayer("Fin","$folder/Fin/", 1, maxFin);
      accessoryBack = layer("Ancestor.BehindAccessory", "AccessoriesBehind/", 1);//new SpriteLayer("BehindAccessory","$folder/AccessoriesBehind/", 1, maxAccessoryBehind);
      hairBack = layer("Ancestor.HairBack", "HairBack/", 1);//new SpriteLayer("HairBack","$folder/HairBack/", 1, maxHair);
      facepaint = layer("Ancestor.Facepaint", "Facepaint/", 1);//new SpriteLayer("Facepaint","$folder/Facepaint/", 1, maxPaint);
      mouth = layer("Ancestor.Mouth", "Mouth/", 1);//new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth);
      eyeLeft = layer("Ancestor.LeftEye", "EyeLeft/", 1);//new SpriteLayer("LeftEye","$folder/EyeLeft/", 1, maxEye)..primaryPartner = false;
      eyeRight = layer("Ancestor.RightEye", "EyeRight/", 1)..addPartner(eyeLeft);//new SpriteLayer("RightEye","$folder/EyeRight/", 1, maxEye)..partners.add(eyeLeft);
      accessoryFront = layer("Ancestor.FrontAccessory", "AccessoriesFront/", 1);//new SpriteLayer("FrontAccessory","$folder/AccessoriesFront/", 1, maxAccessoryFront);
      hairFront = layer("Ancestor.HairFront", "HairFront/", 1)..slaveTo(hairBack);//new SpriteLayer("HairFront","$folder/HairFront/", 1, maxHair, syncedWith: <SpriteLayer>[hairBack]);
      //hairBack.syncedWith.add(hairFront);
      //hairFront.slave = true; //can't be selected on it's own
      hornLeft = layer("Ancestor.LeftHorn", "HornLeft/", 1);//new SpriteLayer("LeftHorn","$folder/HornLeft/", 1, maxHorn)..primaryPartner = false;;
      hornRight = layer("Ancestor.RightHorn", "HornRight/", 1)..addPartner(hornLeft);//new SpriteLayer("RightHorn","$folder/HornRight/", 1, maxHorn)..partners.add(hornLeft);

      //slave hair, partner horns/eyes

    }
  }

}

