import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';

Echeladder sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    String dataString = window.location.search;
    Doll doll;
    if(dataString.isNotEmpty && getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?
        print("getting a specific type");
    }else if (dataString.isNotEmpty) {
        doll = Doll.loadSpecificDoll(dataString.substring(1)); //chop off leading ?
        print("getting a specific doll");
    }else {
        doll = Doll.randomDollOfType(new Random().pickFrom(Doll.allDollTypes));
        print("getting a random doll of any type");

    }
    sheet = new Echeladder(doll,null);
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

