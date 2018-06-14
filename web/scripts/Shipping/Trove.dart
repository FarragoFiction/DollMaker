import 'Charm.dart';
import 'Participant.dart';
import 'dart:html';
import 'package:CommonLib/Random.dart';
import "dart:math" as Math;

/*

a trove is 1 or more (let's say up to 13) Charms.

it has a TextEngine, and loads the text for each of it's charms to figure out

how to generate a date.

it also has two or more dolls as participants, which it uses to seed its random (addative)
 */
class Trove {
    List<Participant> participants = new List<Participant>();
    List<Charm> charms = new List<Charm>();
    Element charmDiv;

    int get seed {
        int ret = 0;
        participants.forEach((Participant p) {
            ret += p.doll.seed;
        });
        return ret;
    }

    Trove(List<Participant> this.participants, {List<Charm> this.charms}) {
        if(charms == null || charms.isEmpty) setCharms();
        initParticipants();
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

    void drawCharms(Element element) {
        if(charmDiv == null) {
            charmDiv = new DivElement();
            element.append(charmDiv);
        }
        charmDiv.setInnerHtml(""); //wipe out any already drawn charms
        print("drawing participants");
        for(Charm c in charms) {
            c.draw(charmDiv);
        }
    }


    void setCharms() {
        if(charms != null) charms.clear(); //out with the old, make sure to always sync to dolls.
        List<Charm> copyOfAllCharms = Charm.allCharms;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int i = 1;
        //lower numbers are most common
        for(int i = 0; i <13; i++) {
            if(rand.nextDouble() < .3) {
                i++;
            }else {
                break; //pl has taught me dangerous things
            }
        }

        i = Math.min(i, copyOfAllCharms.length); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,i);
        if(charmDiv != null) {
            drawCharms(null);
        }
    }

}