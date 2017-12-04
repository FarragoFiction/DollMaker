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
    Doll doll = new HomestuckTrollDoll();
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    querySelector("#doll").append(canvas);
    controller = new TrollController(doll,canvas);
    print("going to load doll");
    loadDoll();
    hintAtEgg();

    //bundle means i don't have to preload shit
    //Renderer.loadHomestuckDollParts(doll, loadDoll);

}

void makeEgg() {
    Doll d = new TrollEggDoll();
    d.palette = controller.doll.palette;
    controller.doll = d;
}


void hintAtEgg() {
    AnchorElement a = new AnchorElement();
    a.setInnerHtml("???");
    a.onClick.listen((e) => makeEgg());
    querySelector("#contents").append(a);
}

void loadDoll() {
    print("loading doll");
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    if(dataString.isNotEmpty) {
        controller.doll = new HomestuckTrollDoll.fromDataString(dataString.substring(1)); //chop off leading ?
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
}


class TrollController extends BaseController {
  TrollController(Doll doll, CanvasElement canvas) : super(doll, canvas);

  @override
    void setupForms() {
        super.setupForms();
        Element samplePaletteControls = querySelector("#samplePaletteControls");
        DollMakerTools.drawSamplePalettes(samplePaletteControls, controller, drawDollCreator);
    }
}


