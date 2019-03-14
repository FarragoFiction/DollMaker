import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckHeroDoll extends HomestuckDoll {

    @override
    int height = 641;
    @override
    int width = 400;

    @override
    int renderingType =11;
    @override
    String relativefolder = "images/Homestuck";
    @override
    final int maxBody = 3;

    @override
    String name = "Hero";


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



    HomestuckHeroDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Hero Body","$folder/HeroBody/", 0, maxBody);
        extendedBody = new SpriteLayer("Hero Body","$folder/HeroBody/", 0, maxBody);


    }






}