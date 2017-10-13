import "../random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "../SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";



class DenizenDoll extends Doll{
  @override
  int renderingType =4;
  @override
  String folder = "images/Homestuck/Denizen";
  final int maxFace = 14; //holy shit, is tht really how many we have?
  final int maxBack = 11;
  final int maxMouth =14;
  final int maxOther = 3;
  final int maxBody = 14;
  final int maxCore = 1;
  final int maxEyes = 18;

  @override
  Palette palette = new DenizenPalette()
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


  DenizenDoll() {
    initLayers();
    randomize();
  }

  DenizenDoll.fromDataString(String dataString){
    Uint8List thingy = BASE64URL.decode(dataString);
    ByteReader reader = new ByteReader(thingy.buffer, 0);
    initFromReader(reader, new DenizenPalette());
  }

  @override
  void initLayers() {

    {

      layers.clear();
      /*final int maxFace = 74; //holy shit, is tht really how many we have?
  final int maxBack = 86;
  final int maxMouth =29;
  final int maxOther = 28;
  final int maxBody = 73;
  final int maxCore = 26;
  final int maxEyes = 26;*/

      /*back bits go in the very very back
then comes the core body
then the body bits
then the aspects
then the mouths(edited)
then the eyes
then lastly the other bits.
*/
      layers.add(new SpriteLayer("Back","$folder/Back/", 1, maxBack));
      layers.add(new SpriteLayer("Core","$folder/Core/", 1, maxCore));
      layers.add(new SpriteLayer("Body","$folder/Body/", 1, maxBody));
      layers.add(new SpriteLayer("AspectFace","$folder/AspectFace/", 1, maxFace));
      layers.add(new SpriteLayer("Mouth","$folder/Mouth/", 1, maxMouth));
      layers.add(new SpriteLayer("Eyes","$folder/Eyes/", 1, maxEyes));
      layers.add(new SpriteLayer("Other","$folder/Other/", 1, maxOther));

    }
  }

}


/// Convenience class for getting/setting aspect palettes
class DenizenPalette extends Palette {
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
  static String _HAIR_MAIN = "hairMain";
  static String _HAIR_ACCENT = "hairAccent";
  static String _EYE_WHITE_LEFT = "eyeWhitesLeft";
  static String _EYE_WHITE_RIGHT = "eyeWhitesRight";
  static String _SKIN = "skin";

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

  Colour get text => this[_ACCENT];

  Colour get accent => this[_ACCENT];

  void set accent(dynamic c) => this.add(_ACCENT, _handleInput(c), true);

  Colour get aspect_light => this[_ASPECT_LIGHT];

  void set aspect_light(dynamic c) => this.add(_ASPECT_LIGHT, _handleInput(c), true);

  Colour get aspect_dark => this[_ASPECT_DARK];

  void set aspect_dark(dynamic c) => this.add(_ASPECT_DARK, _handleInput(c), true);

  Colour get shoe_light => this[_SHOE_LIGHT];

  void set shoe_light(dynamic c) => this.add(_SHOE_LIGHT, _handleInput(c), true);

  Colour get shoe_dark => this[_SHOE_DARK];

  void set shoe_dark(dynamic c) => this.add(_SHOE_DARK, _handleInput(c), true);

  Colour get cloak_light => this[_CLOAK_LIGHT];

  void set cloak_light(dynamic c) => this.add(_CLOAK_LIGHT, _handleInput(c), true);

  Colour get cloak_mid => this[_CLOAK_MID];

  void set cloak_mid(dynamic c) => this.add(_CLOAK_MID, _handleInput(c), true);

  Colour get cloak_dark => this[_CLOAK_DARK];

  void set cloak_dark(dynamic c) => this.add(_CLOAK_DARK, _handleInput(c), true);

  Colour get shirt_light => this[_SHIRT_LIGHT];

  void set shirt_light(dynamic c) => this.add(_SHIRT_LIGHT, _handleInput(c), true);

  Colour get shirt_dark => this[_SHIRT_DARK];

  void set shirt_dark(dynamic c) => this.add(_SHIRT_DARK, _handleInput(c), true);

  Colour get pants_light => this[_PANTS_LIGHT];

  void set pants_light(dynamic c) => this.add(_PANTS_LIGHT, _handleInput(c), true);

  Colour get pants_dark => this[_PANTS_DARK];

  void set pants_dark(dynamic c) => this.add(_PANTS_DARK, _handleInput(c), true);

  Colour get hair_main => this[_HAIR_MAIN];

  void set hair_main(dynamic c) => this.add(_HAIR_MAIN, _handleInput(c), true);

  Colour get hair_accent => this[_HAIR_ACCENT];

  void set hair_accent(dynamic c) => this.add(_HAIR_ACCENT, _handleInput(c), true);

  Colour get eye_white_left => this[_EYE_WHITE_LEFT];

  void set eye_white_left(dynamic c) => this.add(_EYE_WHITE_LEFT, _handleInput(c), true);

  Colour get eye_white_right => this[_EYE_WHITE_RIGHT];

  void set eye_white_right(dynamic c) => this.add(_EYE_WHITE_RIGHT, _handleInput(c), true);

  Colour get skin => this[_SKIN];

  void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);
}