import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


class BroomDoll extends Doll {

    @override
    String originalCreator = "Cat,fireRachet";

    int maxHandle = 11;
    int maxHead = 14;

    String relativefolder = "images/Broom";

    SpriteLayer handle;
    SpriteLayer head;


    @override
    String name = "Broom";


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[handle, head];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[handle, head];


    @override
    int width = 400;
    @override
    int height = 200;

    @override
    int renderingType =22;


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



    BroomDoll() {
        initLayers();
        randomize();
    }


    @override
    void initLayers() {
        handle = layer("Broom.Handle", "Handle/", 1);//new SpriteLayer("Handle", "$folder/Handle/", 1, maxHandle);
        head = layer("Broom.Head", "Head/", 1);//new SpriteLayer("Head", "$folder/Head/", 1, maxHead);
    }


    @override
    void randomize() {
        randomizeNotColors();
        randomizeColors();
    }

    @override
    void randomizeColors() {
        HomestuckPalette o = palette as HomestuckPalette;

        palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
        makeOtherColorsDarker(o, HomestuckPalette.ASPECT_LIGHT, <String>[HomestuckPalette.ASPECT_DARK]);

        palette.add(HomestuckPalette.SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)),true);
        makeOtherColorsDarker(o, HomestuckPalette.SHIRT_LIGHT, <String>[HomestuckPalette.SHIRT_DARK]);

    }



}
