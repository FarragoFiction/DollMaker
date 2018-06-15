import 'dart:html';

/*
A charm is repesented by a single symbol.

a charm can be vaccilation, in which case it has two sub charms (and renders all three of them)

this is a sub charm.

a charm also has a name. it's trove will use these to generate text

 */

class Charm {
    static List<Charm> _allCharms  = new List<Charm>();
    static List<Charm> get allHuman {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List<Charm>.from(_allCharms.where((Charm c) => c.human));
    }
    static List<Charm> get allTroll {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List<Charm>.from(_allCharms.where((Charm c) => c.troll));
    }
    static List<Charm> get allLeprechaun {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List<Charm>.from(_allCharms.where((Charm c) => c.leprechaun));
    }
    static List<Charm> get allDynamo {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List<Charm>.from(_allCharms.where((Charm c) => c.dynamo));
    }

    static List<Charm> get allGloriousBullshit {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List<Charm>.from(_allCharms.where((Charm c) => c.gloriousBullshit));
    }


    static List<Charm> get allCharms {
        if(_allCharms == null || _allCharms.isEmpty) {
            initCharms();
        }
        return new List.from(_allCharms); //don't let ppl edit this
    }




    static String folder = "images/Charms/";
    String name;
    bool human = false;
    bool troll = false;
    bool leprechaun = false;
    bool dynamo = false;
    bool gloriousBullshit = false;

    String get imgLocation => "$folder$name.png";

    Charm(String this.name, {bool this.human: false, bool this.troll:false, bool this.leprechaun:false, bool this.dynamo:false, bool this.gloriousBullshit:false}) {
        _allCharms.add(this);
    }

    //for editing, not in a canvas yet.
    void draw(Element element) {
        ImageElement img = new ImageElement(src:imgLocation);
        element.append(img);
    }

    @override
    String toString() {
        return name;
    }

    static initCharms() {
        new Charm("Hearts", troll: true, human: true);
        new Charm("Spades", troll: true);
        new Charm("Diamonds", troll: true);
        new Charm("Clubs", troll: true);
        new Charm("RedSquiggles", gloriousBullshit: true);
        new Charm("GreenSquiggles", gloriousBullshit: true);
        new Charm("BlackSquiggles", gloriousBullshit: true);

        new Charm("CharmHearts", leprechaun: true);
        new Charm("CharmMoons", leprechaun: true);
        new Charm("CharmStars", leprechaun: true);
        new Charm("CharmClovers", leprechaun: true);
        new Charm("CharmDiamonds", leprechaun: true);
        new Charm("CharmHorseshoes", leprechaun: true);
        new Charm("CharmBalloons", leprechaun: true);
        new Charm("CharmRainbows", leprechaun: true);
        new Charm("CharmPotsOfGold", leprechaun: true);

        new Charm("Auberiginastycitiy", dynamo: true);
        new Charm("Smile", dynamo: true);
        new Charm("Patristewartus", dynamo: true);
        new Charm("Okay", dynamo: true);
        new Charm("hatched_chick", dynamo: true);
        new Charm("Fear", dynamo: true);
        new Charm("Thumb", dynamo: true);
        new Charm("Tpyosity", dynamo: true);
        new Charm("Dab", dynamo: true);
        new Charm("Clown", dynamo: true);
        new Charm("Horse", dynamo: true);
        new Charm("100", dynamo: true);
        new Charm("b", dynamo: true);




        //TODO make a vaccilation charm (which has two random subsets, have it set by trove)





    }
}