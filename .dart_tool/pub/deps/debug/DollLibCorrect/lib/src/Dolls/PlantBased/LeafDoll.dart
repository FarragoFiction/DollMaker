import "../../../DollRenderer.dart";
import "../../Rendering/ReferenceColors.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";

class LeafDoll extends Doll {
    //int maxBody = 25;
    @override
    String relativefolder = "images/LeafClump";

    SpriteLayer body;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body];


    @override
    int width = 100;
    @override
    int height = 100;

    @override
    int renderingType =36;

    @override
    String name = "LeafClump";

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

    @override
    String originalCreator = "jadedResearcher";

    LeafDoll() {
        initLayers();
        randomize();
    }


    @override
    void initLayers() {
        body = layer("Leaf.Body", "Body/", 1);//new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
    }

    @override
    void randomize() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        randomizeColors();
    }



    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
    }

    @override
    void randomizeColors() {
        if(rand == null) rand = new Random();;
        List<Palette> paletteOptions = new List<Palette>.from(ReferenceColours.paletteList.values);
        Palette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            super.randomizeColors();
        }else {
            copyPalette(newPallete);
        }
    }


}


