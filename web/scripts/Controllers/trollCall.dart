import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';

TrollCallSheet sheet;
void main() {
    loadNavbar();
    drawSheet();

}

Future<Null> drawSheet() async {
    Doll d;
    String dataString = window.location.search;
    Doll doll;
    if(dataString.isNotEmpty && getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?
    }else if(getParameterByName("canon",null) == "true") {
        d = new HiveswapDoll();
    }else if (dataString.isNotEmpty) {
        doll = Doll.loadSpecificDoll(dataString.substring(1)); //chop off leading ?
    }else {
        d = new HomestuckTrollDoll();
    }
    sheet = new TrollCallSheet(d); //it's in the name, dunkass.
    await sheet.setup();

    Element innerDiv  = new DivElement();
    innerDiv.className = "cardWithForm";
    await sheet.draw(innerDiv);
    innerDiv.append(sheet.makeForm());
    querySelector("#contents").append(innerDiv);


    for(int i = 0; i<15; i++) {
        String srt = await sheet.randomFact();
        print(srt);
    }
}