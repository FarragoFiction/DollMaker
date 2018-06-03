import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';

TrollCallSheetAncient sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    Doll d;
    if(getParameterByName("canon",null) == "true") {
        d = new HiveswapDoll();
    }else {
        d = new HomestuckTrollDoll();
    }
    sheet = new TrollCallSheetAncient(d); //thanks ancient
    await sheet.setup();
    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    await sheet.draw(innerDiv);
    innerDiv.append(sheet.makeForm());
    querySelector("#contents").append(innerDiv);
}