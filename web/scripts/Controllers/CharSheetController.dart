import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../navbar.dart";
import "../DollLib/CharSheetLib.dart";
import 'dart:async';

CharSheet sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    sheet = new SylveonSheet(Doll.makeRandomDoll());
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    CanvasElement finishedProduct = await sheet.draw();
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    innerDiv.append(sheet.makeForm());
    querySelector("#contents").append(innerDiv);
}