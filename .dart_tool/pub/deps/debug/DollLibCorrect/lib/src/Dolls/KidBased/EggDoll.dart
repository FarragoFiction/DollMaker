import "../../../DollRenderer.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";

class EggDoll extends HomestuckDoll {

    @override
    String originalCreator = "multipleStripes";

    @override
    int renderingType =66;

    @override
    final int maxBody = 13;

    @override
    String name = "Egg";

    EggDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        //only one thing different
        extendedBody = layer("Egg.Body", "Egg/", 1, mb:true);//new SpriteLayer("Body","$folder/Egg/", 1, maxBody, supportsMultiByte: true);


    }






}