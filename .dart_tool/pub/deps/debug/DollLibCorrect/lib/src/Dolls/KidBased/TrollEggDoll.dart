import "../Layers/SpriteLayer.dart";
import "HomestuckTrollDoll.dart";

class TrollEggDoll extends HomestuckTrollDoll {

    @override
    int renderingType =65;

    @override
    final int maxBody = 13;

    @override
    String name = "Troll Egg";

    TrollEggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different.
        extendedBody = new SpriteLayer("Body","$folder/Egg/", 1, maxBody, supportsMultiByte: true);
    }



}