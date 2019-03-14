import "../../../DollRenderer.dart";
import "../../Rendering/ReferenceColors.dart";
import "../../commonImports.dart";
import "../Doll.dart";
import "../Layers/SpriteLayer.dart";

class FruitDoll extends Doll {

    static List <int> mutants = <int>[56,50,55,44,50,48,46,27,24,15,14,76,74,71,62,34,59,61,57,86];

    @override
    Colour get associatedColor {

        if(palette is HomestuckPalette ) {
            return  (palette as HomestuckPalette).shoe_light;
        }else {
            return  palette.first;
        }
    }

    //fruits have a different seed algo so that the global seed bank in LOHAE is all neat and tidy
    //net effect is there is 1000 * body numbers of possible fruits.
    //or put another way, there is 999 color variation sets for each fruit body.
    @override
    int get seed {
        int s = body.imgNumber;
        //multiply it by powers of ten so they don't overlap with each other
        s = s * 1000; //last three digits are zero, will store numbers derived from hue, saturation and value there.
        //for color, if the hue is .3, the saturation is .5 and the value is .7
        //we would end up with a number like  s + 300+50+7 or s + 357;
        //the weird shit double.parse(associatedColor.hue.toStringAsFixed(1)
        //that shit? it makes sure the values are a single decimal, not like .338 which would end up 338 which would step on saturation and value
        s += (double.parse(associatedColor.hue.toStringAsFixed(1))*900).round();
        s += (double.parse(associatedColor.saturation.toStringAsFixed(1))*90).round();
        s += (double.parse(associatedColor.value.toStringAsFixed(1))*9).round();
        //what this means is fruit color can change a bit without changing the name

        return s;
    }

    @override
    List<Palette> validPalettes = new List<Palette>.from(ReferenceColours.paletteList.values);

    int maxBody = 86;
    String relativefolder = "images/Fruit";

    SpriteLayer body;

    @override
    List<SpriteLayer>  get renderingOrderLayers => <SpriteLayer>[body];
    @override
    List<SpriteLayer>  get dataOrderLayers => <SpriteLayer>[body];


    @override
    int width = 50;
    @override
    int height = 50;

    @override
    int renderingType =35;

    @override
    String name = "Fruit";

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

    @override
    String originalCreator = "jadedResearcher and dystopicFuturism";

    FruitDoll([Random setRand]) {
        if(setRand != null) rand = setRand;
        if(rand == null) rand = new Random();
        initPalettes(); //since a fruit makes a tree, needs same palettes
        initLayers();
        randomize();
        rand = new Random(seed);
        setName();
    }

    void initPalettes() {
        rand.nextInt(); //initialize it before palette time
        for(int i = 0; i < 13*2; i++) {
            validPalettes.add(makeRandomPalette());
        }
    }

    Colour getRandomFruitColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.16); //up to green
        //60 to 180 is green so avoid that
        //.16 to 0.5
        if(rand.nextBool()) {
            color = rand.nextDouble(0.5) + 0.5; //blue to pink
        }
        return new Colour.hsv(color,1.0,rand.nextDouble()+0.5);
    }

    Colour getRandomLeafColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.44-0.16)+0.16;// up to green minus the reds
        return new Colour.hsv(color,rand.nextDouble()+0.5,rand.nextDouble()+0.1);
    }

    Colour getRandomBarkColor() {
        //reds, purples, yellows are all valid, so lets go for hsv, max s and at least 50% v?
        double color = rand.nextDouble(0.13);// up to yellow
        return new Colour.hsv(color,rand.nextDouble()+0.25,rand.nextDouble()+0.1);
    }

    Palette makeRandomPalette() {
        //print("making a random palette for $name");
        HomestuckPalette newPalette = new HomestuckPalette();

        newPalette.add(HomestuckPalette.SHOE_LIGHT, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.SHOE_LIGHT, <String>[HomestuckPalette.SHOE_DARK, HomestuckPalette.ACCENT]);

        newPalette.add(HomestuckPalette.ASPECT_LIGHT, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.ASPECT_LIGHT, <String>[HomestuckPalette.ASPECT_DARK]);

        newPalette.add(HomestuckPalette.HAIR_MAIN, getRandomFruitColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.HAIR_MAIN, <String>[HomestuckPalette.HAIR_ACCENT]);

        newPalette.add(HomestuckPalette.SHIRT_LIGHT, getRandomBarkColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.SHIRT_LIGHT, <String>[HomestuckPalette.SHIRT_DARK]);

        newPalette.add(HomestuckPalette.PANTS_LIGHT, getRandomBarkColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.PANTS_LIGHT, <String>[HomestuckPalette.PANTS_DARK]);

        newPalette.add(HomestuckPalette.CLOAK_LIGHT, getRandomLeafColor(),true);
        makeOtherColorsDarker(newPalette, HomestuckPalette.CLOAK_LIGHT, <String>[HomestuckPalette.CLOAK_MID, HomestuckPalette.CLOAK_DARK]);
        return newPalette;
    }

    @override
    Future<Null> setNameFromEngine() async {
        setName();
    }


    void setName() {
        WeightedList<String> genericStarts = new WeightedList<String>();
        genericStarts.addAll(<String>["Fox","Badger","Honey Badger","Skunk","Bird","Birb","Borb","Cloud","Servant","Logan","Elder","Young","Deer","Antelope","Mull","Chintz"]);
        genericStarts.addAll(<String>["Dry","Crocodile","Rose","Bed","Service","Sea","Gulf","Golf","Base","Fort","Saw","Spiny","Strawberry","Tamarind","Thimble","Vanilla","Wax","Choke","Alien"]);
        genericStarts.addAll(<String>["Alligator","Crocodile","Snake","Salamander","Turtle","Guava","Grape","Hairless","Ice Cream","Hardy","Huckle","Jack","Juniper","Palm","Kumquat","Lady"]);
        genericStarts.addAll(<String>["Shenanigan","Crazy","Adult","Truth","Lie","Bone","Honey","Tiger","Relish","Salsa","Giggle","Dance","Party","Fiesta","Ground","Button"]);
        genericStarts.addAll(<String>["Rock","Stone","Pit","Wood","Metal","Bone","Custard","Hair","Fluffy","Fae","Claw","Beach","Bitter","Buffalo", "Bush","Tree","Vine","Yew"]);
        genericStarts.addAll(<String>["Medicinal","Cleaning","Cleansing","Mowhawk","Hawk","Sparrow","Parrot","Tropical","Mop","Gravity","Vision","Eagle","Winter","Spring","Summer","Fall"]);
        genericStarts.addAll(<String>["Straw","Hay","Barn","Field","Farm","Mine","Craft","Compote","Curry","Sauce","Yes","No","Bob","Donkey","Cape","Cashew"]);
        genericStarts.addAll(<String>["Salt","Sugar","Pepper","Spicy","Cran","Gum","Razz","Pepo","Banana","Mango","Bay","Nutrient","Health","Citris","Cherry"]);
        genericStarts.addAll(<String>["Goose","Duck","Pawpaw","Quince","Bully","Cow","Ox","Rabbit","Ginko","Medicine","Syrup","Roll","Cheese","Dimple"]);
        genericStarts.addAll(<String>["Crab","Ugli","Pawpaw","Passion","Apricot","Key","Island","Ocean","Lake","River","One","Angel","Devil","Hand","Energy","Coffee"]);
        genericStarts.addAll(<String>["Dust","Mud","Leaf","Seed","Juicey","Moose","Squirrell","Bone","Pain","Blush","Skull","Finger","Haste","Sleep","Eastern","Northern","Southern","Western"]);
        genericStarts.addAll(<String>["Mob","Psycho","Psychic","Butter","Drink","Ghost","Magic","Wizard","Chocolate","Pudding","Desert","Dessert","Sand","Jungle","Snow"]);
        genericStarts.addAll(<String>["Meadow","Forest","City","Exotic","Socratic","Historical","Wood","Spice","Meat","Fast","Family","Plum","Temper","Wolf"]);
        genericStarts.addAll(<String>["Plant","Star","Bread","Yum","Sweet","Juicy","Tart","Sour","Bitter","Musk","Dragon","Bird","Lizard","Horse","Pigeon","Emu","Elephant","Fig"]);
        genericStarts.addAll(<String>["Planet","Cosmic","Delicious","Rice","Snack","Dinner","Hazle","Pea","Chest","Song","Pain","Tall","Hard","Soft","Cola","Crow","Common"]);
        genericStarts.addAll(<String>["Canary","Duck","Monkey","Ape","Bat","Pony","Shogun","Jaded","Paradox","Karmic","Manic","Table","Aspiring","Recursive"]);
        genericStarts.addAll(<String>["Woo","Chew","Bite","Dilletant","Oracle","Insomniac","Insufferable","Some","Body","Mathematician","Guardian","Mod","Watcher","Slacker"]);
        genericStarts.addAll(<String>["Good","Bad","Dog","Land","Retribution","Researcher","Cat","Troll","Canine","Gull","Wing","Pineapple","Cactus","Coma","Catatonic","Cumulus"]);
        genericStarts.addAll(<String>["Moon","Cool","Yogistic","Doctor","Knight","Seer","Page","Mage","Rogue","Sylph","Fairy","Thief","Maid","Heir","Prince","Witch","Hag","Mermaid"]);
        genericStarts.addAll(<String>["Fish","Corpse","Cake","Muffin","Bacon","Pig","Taco","Salsa","Carpet","Kiwi","Snake","Salamander","Breath","Time","King","Queen","Royal","Clubs"]);
        genericStarts.addAll(<String>["Spades","Heart","Diamond","Butler","Doom","Blood","Heart","Mind","Space","Light","Void","Rage","Bacchus","Drunk","Hope","Life","Durian"]);
        genericStarts.addAll(<String>["Guide","Ring","Pomelo","Sharp","Prickly","Donut","Baby","Papaya","Oil","Poisonous","Toxic","Generic","Wine","Jelly","Jam","Juice","Gum","Fire","Icy","Blanket","Cool","Heat","Dour","Shadow","Luck","Rattle"]);
        genericStarts.addAll(<String>["Script","Java","Dart","Dank","Muse","Lord","Meme","May","June","Mock","Mountain","Nut","Apple","Grape","Sauce","Dream","Rain","Mist","Sand","Mighty","Orange","Tangerine","Water","Cave","Dirt","Clam","Apple","Berry","Date","Marriage"]);
        genericStarts.addAll(<String>["Army","Navy","Marine","Tank","Walk","Run","Hop","Jump","Skip","March","Meow","Woof","Hoof","Slime","Joint","Taco","Mint","Fog","Wind","Love","Hate","Stable","Correct","Omni","All","Flavor","Hybrid","Jerry","Pickle","Acid"]);

        genericStarts.add("Tidepod", 0.5);
        genericStarts.add("Forbidden", 0.5);
        genericStarts.add("God", 0.5);
        genericStarts.add("Rare", 0.5);


        WeightedList<String> genericEnds = new WeightedList<String>();
        genericEnds.addAll(<String>["Seed","Fruit","Berry","Nut"]);
        genericEnds.add("Melon", 0.3);
        genericEnds.add("Fig", 0.3);
        genericEnds.add("Mango", 0.3);
        genericEnds.add("Apple", 0.3);
        genericEnds.add("Bean", 0.3);
        genericEnds.add("Lemon", 0.3);
        genericEnds.add("Peach", 0.3);
        genericEnds.add("Plum", 0.3);
        genericEnds.add("Gum", 0.1);
        genericEnds.add("Currant", 0.1);
        genericEnds.add("Apricot", 0.3);

        if(body.imgNumber == 11) genericEnds.add("Apple",33.0);
        if(body.imgNumber == 13) genericEnds.add("Mystery",33.0);
        if(body.imgNumber == 6) genericEnds.add("Grape",33.0);
        if(body.imgNumber == 12) genericEnds.add("Cherry",33.0);
        if(body.imgNumber == 33) genericEnds.add("Star",33.0);
        if(body.imgNumber == 17) genericEnds.add("Pepper",33.0);
        if(body.imgNumber == 27) genericEnds.add("Bulb",33.0);

        if(body.imgNumber == 24 ) genericStarts.add("Eye",100.0);
        if(body.imgNumber == 80 ) genericStarts.add("Bread",300.0);
        if(body.imgNumber == 86 ) genericStarts.add("Pizza",300.0);
        if(body.imgNumber == 74 ) genericStarts.add("Skull",100.0);
        if(body.imgNumber == 45 ) genericStarts.add("Puzzle",100.0);
        if(body.imgNumber == 60 ) genericStarts.add("Crab",100.0);
        if(body.imgNumber == 71 ) genericStarts.add("Bun",100.0);
        if(body.imgNumber == 57 || body.imgNumber == 56  ) genericStarts.add("Loss",100.0);
        if(body.imgNumber == 76 ) genericStarts.add("Flame",100.0);
        if(body.imgNumber == 26 ) genericStarts.add("Cod",100.0);
        if(body.imgNumber == 14 ) genericStarts.add("Justice",100.0);
        if(body.imgNumber == 15 ) genericStarts.add("Frog",100.0);

        if(body.imgNumber >= 82 && body.imgNumber <=85) {
            genericStarts.add("Fresh",300.0);
            genericStarts.add("Impudent",300.0);
            genericStarts.add("Fruity",300.0);
            genericStarts.add("Rambunctious",300.0);
            genericStarts.add("Rumpus",300.0);
            genericStarts.add("Rude",300.0);
            genericStarts.add("Mock",300.0);
        }

        Random freshRand = new Random(seed);
        String start = freshRand.pickFrom(genericStarts);
        String end = freshRand.pickFrom(genericEnds);

        dollName = "$start $end";
    }

    @override
    String toString() {
        if(dollName == name) setName();
        return dollName;
    }


    @override
    void initLayers() {
        body = new SpriteLayer("Body", "$folder/Body/", 1, maxBody);
    }

    @override
    void randomize() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        randomizeColors();
        setName();
    }



    @override
    void randomizeNotColors() {
                if(rand == null) rand = new Random();;
        for (SpriteLayer l in renderingOrderLayers) {
            l.imgNumber = rand.nextInt(l.maxImageNumber + 1);
        }
        setName();
    }

    void randomizeColors() {
        if(rand == null) rand = new Random();
        //i like the weird red trees with the black fruit
        //validPalettes.remove(ReferenceColours.BURGUNDY);
        validPalettes.remove(ReferenceColours.ANON);
        validPalettes.remove(ReferenceColours.BRONZE);
        validPalettes.remove(ReferenceColours.GOLD);
        validPalettes.remove(ReferenceColours.OLIVE);
        validPalettes.remove(ReferenceColours.LIMEBLOOD);
        validPalettes.remove(ReferenceColours.JADE);
        validPalettes.remove(ReferenceColours.TEAL);
        validPalettes.remove(ReferenceColours.CERULEAN);
        validPalettes.remove(ReferenceColours.INDIGO);
        validPalettes.remove(ReferenceColours.PURPLE);
        validPalettes.remove(ReferenceColours.VIOLET);
        validPalettes.remove(ReferenceColours.FUSCHIA);


        Palette newPallete = rand.pickFrom(validPalettes);
        copyPalette(newPallete);
        setName();
    }


}


