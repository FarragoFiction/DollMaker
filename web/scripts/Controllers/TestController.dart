import 'dart:async';
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';
Doll doll;


Future<Null> main() async{
    print("Hello World");

    loadNavbar();
    await Doll.loadFileData();
    Random rand = new Random();
    doll = new HomestuckDoll();
    drawDollCreator();
    setupForms();
}


void setupForms() {


    ButtonElement loadButton = querySelector("#loadButton");
    loadButton.onClick.listen((Event e) {
        print('loading');
        TextAreaElement dataBox = querySelector("#shareableURL");
        //TODO if i'm given a url, chop it off till the ? do this in doll.
        String dataString = dataBox.value;
        doll = Doll.loadSpecificDoll(dataString);
        drawDollCreator();
    });

}



void drawDollCreator() {
    print("Draw doll creator");

    CanvasElement canvas = querySelector("#doll_creator");
    Renderer.clearCanvas(canvas);
    DollRenderer.drawDoll(canvas, doll);

}
