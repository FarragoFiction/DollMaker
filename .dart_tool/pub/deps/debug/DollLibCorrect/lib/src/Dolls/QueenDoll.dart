import "../../DollRenderer.dart";
import "../Rendering/ReferenceColors.dart";
import "../commonImports.dart";
import "Layers/SpriteLayer.dart";

/*

Queen dolls are a little different.

instead of set layers, like eyes, mouth etc.
they have variable ones.

Instead of the normal drop downs, they have
"prototype with X".

BUT I don't want them to not be a 'doll'. I.e. they should have the standard rendering code.

So how to do.

Let's look at how rendring works.

Maybe i should refactor so a spriteLayer knows how to fetch  it's own image? (does it already?)

yup, all i need to do is extend sprite layer.  good past jr. best friend.

will also need to figure out how to do the drop downs.
 */

 class QueenDoll extends NamedLayerDoll{

     @override
     String originalCreator = "zaqInABox";

     //noice, Sn8wman's number is the rendering type on accident.
     @override
     int renderingType =8;


     @override
     String name = "Queen";

     Palette paletteSource = ReferenceColours.QUEEN_PALETTE;

     @override
     String relativefolder = "images/Homestuck/Queen";

     @override
     int width = 413;
     @override
     int height = 513;


     @override
     List<SpriteLayer>  get renderingOrderLayers => layers;
     //whatever is last thing gets set to zero for dads and i don't know why. oh well, just use base for last thing, since it has to be zero
     @override
     List<SpriteLayer>  get dataOrderLayers => layers;

     //no color replacement.
     Palette palette = new QueenPalette()
     ..carapace = '#000000'
     ..cracks = '#ffffff';

     @override
     List<String> possibleParts = Doll.dataValue("Queen.parts");//<String>["Bird","Bug","Buggy_As_Fuck_Retro_Game","Butler", "Cat", "Chihuahua","Chinchilla","Clippy","Cow","Cowboy","Doctor","Dutton","Fly","Game_Bro","Game_Grl","Gerbil","Github","Golfer","Google","Horse","Husky","Internet_Troll","Kid_Rock","Librarian","Llama","Mosquito","Nic_Cage","Penguin","Pitbull","Pomeranian","Pony","Praying_Mantis","Rabbit","Robot","Sleuth","Sloth","Tissue","Web_Comic_Creator","Pigeon","Octopus", "Worm", "Kitten","Fish"];

     QueenDoll([bool randomColor = true]) {
         initLayers();
         if(randomColor == true) {
             randomize();
         }else {
             randomizeNotColors();
         }
     }


     //queen starts with variable layers.
   @override
  void initLayers() {
    // TODO: implement initLayers. first is body
       layers.clear();
       layers.add(new NamedSpriteLayer(<String>[],"Body","$folder/", 0, 0));
       layers.add(new NamedSpriteLayer(<String>[],"Crown","$folder/", 0, 0));
  }

    @override
     void randomizeNotColors() {
                 if(rand == null) rand = new Random();;
         initLayers();
         //how many players?
         int numLayers = rand.nextInt(4) + 2;
         for(int i = 0; i< numLayers; i++) {
            addLayerNamed(rand.pickFrom(possibleParts));
         }

     }

     @override
     void randomizeColors() {
                 if(rand == null) rand = new Random();;
         double number = rand.nextDouble();
         QueenPalette p = palette as QueenPalette;
         if(number > .6) {
            p.cracks = new Colour(0,0,0);
            p.carapace = new Colour(255,255,255);
         }else if(number > .3) {
             p.cracks = new Colour(255,255,255);
             p.carapace = new Colour(0,0,0);
         }else {
            super.randomizeColors();
         }
     }

 }





/// Convenience class for getting/setting aspect palettes
class QueenPalette extends Palette {
    static String _CARAPACE = "carapace";
    static String _CRACKS = "cracks";

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



    Colour get carapace => this[_CARAPACE];

    void set carapace(dynamic c) => this.add(_CARAPACE, _handleInput(c), true);

    Colour get cracks => this[_CRACKS];

    void set cracks(dynamic c) => this.add(_CRACKS, _handleInput(c), true);
}



