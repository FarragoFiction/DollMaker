import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "package:DollLibCorrect/CharSheetLib.dart";
import 'dart:async';

TrollCallSheet sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    sheet = new TrollCallSheet(new HomestuckTrollDoll()); //it's in the name, dunkass.
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    CanvasElement finishedProduct = await sheet.draw();
    finishedProduct.className = "cardCanvas";
    innerDiv.append(finishedProduct);
    innerDiv.append(sheet.makeForm());
    querySelector("#contents").append(innerDiv);
}