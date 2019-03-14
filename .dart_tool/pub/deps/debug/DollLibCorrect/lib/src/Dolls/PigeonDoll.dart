import "../../DollRenderer.dart";
import "../commonImports.dart";
import "Doll.dart";
import "Layers/SpriteLayer.dart";


class PigeonDoll extends Doll {

    @override
    String originalCreator = "Xexus";

    //TODO random set of pigeon palettes maybe for random colored pigeons?
    int maxBody = 1;
    int maxHead = 3;
    int maxTail = 0;
    int maxWing = 1;

    String relativefolder = "images/Pigeon";

    SpriteLayer body;
    SpriteLayer head;
    SpriteLayer wing;
    SpriteLayer tail;

    @override
    String name = "Pigeon";


    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[tail, body,head,wing];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body,head,wing,tail];

    @override
    List<Palette> get validPalettes => <Palette>[redBird2, greyBird, frohike,traitor,whiteBird,byers,redBird,blackBird];


    @override
    int width = 500;
    @override
    int height = 500;

    @override
    int renderingType =113; //true arc number

    @override
    Palette paletteSource = new PigeonPalette()
        ..eyes = '#f6ff00'
        ..skin = '#00ff20'
        ..feather1 = '#ff0000'
        ..accent = "#b400ff"
        ..feather2 = '#0135ff';

    @override
    Palette palette = new PigeonPalette()
        ..eyes = '#FF9B00'
        ..skin = '#EFEFEF'
        ..accent = "#b400ff"
        ..feather1 = '#DBDBDB'
        ..feather2 = '#C6C6C6';

    @override
    Palette whiteBird = new PigeonPalette()
        ..eyes = '#ffffff'
        ..skin = '#ffc27e'
        ..accent = "#ffffff"
        ..feather1 = '#ffffff'
        ..feather2 = '#f8f8f8';

    @override
    Palette traitor = new PigeonPalette()
        ..eyes = '#e8da57'
        ..skin = '#dba0a6'
        ..accent = "#a8d0ae"
        ..feather1 = '#e6e2e1'
        ..feather2 = '#bc949d';

    @override
    Palette frohike = new PigeonPalette()
        ..eyes = '#e8da57'
        ..skin = '#5c372e'
        ..accent = "#b400ff"
        ..feather1 = '#b57e79'
        ..feather2 = '#a14f44';

    @override
    Palette byers = new PigeonPalette()
        ..eyes = '#e8da57'
        ..skin = '#807174'
        ..accent = "#77a88b"
        ..feather1 = '#dbd3c8'
        ..feather2 = '#665858';

    @override
    Palette greyBird = new PigeonPalette()
        ..eyes = '#FF9B00'
        ..skin = '#ffc27e'
        ..accent = "#b400ff"
        ..feather1 = '#DBDBDB'
        ..feather2 = '#4d4c45';

    @override
    Palette redBird = new PigeonPalette()
        ..eyes = '#FF9B00'
        ..skin = '#bb8d71'
        ..accent = "#b400ff"
        ..feather1 = '#ffffff'
        ..feather2 = '#4d1c15';

    @override
    Palette redBird2 = new PigeonPalette()
        ..eyes = '#FF9B00'
        ..skin = '#bb8d71'
        ..accent = "#b400ff"
        ..feather1 = '#4d1c15'
        ..feather2 = '#ffffff';

    @override
    Palette blackBird = new PigeonPalette()
        ..eyes = '#ba5931'
        ..skin = '#000000'
        ..accent = "#3c6a5d"
        ..feather1 = '#0a1916'
        ..feather2 = '#252e2c';

    PigeonDoll() {
        initLayers();
        randomize();
    }


    @override
    void initLayers() {
        body = layer("Pigeon.Body", "Body/", 1);//new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
        head = layer("Pigeon.Head", "Head/", 1);//new SpriteLayer("Head", "$folder/Head/", 1, maxHead);
        wing = layer("Pigeon.Wing", "Wing/", 1);//new SpriteLayer("Wing", "$folder/Wing/", 1, maxWing);
        tail = layer("Pigeon.Tail", "Tail/", 1);//new SpriteLayer("Tail", "$folder/Tail/", 1, maxTail);

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
    randomizeColors() {
                if(rand == null) rand = new Random();;
        copyPalette(rand.pickFrom(validPalettes));
    }



    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
    }

}




class PigeonPalette extends Palette {
    static String _EYES = "eyes"; //yellow
    static String _SKIN = "skin"; //green
    static String _FEATHER1 = "feather1"; //red
    static String _FEATHER2 = "feather2"; //blue
    static String _ACCENT = "accent"; //purple

    static Colour _handleInput(Object input) {
        if (input is Colour) {
            return input;
        }
        if (input is int) {
            return new Colour.fromHex(input, input
                .toRadixString(16)
                .padLeft(6, "0")
                .length > 6);
        }
        if (input is String) {
            if (input.startsWith("#")) {
                return new Colour.fromStyleString(input);
            } else {
                return new Colour.fromHexString(input);
            }
        }
        throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
    }

    Colour get text => this[_EYES];

    Colour get eyes => this[_EYES];

    void set eyes(dynamic c) => this.add(_EYES, _handleInput(c), true);

    Colour get skin => this[_SKIN];

    void set skin(dynamic c) => this.add(_SKIN, _handleInput(c), true);

    Colour get accent => this[_ACCENT];

    void set accent(dynamic c) => this.add(_ACCENT, _handleInput(c), true);

    Colour get feather1 => this[_FEATHER1];

    void set feather1(dynamic c) => this.add(_FEATHER1, _handleInput(c), true);

    Colour get feather2 => this[_FEATHER2];
    void set feather2(dynamic c) => this.add(_FEATHER2, _handleInput(c), true);


}