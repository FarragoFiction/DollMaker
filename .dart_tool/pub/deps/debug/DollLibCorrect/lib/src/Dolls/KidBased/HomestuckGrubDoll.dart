import "../../../DollRenderer.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class HomestuckGrubDoll extends HomestuckTrollDoll {

    @override
    String originalCreator = "karmicRetribution";

    
    @override
    int renderingType =13;
    @override
    String relativeFolder = "images/Homestuck";
    @override
    final int maxBody = 26;

    static List<int> landDwellerBodies = Doll.dataValue("Grub.landDwellerBodies");// <int>[0,1,2,3,4,5,6,7,8];

    static List<int> seadwellerBodies1 = Doll.dataValue("Grub.seaDwellerBodies1");// <int>[9,10,11,12,13,14,15,16,17];
    static List<int> seadwellerBodies2 = Doll.dataValue("Grub.seaDwellerBodies2");// <int>[18,19,20,21,22,23,24,26,26];
    static List<int> upsideDownBodies = Doll.dataValue("Grub.upsideDownBodies");// <int>[7,8,26,25,16,17];


    @override
    String name = "Grub";


    @override
    Palette palette = new HomestuckTrollPalette()
        ..accent = '#FF9B00'
        ..aspect_light = '#FF9B00'
        ..aspect_dark = '#FF8700'
        ..shoe_light = '#111111'
        ..shoe_dark = '#333333'
        ..cloak_light = '#A3A3A3'
        ..cloak_mid = '#999999'
        ..cloak_dark = '#898989'
        ..shirt_light = '#111111'
        ..shirt_dark = '#000000'
        ..pants_light = '#4b4b4b'
        ..eye_white_left = '#ffba29'
        ..eye_white_right = '#ffba29'
        ..pants_dark = '#3a3a3a'
        ..hair_accent = '#aa0000'
        ..hair_main = '#000000'
        ..skin = '#C4C4C4';



    HomestuckGrubDoll([int sign]) {
        initLayers();
        randomize();
        if(sign != null) {
           // print("sign is $sign");
            canonSymbol.imgNumber = sign;
            //print("used sign to set canon Symbol to ${canonSymbol.imgNumber}");

            //makes sure palette is sign appropriate
            randomize(false);
            //print("after randomize, canon symbol is ${canonSymbol.imgNumber}");

        }
    }

    @override
    Doll hatch() {
        SmolTrollDoll newDoll = new SmolTrollDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.extendedBody.imgNumber = newDoll.rand.nextInt(newDoll.extendedBody.maxImageNumber);
        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        //(newDoll as HomestuckTrollDoll).mutantEyes(false);
        return newDoll;
    }


    void mutantWings([bool force = false]) {
        //grubs don't have wings. trolls do.
    }

    @override
    void randomizeNotColors()

    {
        super.randomizeNotColors();
        pickCasteAppropriateBody();
        canonSymbol.imgNumber = 0;
    }

    void pickCasteAppropriateBody() {
        Random hairRand = new Random(extendedHairBack.imgNumber);
        hairRand.nextInt(); //init;
        List<int> choices = new List<int>();
        //should match up to wigglersim
        if(bloodColor == HomestuckTrollDoll.VIOLET || bloodColor == HomestuckTrollDoll.FUCHSIA) {
            //print("TEST: it's a seadweller");
            if(hairRand.nextBool()) {
                choices.addAll(seadwellerBodies2);
            }else {
                choices.addAll(seadwellerBodies1);
            }
        }else if(bloodColor == HomestuckTrollDoll.MUTANT ) {
            //print("TEST: it's a mutant");

            if(hairRand.nextBool()) {
                if(hairRand.nextBool()) {
                    choices.addAll(seadwellerBodies2);
                }else {
                    choices.addAll(seadwellerBodies1);
                }
            }else {
                choices.addAll(landDwellerBodies);
            }
        }else {
           // print("TEST: it's a landdweller");

            choices.addAll(landDwellerBodies);
        }

        choices.removeWhere((a) {
            return upsideDownBodies.contains(a);
        });

       // print("choices are $choices");
        extendedBody.imgNumber =  hairRand.pickFrom(choices);
    }

    @override
    void regularEyes(older) {
        HomestuckPalette h = palette as HomestuckPalette;
        if(older) {
            palette.add(HomestuckPalette.EYE_WHITE_LEFT, new Colour.fromStyleString("#ffba29"), true);
            palette.add(HomestuckPalette.EYE_WHITE_RIGHT, new Colour.fromStyleString("#ffba29"), true);
        }else {
            h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light, true);
            h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light, true);
        }
    }

    @override
    void randomizeColors()

    {
        super.randomizeColors();
        HomestuckPalette h = palette as HomestuckPalette;
        h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light,true);
        h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light,true);

    }

    @override
    void randomize([bool chooseSign = true])

    {
        super.randomize(chooseSign);
        canonSymbol.imgNumber = 0;
        pickCasteAppropriateBody();
        HomestuckPalette h = palette as HomestuckPalette;
        h.add(HomestuckPalette.EYE_WHITE_LEFT, h.aspect_light,true);
        h.add(HomestuckPalette.EYE_WHITE_RIGHT, h.aspect_light,true);
    }



    @override
    void setUpWays() {
        if(upsideDownBodies.contains(extendedBody.imgNumber)) {
           // print("upways is true");
            orientation = Doll.UPWAYS;
        }else {
            orientation = Doll.NORMALWAYS;
        }
    }

    @override
    void initLayers()

    {
        super.initLayers();
        body = new SpriteLayer("Body","$folder/Grub/", 0, maxBody, legacy:true);
        extendedBody = layer("Grub.Body", "Grub/", 0, mb:true);//new SpriteLayer("Body","$folder/Grub/", 0, maxBody, supportsMultiByte: true);


    }








}