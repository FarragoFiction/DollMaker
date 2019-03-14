import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


class MonsterPocketDoll extends Doll {

    @override
    String originalCreator = "frew";
    int maxBody = 3;
    int maxRightArm = 3;
    int maxLeftArm = 3;
    int maxHead = 3;

    String relativefolder = "images/MonsterPocket";

    @override
    String name = "Monster Pocket";



    SpriteLayer body;
    SpriteLayer rightarm;
    SpriteLayer leftarm;
    SpriteLayer head;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[leftarm, body, head, rightarm];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[rightarm, head, body, leftarm];


    @override
    int width = 96;
    @override
    int height = 96;

    @override
    int renderingType =151;

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

    MonsterPocketDoll() {
        initLayers();
        randomize();
    }

    @override
    void initLayers() {
        body = layer("Monster Pocket.Body", "Body/", 1);//new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
        leftarm = layer("Monster Pocket.LeftArm", "LeftArm/", 1);//new SpriteLayer("LeftArm", "$folder/LeftArm/", 1, maxLeftArm);
        rightarm = layer("Monster Pocket.RightArm", "RightArm/", 1);//new SpriteLayer("RightArm", "$folder/RightArm/", 1, maxRightArm);
        head = layer("Monster Pocket.Head", "Head/", 1);//new SpriteLayer("Head", "$folder/Head/", 1, maxHead);
    }

    @override
    void randomize() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        randomizeColors();
    }

    void tackyColors() {
                if(rand == null) rand = new Random();;
        HomestuckPalette h = palette as HomestuckPalette;
        palette.add(HomestuckPalette.ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.ASPECT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

        palette.add(HomestuckPalette.ASPECT_DARK, new Colour(h.aspect_light.red, h.aspect_light.green, h.aspect_light.blue)..setHSV(h.aspect_light.hue, h.aspect_light.saturation, h.aspect_light.value/2), true);
        palette.add(HomestuckPalette.SHOE_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHOE_DARK, new Colour(h.shoe_light.red, h.shoe_light.green, h.shoe_light.blue)..setHSV(h.shoe_light.hue, h.shoe_light.saturation, h.shoe_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.CLOAK_DARK, new Colour(h.cloak_light.red, h.cloak_light.green, h.cloak_light.blue)..setHSV(h.cloak_light.hue, h.cloak_light.saturation, h.cloak_light.value/2), true);
        palette.add(HomestuckPalette.CLOAK_MID, new Colour(h.cloak_dark.red, h.cloak_dark.green, h.cloak_dark.blue)..setHSV(h.cloak_dark.hue, h.cloak_dark.saturation, h.cloak_dark.value*3), true);
        palette.add(HomestuckPalette.SHIRT_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.SHIRT_DARK, new Colour(h.shirt_light.red, h.shirt_light.green, h.shirt_light.blue)..setHSV(h.shirt_light.hue, h.shirt_light.saturation, h.shirt_light.value/2), true);
        palette.add(HomestuckPalette.PANTS_LIGHT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.PANTS_DARK, new Colour(h.pants_light.red, h.pants_light.green, h.pants_light.blue)..setHSV(h.pants_light.hue, h.pants_light.saturation, h.pants_light.value/2), true);
        palette.add(HomestuckPalette.HAIR_ACCENT, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        palette.add(HomestuckPalette.HAIR_MAIN, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);

    }

    @override
    void randomizeColors() {
        List<String> human_hair_colors = <String>["#68410a", "#fffffe", "#000000", "#000000", "#000000", "#f3f28d", "#cf6338", "#feffd7", "#fff3bd", "#724107", "#382207", "#ff5a00", "#3f1904", "#ffd46d", "#473200", "#91683c"];

                if(rand == null) rand = new Random();;
        HomestuckPalette h = palette as HomestuckPalette;
        List<HomestuckPalette> paletteOptions = new List<HomestuckPalette>.from(ReferenceColours.paletteList.values);
        HomestuckPalette newPallete = rand.pickFrom(paletteOptions);
        if(newPallete == ReferenceColours.INK) {
            tackyColors();
        }else {
            copyPalette(newPallete);
        }
        if(newPallete != ReferenceColours.SKETCH) h.add("hairMain",new Colour.fromStyleString(rand.pickFrom(human_hair_colors)),true);
    }

    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
    }

}

