import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';

PesterLog sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    sheet = new PesterLog(Doll.makeRandomDoll(),Doll.makeRandomDoll());
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

