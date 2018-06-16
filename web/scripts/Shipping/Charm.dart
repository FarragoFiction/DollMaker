import 'Trove.dart';
import 'dart:async';
import 'dart:html';

import 'package:TextEngine/TextEngine.dart';

/*
A charm is repesented by a single symbol.

a charm can be vaccilation, in which case it has two sub charms (and renders all three of them)

this is a sub charm.

a charm also has a name. it's trove will use these to generate text

 */

class Charm {
    static String SHOGUN = "Dynamo";
    static String TROLL = "Quadrants";
    static String LEPRECHAUN = "Troves";
    static String HUMAN = "Human";
    static String GLORIOUSBULLSHIT = "Glorious Bullshit";
    static String ANY = "ANY";

    static List<String> romanceTypes = <String>[ANY, HUMAN, TROLL, LEPRECHAUN, SHOGUN, GLORIOUSBULLSHIT];


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
    //so i can remove myself from it on click
    Trove trove;

    String get imgLocation => "$folder$name.png";

    Charm(String this.name, {bool this.human: false, bool this.troll:false, bool this.leprechaun:false, bool this.dynamo:false, bool this.gloriousBullshit:false}) {
        _allCharms.add(this);
    }

    static List<Charm> getAllCharmsByType(String type) {
        if(type == TROLL) {
            return allTroll;
        }else if(type == HUMAN) {
            return allHuman;
        }else if(type == GLORIOUSBULLSHIT) {
            return allGloriousBullshit;
        }else if(type == LEPRECHAUN) {
            return allLeprechaun;
        }else if (type == SHOGUN) {
           return allDynamo;
        }else {
            return allCharms;
        }
    }

    static Charm byName(String name) {
        return allCharms.where((Charm c) => c.name == name).first;
    }


    //for editing, not in a canvas yet.
    void draw(Element element) {
        ImageElement img = new ImageElement(src:imgLocation);
        element.append(img);
        img.onClick.listen((Event e) {
            if(trove != null) trove.removeCharm(this);
        });
    }

    Future<Null> getPossibilities(TextEngine textEngine) async{
        await textEngine.loadList(name);
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
        new Vacillation();




        //TODO make a vaccilation charm (which has two random subsets, have it set by trove)
    }
}

class Vacillation extends Charm {
    Charm first;
    Charm second;
    //doesn't take them in at creation tho, but later
    Vacillation() : super("Vacillation",human: false, troll:true, leprechaun:true, dynamo:true, gloriousBullshit:true);

    //todo drawing self on canvas also draws two sub charms
    //todo and getting text also  does subcharms (move getting text into here instead of trove)
    @override
    void draw(Element element) {
        first.draw(element);
        ImageElement img = new ImageElement(src:imgLocation);
        element.append(img);
        img.onClick.listen((Event e) {
            if(trove != null) trove.removeCharm(this);
        });
        second.draw(element);
    }

    @override
    Future<Null> getPossibilities(TextEngine textEngine) async{
        await textEngine.loadList(first.name);
        await textEngine.loadList(second.name);
    }
}