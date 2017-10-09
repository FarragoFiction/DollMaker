import "../SpriteLayer.dart";
import "../includes/palette.dart";
import "../includes/bytebuilder.dart";
abstract class Doll {
    String folder;

    ///in rendering order.
    List<SpriteLayer> layers = new List<SpriteLayer>();
    Palette palette;

    void initLayers();
    void randomize();
    void randomizeColors();
    void randomizeNotColors();
    void initFromReader(ByteReader reader);
    String toDataBytesX([ByteBuilder builder = null]);
}