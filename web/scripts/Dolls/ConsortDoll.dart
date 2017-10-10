import "../random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "../SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
class ConsortDoll extends Doll {
    int maxBody = 7;
    String folder = "images/Homestuck";

    @override
    Palette palette = new ConsortPalette()
        ..eyes = '#FF9B00'
        ..belly = '#EFEFEF'
        ..bellyoutline = '#DBDBDB'
        ..side = '#C6C6C6'
        ..lightest_part = '#ffffff'
        ..outline = '#ADADAD';

    ConsortDoll() {
        initLayers();
        randomize();
    }

    ConsortDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        initFromReader(reader);
    }

    @override
    void initLayers() {
        layers.clear();

        layers.add(new SpriteLayer("Body","$folder/Consort/", 1, maxBody));
    }
    
  @override
  void randomize() {
      Random rand = new Random();
      for(SpriteLayer l in layers) {
          l.imgNumber = rand.nextInt(l.maxImageNumber+1);
      }
      randomizeColors();
  }

  @override
  void randomizeColors() {
      Random rand = new Random();
      ConsortPalette p = palette as ConsortPalette;
      Colour c1 = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
      Colour c2 = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
      palette.add(ConsortPalette._EYES, c2, true);
      palette.add(ConsortPalette._OUTLINE, new Colour(c1.red, c1.green,c1.blue)..setHSV(c1.hue, c1.saturation, c1.value/4), true);
      palette.add(ConsortPalette._SIDE, new Colour(c1.red, c1.green,c1.blue)..setHSV(c1.hue, c1.saturation, c1.value/3), true);
      palette.add(ConsortPalette._BELLYOUTLINE, new Colour(c1.red, c1.green,c1.blue)..setHSV(c1.hue, c1.saturation, c1.value/2), true);
      palette.add(ConsortPalette._BELLY, c1, true);
      palette.add(ConsortPalette._LIGHTESTPART, new Colour(c1.red, c1.green,c1.blue)..setHSV(c1.hue, c1.saturation, c1.value*2), true);



  }

  @override
  void randomizeNotColors() {
      Random rand = new Random();
      for(SpriteLayer l in layers) {
          l.imgNumber = rand.nextInt(l.maxImageNumber+1);
      }
  }

  @override
  void initFromReader(ByteReader reader) {
    // TODO: implement initFromReader
  }

  @override
  String toDataBytesX([ByteBuilder builder = null]) {
    // TODO: implement toDataBytesX
  }
}




class ConsortPalette extends Palette {
    static String _EYES = "eyes";
    static String _BELLY = "belly";
    static String _BELLYOUTLINE = "belly_outline";
    static String _SIDE = "side";
    static String _LIGHTESTPART = "lightest_part";
    static String _OUTLINE = "main_outline";

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

    Colour get text => this[_EYES];

    Colour get eyes => this[_EYES];

    void set eyes(dynamic c) => this.add(_EYES, _handleInput(c), true);

    Colour get outline => this[_OUTLINE];

    void set outline(dynamic c) => this.add(_OUTLINE, _handleInput(c), true);

    Colour get belly => this[_BELLY];

    void set belly(dynamic c) => this.add(_BELLY, _handleInput(c), true);

    Colour get bellyoutline => this[_BELLYOUTLINE];

    void set bellyoutline(dynamic c) => this.add(_BELLYOUTLINE, _handleInput(c), true);

    Colour get lightest_part => this[_LIGHTESTPART];

    void set lightest_part(dynamic c) => this.add(_LIGHTESTPART, _handleInput(c), true);


    Colour get side => this[_SIDE];

    void set side(dynamic c) => this.add(_SIDE, _handleInput(c), true);


}