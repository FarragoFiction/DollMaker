import "../../commonImports.dart";
import "SpriteLayer.dart";


class NamedSpriteLayer extends SpriteLayer {
    List<String> possibleNames;
    //because it extends can't NOT have a number, but it won't use it.
  NamedSpriteLayer(this.possibleNames, String name, String imgNameBase, int imgNumber, int maxImageNumber) : super(name, imgNameBase, imgNumber, maxImageNumber);

  //major difference from named layer to regular
    @override
  String get imgLocation {
      return "$imgNameBase$name.$imgFormat";
  }

}