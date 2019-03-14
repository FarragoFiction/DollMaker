import "../../commonImports.dart";
import '../../legacybytebuilder.dart' as OldByteBuilder;

import "SpriteLayer.dart";

class PNGWrapperSpriteLayer extends SpriteLayer {

  PNGWrapperSpriteLayer(String name, String imgNameBase) : super(name, imgNameBase, 0, 0);

  String get imgLocation {
      return "$imgNameBase";
  }

  @override
  void saveToBuilder(ByteBuilder builder) {
      //throw("does not support saving");
  }

  @override
  void loadFromReaderOld(OldByteBuilder.ByteReader reader) {
    //throw("does not support loading");

  }

  @override
  void loadFromReader(ImprovedByteReader reader) {
    //throw("does not support loading");

  }


}