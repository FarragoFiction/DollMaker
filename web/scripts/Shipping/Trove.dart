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

    int get seed {
        int ret = 0;
        participants.forEach((Participant p) {
            ret += p.doll.seed;
        });
        return ret;
    }

    Trove(List<Participant> this.participants, {List<Charm> this.charms}) {
        if(charms == null || charms.isEmpty) setCharms();
    }

    void drawParticipants(Element element) {
        print("drawing participants");
        for(Participant p in participants) {
            p.draw(element);
        }
    }


    void setCharms() {
        print("TODO");
        List<Charm> copyOfAllCharms = Charm.allCharms;
        Random rand = new Random(seed);
        copyOfAllCharms.shuffle(rand);
        int i = rand.nextInt(13); //between zero and 13 charms
        i = Math.min(i, copyOfAllCharms.length-1); //don't be bigger than list
        charms = copyOfAllCharms.sublist(0,i);
    }

}