import 'dart:html';

/*
A charm is repesented by a single symbol.

a charm can be vaccilation, in which case it has two sub charms (and renders all three of them)

this is a sub charm.

a charm also has a name. it's trove will use these to generate text

 */

class Charm {
    static List<Charm> _allCharms  = new List<Charm>();
    static List<Charm> allTroll = new List<Charm>.from(_allCharms.where((Charm c)=> c.troll || c.human));
    static List<Charm> allLeprechaun = new List<Charm>.from(_allCharms.where((Charm c)=> c.leprechaun));
    static List<Charm> allDynamo = new List<Charm>.from(_allCharms.where((Charm c)=> c.dynamo));
    static List<Charm> allGloriousBullshit = new List<Charm>.from(_allCharms.where((Charm c)=> c.gloriousBullshit));


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

    Charm(String this.name, {bool this.human, bool this.troll, bool this.leprechaun, bool this.dynamo, bool this.gloriousBullshit}) {
        _allCharms.add(this);
    }

    //for editing, not in a canvas yet.
    void draw(Element element) {
        ImageElement img = new ImageElement(src:imgLocation);
        element.append(img);
    }

    static initCharms() {
        new Charm("Hearts", human: true);
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
        new Charm("CharmPotsOfGold", leprechaun: true)

        //TODO have shogunate stuff

        //TODO make a vaccilation charm (which has two random subsets, have it set by trove)





    }
}