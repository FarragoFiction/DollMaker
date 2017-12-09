import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../navbar.dart";
import "../DollLib/CharSheetLib.dart";
import 'dart:async';

Echeladder sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    sheet = new Echeladder(new HomestuckDoll());
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    CanvasElement finishedProduct = await sheet.draw();
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
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

