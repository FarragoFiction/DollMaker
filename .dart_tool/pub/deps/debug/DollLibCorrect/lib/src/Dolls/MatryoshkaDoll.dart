import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";

/*
    used for animation, but could be extended for emotions or battle damage, i don't care.
    this kind of doll has a list of sub dolls within it, and it's base behavior is showing the next
    doll in the list in a loop.

    cannot be loaded/saved.

    intended use case is to draw the doll frames number of times to cached thingy
    maybe should be a real thing.
 */

class MatryoshkaDoll extends Doll {

    int frame = 0;
    List<Doll> nestedDolls = new List<Doll>();
    Palette get palette {
        Palette ret =  nestedDolls[frame].palette;
        return ret;
    }

    MatryoshkaDoll(List<Doll> this.nestedDolls) {
        width = nestedDolls[0].width;
        height = nestedDolls[0].height;
    }


    @override
  void initLayers() {
      //does nothing
  }

    @override
    List<SpriteLayer>  get renderingOrderLayers {
        increaseFrame();
        List<SpriteLayer> ret =  nestedDolls[frame].renderingOrderLayers;
      return ret;
    }

    void increaseFrame() {
        frame ++;
        if(frame > nestedDolls.length -1) frame = 0;
    }




}