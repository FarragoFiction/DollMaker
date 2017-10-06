import "SpriteLayer.dart";
import "includes/palette.dart";
abstract class Doll {
    String folder;

    ///in rendering order.
    List<SpriteLayer> layers = new List<SpriteLayer>();
    Palette palette;
}