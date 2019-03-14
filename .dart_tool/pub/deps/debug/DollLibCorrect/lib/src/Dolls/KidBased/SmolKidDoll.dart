import "../../commonImports.dart";
import "../Doll.dart";
import '../Layers/PositionedLayerPlusUltra.dart';
import "../Layers/SpriteLayer.dart";
import "HomestuckDoll.dart";


class SmolKidDoll extends HomestuckDoll {

    @override
    String originalCreator = "Luigicat";

    @override
    int renderingType = 37;

    @override
    String name = "Smol";


    //Don't go over 255 for any old layer unless you want to break shit. over 255 adds an exo.

    @override
    int maxBody = 21;


    @override
    String relativefolder = "images/Homestuck";

    SmolKidDoll([int sign]) :super() {
        if(sign != null) {
            //makes sure palette is sign appropriate
            randomize();
        }
    }






    @override
    Doll hatch() {
        HomestuckDoll newDoll = new HomestuckDoll();
        int seed = associatedColor.red + associatedColor.green + associatedColor.blue + renderingOrderLayers.first.imgNumber ;
        newDoll.rand = new Random(seed);
        newDoll.randomize();
        Doll.convertOneDollToAnother(this, newDoll);
        newDoll.symbol.imgNumber = 0; //use canon sign you dunkass.
        return newDoll;
    }


    @override
    void initLayers() {
        super.initLayers();
        //only do what is special to me here.
        //print("initializing layers, folder is: $folder and use absolute path is $useAbsolutePath");

        extendedBody = layer("Smol.SmolBody", "SmolBody/", 1);//new SpriteLayer("SmolBody","$folder/SmolBody/", 1, maxBody);
        double scale = 0.6;
        int smolWidth = (width * scale).round();
        int smolHeight = (height * scale).round();
        int x = 85;
        int y = 123;


        leftEye = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.LeftEye", "LeftEye/", 1);//new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"LeftEye","$folder/LeftEye/", 1, maxEye)..primaryPartner = false;
        rightEye = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.RightEye", "RightEye/", 1);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"RightEye","$folder/RightEye/", 1, maxEye)..partners.add(leftEye);

        extendedHairTop = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.HairFront", "HairTop/", 1, secret:maxSecretHair);//new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"HairFront","$folder/HairTop/", 1, maxHair)..secretMax = maxSecretHair;
        extendedHairBack = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.HairBack", "HairBack/", 1, secret:maxSecretHair)..slaveTo(extendedHairTop);//new PositionedLayerPlusUltra(smolWidth, smolHeight, x,y,"HairBack","$folder/HairBack/", 1, maxHair)..secretMax = maxSecretHair;
        //extendedHairBack.syncedWith.add(extendedHairTop);
        //extendedHairTop.syncedWith.add(extendedHairBack);
        //extendedHairBack.slave = true;

        glasses = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.Glasses", "Glasses/", 1);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Glasses","$folder/Glasses/", 1, maxGlass);
        glasses2 = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.Glasses2", "Glasses2/", 0, secret:maxSecretGlass2);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Glasses2","$folder/Glasses2/", 0, maxGlass2)..secretMax = maxSecretGlass2;

        mouth = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.Mouth", "Mouth/", 1, secret:maxSecretMouth);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Mouth","$folder/Mouth/", 1, maxMouth)..secretMax = maxSecretMouth;
        symbol = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.Symbol", "Symbol/", 1, secret:maxSecretSymbol);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"Symbol","$folder/Symbol/", 1, maxSymbol)..secretMax = maxSecretSymbol;
        facePaint = layerPlusUltra(smolWidth, smolHeight, x, y, "Kid.FacePaint", "FacePaint/", 0);//new PositionedLayerPlusUltra(smolWidth, smolHeight,x,y,"FacePaint","$folder/FacePaint/", 0, maxFacePaint);


    }





}
