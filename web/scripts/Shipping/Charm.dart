import 'Trove.dart';
import 'dart:async';
import 'dart:html';

import 'package:CommonLib/Random.dart';
import 'package:RenderingLib/RendereringLib.dart';
import 'package:TextEngine/TextEngine.dart';

/*
A charm is repesented by a single symbol.

a charm can be vaccilation, in which case it has two sub charms (and renders all three of them)

this is a sub charm.

a charm also has a name. it's trove will use these to generate text

 */

class Charm {
    static String SHOGUN = "Shitsphere";
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
    //so i can remove myself from it on click
    Vacillation vaccilator;

    String get imgLocation => "$folder$name.png";

    //if add more optional params remember to modify clone function
    Charm(String this.name, {bool this.human: false, bool this.troll:false, bool this.leprechaun:false, bool this.dynamo:false, bool this.gloriousBullshit:false}) {
        decideIfAdd();
    }

    void decideIfAdd() {
        bool notYetIn = true;
        for(Charm c in _allCharms) {
            if(c.name == name){
                notYetIn = false;
            }
        }
        if(notYetIn)_allCharms.add(this);
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

    Charm clone() {
        return new Charm(name, human: human, troll:troll, leprechaun: leprechaun, dynamo: dynamo, gloriousBullshit: gloriousBullshit);
    }


    //for editing, not in a canvas yet.
    void draw(Element element) {
        ImageElement img = new ImageElement(src:imgLocation);
        element.append(img);
        img.onClick.listen((Event e) {
            if(trove != null) trove.removeCharm(this);
            if(vaccilator != null) vaccilator.cycleCharm(this);
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
        if(_allCharms == null || _allCharms.isEmpty) {
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
        }
    }
}

class Vacillation extends Charm {
    Charm first;
    Charm second;
    //doesn't take them in at creation tho, but later
    Vacillation() : super("Vacillation",human: false, troll:true, leprechaun:true, dynamo:true, gloriousBullshit:true);


    @override
    Charm clone() {
        return new Vacillation();
    }


    @override
    void draw(Element element) {
        if(first == null) setRandomSubCharms();
        first.vaccilator = this;
        second.vaccilator = this;
        print("trying to draw a vaccilation between $first and $second");
        DivElement span = new DivElement();
        span.style.display = "inline";
        element.append(span);
        span.style.border = "2px solid black"; //so you know what's vaccilating
        first.draw(span);

        ImageElement img = new ImageElement(src:imgLocation);
        span.append(img);
        element.append(span);
        img.onClick.listen((Event e) {
            if(trove != null) {
                trove.removeCharm(this);
                trove.removeCharm(first);
                trove.removeCharm(second);
            }
        });
        second.draw(span);
    }

    //when my side charms are clicked,
    void cycleCharm(Charm charm) {
        String type = Charm.ANY;
        if(trove.romSelect != null && trove.romSelect.selectedIndex >0) type = trove.romSelect.options[trove.romSelect.selectedIndex].value;
        List<Charm> charmsByType = Charm.getAllCharmsByType(type);
        for(Charm c in charmsByType) {
            if(c is Vacillation) {
                charmsByType.remove(c);
                break;
            }
        }
        int index = 0; //can't just index of because clones
        for(Charm c in charmsByType) {
            if(c.name == charm.name) break;
            index ++;
        }
        //print("index of charm $charm is $index in $charmsByType");
        index ++;
        //print("index of charm plus one  is $index");
        if(index >= charmsByType.length) {
          //  print("resetting because $index was too high for a thing of ${charmsByType.length}");
            index = 0;
        }
        //print("after checking for a cycle, index is $index");
        if(charm == first) {
            first = charmsByType[index].clone();
            first.vaccilator = this;
        }else {
            second = charmsByType[index].clone();
            second.vaccilator = this;
        }
        trove.drawCharms(null);
    }

    void setRandomSubCharms(){
        String type = Charm.ANY;
       // print("setting random thingies, trove has rom selected of ${trove.romSelect.selectedIndex}");
        if(trove.romSelect != null && trove.romSelect.selectedIndex >0) type = trove.romSelect.options[trove.romSelect.selectedIndex].value;
        //print("type for vaccilator is $type");
        List<Charm> charmsByType = Charm.getAllCharmsByType(type);
        List<Charm> availableCharms = new List<Charm>();

        for(Charm c in charmsByType) {
            bool available = true;
            for(Charm c2 in trove.charms) {
                if(c2.name == c.name) {
                    available = false;
                }else if(c2 is Vacillation) {
                    Vacillation v = c2 as Vacillation;
                    if(v.first != null && v.second != null) {
                        if (v.first.name == c.name || v.second.name == c.name) {
                            available = false;
                        }
                    }
                    }
            }
            if(available) availableCharms.add(c);
        }

        availableCharms.shuffle(new Random(trove.seed));
        print("available charms is $availableCharms");
        if(availableCharms.length < 2) { //allow repeats
            first = charmsByType.first;
            second = charmsByType.last;
        }else {
            first = availableCharms.first;
            second = availableCharms.last;
        }
    }

    @override
    Future<Null> getPossibilities(TextEngine textEngine) async{
        await textEngine.loadList(first.name);
        await textEngine.loadList(second.name);
    }
}