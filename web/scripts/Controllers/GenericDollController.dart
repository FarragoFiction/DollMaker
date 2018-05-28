import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";

import "BaseController.dart";
import "QueenController.dart";

BaseController controller;


void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();

    print("going to load doll");
    loadDoll();
    hintAtEgg();
    storeCard("N4Igzg9grgTgxgUxALhAWQIYGsCWA7AcwAIMiARCAG0pABoQ8MBbJVAcQQBcj8SiAhGBgDuNepwQAPTihBEIwvAhgJGLGEQJcwPPHwBmOMN0MEAFt2E5OZojYzcMYMGaoIiAEwV6b74yq4AOiIAFTMEAE8iVQ8iKAAHXTtwogBlABkAQTQ0AFEAJSJ9CA14qAAjShw4IhgFD3wEZ2C6EHKMOCwCOqg8DwA5ZlYQVMpmAClmUeYyXtxCMIRppnVA+MJWzhgcAi0YAGEzDDxEWQAGQIBWVrBEJTAQiABVPEoITtkAbQBdVpUwKCUThgVKcBxgL7AAA6DCGMOQMNyqRCuVyaBhtBhADcMJQoAh4TCALQAZhhAF9fuJtrtlKDwekmmBlF8qSAtjs9vTgWwVA4WahPtDYSxCSAyAB5NAASX6mX6+1yGOxuPxYoAjBS2RzaTBuWBcgBHKC41kgclAA");
}

void storeCard(String card) {
    String key = "LIFESIMFOUNDCARDS";
    if(window.localStorage.containsKey(key)) {
        String existing = window.localStorage[key];
        List<String> parts = existing.split(",");
        if(!parts.contains(card)) window.localStorage[key] = "$existing,$card";
    }else {
        window.localStorage[key] = card;
    }
}

void makeEgg() {
    if(controller.doll is HomestuckDoll) {
        Doll d = new EggDoll();
        d.palette = controller.doll.palette;
        controller.doll = d;
    }else if(controller.doll is HomestuckTrollDoll) {
        Doll d = new TrollEggDoll();
        d.palette = controller.doll.palette;
        controller.doll = d;
    }
}


void hintAtEgg() {
    AnchorElement a = new AnchorElement();
    a.setInnerHtml("???");
    a.onClick.listen((e) => makeEgg());
    querySelector("#contents").append(a);
}

Future<Null> loadDoll() async {
    await Loader.preloadManifest();

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
    DivElement linkDiv = new DivElement();
    AnchorElement a = new AnchorElement(href: "viewParts.html?type=${doll.renderingType}");
    a.text = "View All Parts for ${doll.name}";
    a.target = "_blank";

    AnchorElement a3 = new AnchorElement(href: "uploadParts.html?type=${doll.renderingType}");
    a3.text = "Contribute New Parts for ${doll.name}";
    a3.style.display = "block";
    a3.target = "_blank";

    DivElement linkDiv2 = new DivElement();
    AnchorElement a2 = new AnchorElement(href: "zen.html?type=${doll.renderingType}");
    a2.text = "${doll.name} Zen Mode";
    a2.target = "_blank";
    linkDiv.append(a);
    linkDiv2.append(a3);
    linkDiv2.append(a2);

    querySelector("#samplePaletteControls").append(linkDiv);
    querySelector("#samplePaletteControls").append(linkDiv2);


    if(doll is QueenDoll) {
        controller = new QueenController(doll, canvas);

    }else {
        controller = new KidController(doll, canvas);
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
    querySelector("title").text = "${doll.name} Doll Maker";
    DivElement credits = new DivElement()..text = "(idea and initial parts by ${doll.originalCreator})";
    querySelector("#doll").append(credits);
}


class KidController extends BaseController {
    KidController(Doll doll, CanvasElement canvas) : super(doll, canvas);

    @override
    void setupForms() {
        super.setupForms();
        Element samplePaletteControls = querySelector("#samplePaletteControls");
        DollMakerTools.drawSamplePalettes(samplePaletteControls, controller, drawDollCreator, doll);
    }
}



