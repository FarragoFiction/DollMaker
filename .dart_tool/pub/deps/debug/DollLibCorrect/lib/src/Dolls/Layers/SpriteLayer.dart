import "../../commonImports.dart";
import '../../legacybytebuilder.dart'as OldByteBuilder;

import "../Doll.dart";

typedef void JROnClick();

//one byte of data
class SpriteLayer {

    //if this isn't set will throw an error if you try to have multiple bytes
    //LEGACY you don't need to use this anymore but taking it out might break legacy save strings
    bool supportsMultiByte = false;
    //LEGACY DO NOT USE numbytes
    int numbytes = 1; //hardcoded to be 1 for this layer type
    String imgFormat;
    String imgNameBase;
    String name;
    int _imgNumber;
    int maxImageNumber;
    //uesd for uploader until i can handle more than 255 parts
    int _secretMax = -1;

    int get secretMax {
        if(_secretMax < 0) return 254; //one byte unless otherwise noted
        return _secretMax;
    }

    void set secretMax(int n) {
        _secretMax = n;
    }


    //used for testing layers that aren't yet part of the sim
    ImageElement preloadedElement;
    String description = "";
    //slaves just match whatever another thingy tells them to do.
    bool slave = false;
    //partners aren't forced to do anything, but i need to know they exist
    bool primaryPartner = true;
    List<SpriteLayer> syncedWith  = new List<SpriteLayer>(); //for things like hair where they should always match.
    List<SpriteLayer> partners = new List<SpriteLayer>();
    bool changed = true; //generate descriptions when created, that will set it to false

    //TODO: sort this again after dealing with conversion
    static bool legacyConstructorToggle = true;
    static Doll legacyConstructorDoll = null;

    SpriteLayer(this.name, this.imgNameBase, this._imgNumber, this.maxImageNumber, {this.supportsMultiByte = false, this.syncedWith:null, this.imgFormat:"png", bool legacy = false}) {
        if (legacyConstructorToggle && !legacy) {
            String dollname = legacyConstructorDoll.name;
            String layername = name;
            String dolllayername = "$dollname.$layername";
            String layerpath = imgNameBase.substring(legacyConstructorDoll.folder.length+1);

            //print('layer("$dolllayername", "$layerpath", $_imgNumber${supportsMultiByte?", mb:true":""});');
        }

        numbytes = (secretMax/255).ceil();
        if(syncedWith == null) {
            syncedWith = new List<SpriteLayer>();
        }
    }

    String get imgLocation {
        return "$imgNameBase${imgNumber}.${imgFormat}";
    }

    @override
    String toString() {
        return name;
    }

    void saveToBuilder(ByteBuilder builder) {
        //first step, calculate exo whatever. so i guess, calculate how many bytes i would need
        //does numbytes do that for me?
        //PL says that i don't need to encode the length manually
        //expwhatever is a way to put data down, with a way to get exactly that data back
        builder.appendExpGolomb(imgNumber); //for length
    }

    //do not use this, in fact TODO delete this when i am done, purge this mistake from the earth.
    void saveToBuilderOld(ByteBuilder builder) {
        if(numbytes == 1 || numbytes == 0) {
            builder.appendByte(imgNumber);
        }else if(!supportsMultiByte) {
            //should first write the exo, then the numberm
            throw("not  supported for ${numbytes} bytes for ${name}, max is ${maxImageNumber} is invalid");
        }else {
            //first step, convert 4 byte signed integer into byte array
            //then store number of bytes, chopping off any excess beyond numBytes
            //v2: can store shorts and can store ints.
            if(numbytes == 2) {
                builder.appendShort(imgNumber);

            }else {
                builder.appendInt32(imgNumber);
            }
        }
    }

    void randomize() {
        Random rand  = new Random();
        imgNumber = rand.nextInt(maxImageNumber);
        for(SpriteLayer l in syncedWith) {
            l.imgNumber = imgNumber;
        }
    }

    Future<Null> drawSelf(CanvasElement buffer) async {
        if(preloadedElement != null) {
            //print("I must be testing something, it's a preloaded Element");
            bool res = await Renderer.drawExistingElementFuture(buffer, preloadedElement);
        }else {
            bool res = await Renderer.drawWhateverFuture(buffer, imgLocation);
        }
    }

    Element parseDataForDebugging(ImprovedByteReader reader) {
        return new DivElement()..text = "${reader.readExpGolomb()}";
    }

    void loadFromReader(ImprovedByteReader reader) {
        imgNumber = reader.readExpGolomb();
    }

    void loadFromReaderOld(OldByteBuilder.ByteReader reader) {
        numbytes = (secretMax/255).ceil();
       // print("in legacy reader, numbytes is $numbytes");
        //print("I am $name and number of bytes is $numbytes and secretMax is $secretMax");
        if(numbytes == 1 || numbytes == 0) {
            imgNumber = reader.readByte();
            //print("single byte read is $imgNumber");
        }else if(!supportsMultiByte) {
            throw("not  supported for ${numbytes} bytes, max is ${secretMax} is invalid");
        }else {
            if(numbytes == 2) {
                imgNumber = reader.readShort();
              //  print("short byte read is $imgNumber");
            }else {
                imgNumber = reader.readInt32();
                //print("int bytes read is $imgNumber");
            }
        }
    }





    int get imgNumber {
        return _imgNumber;
    }

    //so i know to update the description
    void set imgNumber(int i) {
        _imgNumber = i;
        changed = true;
        //things like hair top/back
        for(SpriteLayer l in syncedWith) {
            if(l.imgNumber != i) l.imgNumber = i; //no infinite loops, dunkass
        }
    }

    void slaveTo(SpriteLayer master) {
        this.syncedWith.add(master);
        master.syncedWith.add(this);
        this.slave = true;
    }

    void addPartner(SpriteLayer partner) {
        partner.primaryPartner = false;
        this.partners.add(partner);
    }
}
