import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
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
    await sheet.draw(innerDiv);
    innerDiv.append(sheet.makeForm());
    querySelector("#contents").append(innerDiv);
}