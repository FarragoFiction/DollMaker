import "../random.dart";
import "../includes/colour.dart";
import "../Dolls/Doll.dart";
import "../SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "../includes/bytebuilder.dart";
import "../includes/palette.dart";
abstract class Doll {
    String folder;
    int renderingType = 0;
    ///in rendering order.
    List<SpriteLayer> layers = new List<SpriteLayer>();
    Palette palette;

    void initLayers();
    void randomize() {
        randomizeColors();
        randomizeNotColors();
    }

    void randomizeColors() {
        Random rand = new Random();
        List<String> names = new List<String>.from(palette.names);
        for(String name in names) {
            palette.add(name, new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255)), true);
        }
    }

    void randomizeNotColors() {
        Random rand = new Random();
        int firstEye = -100;
        for(SpriteLayer l in layers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            //keep eyes synced unless player decides otherwise
            if(firstEye > 0 && l.imgNameBase.contains("Eye")) l.imgNumber = firstEye;
            if(firstEye < 0 && l.imgNameBase.contains("Eye")) firstEye = l.imgNumber;
            if(l.imgNumber == 0) l.imgNumber = 1;
            if(l.imgNameBase.contains("Glasses") && rand.nextDouble() > 0.35) l.imgNumber = 0;
        }
    }

    void initFromReader(ByteReader reader, Palette newP) {
        initLayers();
        int numFeatures = reader.readExpGolomb();
        int type = reader.readByte(); //not gonna use, but confirms it's homestuck
        print("I think there are ${numFeatures} features");

        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            Colour newColor = new Colour(reader.readByte(),reader.readByte(),reader.readByte());
            newP.add(name, newColor, true);
        }

        for(String name in newP.names) {
            print("loading color $name");
            palette.add(name, newP[name], true);
        }

        //layer is last so can add new layers.
        for(SpriteLayer l in layers) {
            print("loading layer ${l.name}");
            l.imgNumber = reader.readByte();
        }
    }

    String toDataBytesX([ByteBuilder builder = null]) {
        if(builder == null) builder = new ByteBuilder();
        int length = layers.length + palette.names.length + 1;//one byte for doll type
        builder.appendExpGolomb(length); //for length
        builder.appendByte(renderingType); //value of 1 means homestuck doll


        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            Colour color = palette[name];
            builder.appendByte(color.red);
            builder.appendByte(color.green);
            builder.appendByte(color.blue);
        }

        //layer is last so can add new layers
        for(SpriteLayer l in layers) {
            print("adding ${l.imgNameBase} to data string builder.");
            builder.appendByte(l.imgNumber);
        }

        return BASE64URL.encode(builder.toBuffer().asUint8List());
    }


}