import 'Charm.dart';
import 'Participant.dart';
import 'dart:async';
import 'dart:html';
import "dart:math" as Math;
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:TextEngine/TextEngine.dart';

/*

a trove is 1 or more (let's say up to 13) Charms.

it has a TextEngine, and loads the text for each of it's charms to figure out

how to generate a date.

it also has two or more dolls as participants, which it uses to seed its random (addative)
 */
class Trove {
    //only the first two will be named
    List<Participant> participants = new List<Participant>();
    SelectElement romSelect;
    SelectElement charmSelect;

    List<Charm> charms = new List<Charm>();
    Element charmDiv;
    Element storyDiv;



    int get seed {
        int ret = 0;
        participants.forEach((Participant p) {
            ret += p.doll.seed;
        });
        return ret;
    }


    Trove(List<Participant> this.participants, {List<Charm> this.charms}) {
        if(charms == null || charms.isEmpty) setCharmsRandom();
        initParticipants();
    }

    Future<Null> createStory(Element element) async{
        if(storyDiv == null) {
            storyDiv = new DivElement();
            element.append(storyDiv);
        }
        //TODO eventually have a nice canvas with the participants drawn on and the trove drawn on
        //and then all the text.
        //maybe it looks like a book? a photo albulm? instagram???
        storyDiv.text = await getStory();
    }

    Future<String> getStory() async {
        //pass this to phrases
        String ret = "${charms.join(',')} ";
        Random rand = new Random(seed);
        try {
            TextStory story = new TextStory();
            story.setString("name1","${participants.first.name}");
            story.setString("name2","${participants.last.name}");
            TextEngine textEngine = new TextEngine(seed);
            //top level things everything can access rember to import in words files
            await textEngine.loadList("TopRom");
            for (Charm c in charms) {
                print("loading ${c.name}");
                await textEngine.loadList(c.name);
            }
           // print("${textEngine.loadedFiles}");
            //begiing = how they met
            //middle = shit they did courting
            //end = how their relationship stabilized
            //story ties it all together
            ret = "$ret ${getLines('Beginning', textEngine, story)}\n\n";
            ret = "$ret ${getLines('Middle', textEngine, story)}\n\n";
            ret = "$ret ${getLines('End', textEngine, story)}\n\n";
            return ret;

        }catch(e) {
            print(e);
            return "ERROR??? In MY RomCom??? It's more likely than you'd think. $e";
        }

    }

    void removeCharm(Charm charm) {
        print("removing $charm from trove");
        charms.remove(charm);
        drawCharms(null);
    }

    String getLines(String section, TextEngine textEngine, TextStory story) {
        String ret = "";
        int numLines = getRandomNumberOfLines();
        ret = "$ret ${textEngine.phrase("${section}First", story: story)}";
        for(int i = 0; i< numLines; i++) {
           // print("number of lines is $numLines and i'm on $i");
            ret = "$ret ${textEngine.phrase(section, story: story)}";
        }
        return ret;
    }

    int getRandomNumberOfLines() {
        int ret = 0;
        int max = 1;
        max += (charms.length/2).round();
        max = Math.min(5, max);
        Random rand = new Random(seed);
        //lower numbers are most common
        for(int i = 0; i <max; i++) {
            if(rand.nextDouble() < .5) {
                ret++;
            }else {
                break;
            }
        }
        return ret;
    }


    void initParticipants() {
        for(Participant p in participants) {
            p.trove = this; //so they can refresh the charms if they change.
        }
    }

    void drawParticipants(Element element) {
        print("drawing participants");
        for(Participant p in participants) {
            p.draw(element);
        }
    }

    void drawRomTypeDropdowns(Element element) {
        romSelect = new SelectElement();
        element.append(romSelect);
        Charm.romanceTypes.forEach((String type) {
            OptionElement o = new OptionElement()..text = type..value =type;
            romSelect.append(o);
        });
        romSelect.options.first.selected;
        romSelect.onInput.listen((Event e) {
            setCharmsByType(romSelect.options[romSelect.selectedIndex].value);
            drawCharms(null);
            drawCharmDropdowns(element);
        });
        drawCharmDropdowns(element);
    }

    void drawCharmDropdowns(Element element) {
        if(charmSelect == null) {
            charmSelect = new SelectElement();
            element.append(charmSelect);
        }
        charmSelect.setInnerHtml("");
        //TODO need to draw all charms of selected
        String type = "ANY";
        if(romSelect != null && romSelect.selectedIndex >0) type = romSelect.options[romSelect.selectedIndex].value;

        List<Charm> charmsByType = Charm.getAllCharmsByType(type);
        charmsByType.forEach((Charm c) {
            OptionElement o = new OptionElement()..value = c.name..text = c.name;
            ImageElement img = new ImageElement(src: c.imgLocation);
            o.append(img);
            charmSelect.append(o);
        });

        ButtonElement addCharm = new ButtonElement()..text = "Add Charm";
        element.append(addCharm);


    }

    void drawCharms(Element element) {
        if(charmDiv == null) {
            charmDiv = new DivElement();
            element.append(charmDiv);
        }
        charmDiv.setInnerHtml(""); //wipe out any already drawn charms
        print("drawing participants");
        for(Charm c in charms) {
            c.trove = this;
            c.draw(charmDiv);
        }
        createStory(element);
    }

    void setCharmsRandom() {
        Random rand = new Random(seed);
        if(charms == null) charms = new List<Charm>();
        if(romSelect != null && romSelect.selectedIndex >0) {
            setCharmsByType(romSelect.options[romSelect.selectedIndex].value);
        } else if(participants.first.doll is HomestuckTrollDoll) {
            setCharmsTroll();
        }else {
            setCharmsByType(rand.pickFrom(Charm.romanceTypes));
        }
        if(charmDiv != null) {
            drawCharms(null);
            createStory(null);
        }
    }

    void setCharmsByType(String type) {
        if(type == Charm.TROLL) {
            setCharmsTroll();
        }else if(type == Charm.HUMAN) {
            setCharmsHuman();
        }else if(type == Charm.GLORIOUSBULLSHIT) {
            setCharmsGloriousBullshit();
        }else if(type == Charm.LEPRECHAUN) {
            setCharmsLeprechaun();
        }else if (type == Charm.SHOGUN) {
            setCharmsShogun();
        }else {
            setCharmsAll();
        }
    }

    void setCharmsAll() {
        print("going to set absolutely random charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allCharms;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int ret = 1;
        //lower numbers are most common
        for(int i = 0; i <13; i++) {
            if(rand.nextDouble() < .6) {
                ret++;
            }else {
                break; //pl has taught me dangerous things
            }
        }

        ret = Math.min(ret, copyOfAllCharms.length); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,ret);

    }

    void setCharmsLeprechaun() {
        print("going to set leprechaun charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allLeprechaun;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int ret = 3;
        //lower numbers are most common
        for(int i = 0; i <13; i++) {
            if(rand.nextDouble() < .6) {
                ret++;
            }else {
                break; //pl has taught me dangerous things
            }
        }

        ret = Math.min(ret, copyOfAllCharms.length); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,ret);

    }

    void setCharmsShogun() {
        print("going to set shogun charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allDynamo;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int ret = 2;
        //lower numbers are most common
        for(int i = 0; i <13; i++) {
            if(rand.nextDouble() < .7) {
                ret++;
            }else {
                break; //pl has taught me dangerous things
            }
        }
        ret = Math.min(ret, copyOfAllCharms.length); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,ret);
    }

    void setCharmsGloriousBullshit() {
        print("going to set gb charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allGloriousBullshit;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int ret = 1;
        //lower numbers are most common
        for(int i = 0; i <13; i++) {
            if(rand.nextDouble() < .5) {
                ret++;
            }else {
                break; //pl has taught me dangerous things
            }
        }
        ret = Math.min(ret, copyOfAllCharms.length); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,ret);
    }

    void setCharmsTroll() {
        print("going to set troll charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allTroll;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        charms.add(copyOfAllCharms.first);
        //TODO though they can also vaccilate, once i implement that
    }

    void setCharmsHuman() {
        print("going to set human charms");
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allHuman;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        charms.add(copyOfAllCharms.first);
    }

}