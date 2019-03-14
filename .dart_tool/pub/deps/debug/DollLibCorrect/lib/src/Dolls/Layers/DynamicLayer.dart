import "../../commonImports.dart";
import 'PositionedDollLayer.dart';
import 'PositionedLayer.dart';

//layers that aren't necessarily present when a doll is intialized (like fruit/flowers/etc)
//has a type so that when loaded from datastring it knows how to instantiate itself
//a positioned layer by itself is NOT dynamic (folder and things like that are hard to serialize)
class DynamicLayer extends PositionedLayer {
    //just like how dolls do it
    int renderingType = 0;

  DynamicLayer(int x, int y, String name, String imgNameBase, int imgNumber, int maxImageNumber) : super(x, y, name, imgNameBase, imgNumber, maxImageNumber);

  static DynamicLayer instantiateLayer(ImprovedByteReader reader) {
      int type = reader.readExpGolomb();
     // print("I think the type is $type");

      List<DynamicLayer> list = <DynamicLayer>[new PositionedDollLayer(null,0,0,0, 0, "LoadedDynamicLayer")];
      for(DynamicLayer layer in list) {
          if(layer.renderingType == type) {
            layer.loadFromReader(reader, false);
            return layer;
          }
      }
      throw("I don't know what kind of layer is type $type");
  }


    @override
    void loadFromReader(ImprovedByteReader reader, [bool readType = true]) {
        if(readType) {
           // print("i have to read (and discard) the type");
            reader.readExpGolomb();
        }
        super.loadFromReader(reader);
    }

}

