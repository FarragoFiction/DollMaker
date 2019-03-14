import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckBabyDoll extends HomestuckDoll {
    @override
    String originalCreator = "karmicRetribution";

    @override
    int renderingType =12;
    @override
    String relativefolder = "images/Homestuck";
    @override
    final int maxBody = 3;

    @override
    String name = "Baby";


    @override
    Palette palette = new HomestuckPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#7F7F7F'
        ..shoe_dark = '#727272'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#EFEFEF'
        ..shirt_dark = '#DBDBDB'
        ..pants_light = '#C6C6C6'
        ..eye_white_left = '#ffffff'
        ..eye_white_right = '#ffffff'
        ..pants_dark = '#ADADAD'
        ..hair_main = '#ffffff'
        ..hair_accent = '#ADADAD'
        ..skin = '#ffffff';



    HomestuckBabyDoll() {
        initLayers();
        randomize();
    }

    @override
    void randomizeNotColors()

    {
        super.randomizeNotColors();
        symbol.imgNumber = 0;

    }

    @override
    void randomize()

    {
        super.randomize();
        symbol.imgNumber = 0;

    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/Baby/", 0, maxBody, legacy:true);
        extendedBody = layer("Baby.Body", "Baby/", 0, mb:true);//new SpriteLayer("Body","$folder/Baby/", 0, maxBody, supportsMultiByte: true);


    }


    @override
    Doll hatch() {
        SmolKidDoll newDoll = new SmolKidDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        return newDoll;
    }





}