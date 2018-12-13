import "../HomestuckDollLib.dart";
import 'DollSlurper.dart';
import "dart:html";
import 'package:CommonLib/Random.dart';
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';

PesterLog sheet;
List<Doll> possibleDolls = new List<Doll>();
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    Random rand = new Random();
    String dataString = window.location.search;
    Doll doll;
    Doll doll2;

    if(dataString.isNotEmpty && getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?
    }if(dataString.isNotEmpty && getParameterByName("target",null)  != null) {
        String chosenCategory = getParameterByName("target");
        await slurpDolls(possibleDolls, chosenCategory);
        doll = new Random().pickFrom(possibleDolls);
        doll2 = new Random().pickFrom(possibleDolls);
    }else if (dataString.isNotEmpty) {
        doll = Doll.loadSpecificDoll(dataString.substring(1)); //chop off leading ?
    }else {
        doll = Doll.randomDollOfType(new Random().pickFrom(Doll.allDollTypes));
    }

    if(doll2 == null) {
        doll2 = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    }
    sheet = new PesterLog(doll,doll2, possibleDolls);
   // sheet = new Echeladder(new MonsterPocketDoll());

    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    await sheet.draw(innerDiv);
    innerDiv.append(sheet.makeForm());
    ButtonElement button = new ButtonElement();
    button.text = "Random";
    innerDiv.append(button);
    button.onClick.listen((e) {
        sheet.doll.randomize();
        sheet.draw();
    });
    querySelector("#contents").append(innerDiv);
}

