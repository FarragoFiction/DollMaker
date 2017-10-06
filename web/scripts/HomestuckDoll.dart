import "random.dart";
import "includes/colour.dart";
import "Doll.dart";
import "SpriteLayer.dart";
import "dart:typed_data";
import 'dart:convert';
import "includes/bytebuilder.dart";

class HomestuckDoll extends Doll {

    @override
    String folder = "Homestuck";
    final int maxBody = 65; //holy shit, is tht really how many we have?



    HomestuckDoll() {
        layers.add(new SpriteLayer("$folder/Body/", 1, maxBody));

        randomizeNoColor();
    }

    HomestuckDoll.fromDataString(String dataString){
        Uint8List thingy = BASE64URL.decode(dataString);
        ByteReader reader = new ByteReader(thingy.buffer, 0);
        //initFromReader(reader);
    }

     HomestuckDoll.fromReader(ByteReader reader){
         //initFromReader(reader);
     }

    String toDataBytesX([ByteBuilder builder = null]) {
        if(builder == null) builder = new ByteBuilder();
         int length = layers.length + 3;  //3 for colors
         builder.appendExpGolomb(length); //for length
         //builder.appendByte(color.red);
         //builder.appendByte(color.green);
         //builder.appendByte(color.blue);
        // builder.appendByte(quality);
         for(SpriteLayer l in layers) {
             print("adding ${l.imgNameBase} to data string builder.");
             builder.appendByte(l.imgNumber);
         }
         return BASE64URL.encode(builder.toBuffer().asUint8List());
     }




    void randomize() {
        Random rand = new Random();
        //color = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
        for(SpriteLayer l in layers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber+1);
            if(l.imgNumber == 0) l.imgNumber = 1;
        }
    }

     void randomizeNoColor() {
         Random rand = new Random();
         for(SpriteLayer l in layers) {
             l.imgNumber = rand.nextInt(l.maxImageNumber+1);
             if(l.imgNumber == 0) l.imgNumber = 1;
         }
     }



}