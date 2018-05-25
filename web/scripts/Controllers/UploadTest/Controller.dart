import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../../DollMakerTools.dart";
import "../../navbar.dart";

import "../BaseController.dart";
import "../QueenController.dart";

BaseController controller;


void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();

    print("going to load doll");
    loadDoll();
}


void loadDoll() {
    print("loading doll");
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    Doll doll;
    if(dataString.isNotEmpty && getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?

    }else if (dataString.isNotEmpty) {
        doll = Doll.loadSpecificDoll(dataString.substring(1)); //chop off leading ?
    }

    //doing it this way ensures no incorrect sized canvas from a default doll.
    if(doll == null) doll =  Doll.randomDollOfType(1);
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    querySelector("#doll").append(canvas);
    if(doll is QueenDoll) {
        controller = new QueenController(doll, canvas);

    }else {
        controller = new BaseController(doll, canvas);
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
}