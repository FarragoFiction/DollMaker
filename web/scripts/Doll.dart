import "SpriteLayer.dart";
abstract class Doll {
    String folder;

    ///in rendering order.
    List<SpriteLayer> layers = new List<SpriteLayer>();
}