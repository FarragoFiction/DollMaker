import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";

import "BaseController.dart";


BaseController controller;


void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    Doll doll = new HomestuckBabyDoll();
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    querySelector("#doll").append(canvas);
    controller = new BabyController(doll,canvas);
    print("going to load doll");
    loadDoll();
}


void loadDoll() {
    print("loading doll");
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    if(dataString.isNotEmpty) {
        controller.doll = new HomestuckBabyDoll.fromDataString(dataString.substring(1)); //chop off leading ?
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
}


class BabyController extends BaseController {
    BabyController(Doll doll, CanvasElement canvas) : super(doll, canvas);

    @override
    void setupForms() {
        super.setupForms();
        Element samplePaletteControls = querySelector("#samplePaletteControls");
        DollMakerTools.drawSamplePalettes(samplePaletteControls, controller, drawDollCreator);
    }
}



