import "HomestuckDollLib.dart";
import "dart:html";
import "includes/colour.dart";

HomestuckDoll doll;

void main() {
    print("Hello World");
    Random rand = new Random();
    doll = new HomestuckDoll();


    Renderer.loadHomestuckDollParts(doll, loadDoll);

}

void loadDoll() {
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    if(dataString.isNotEmpty) {
        throw("TODO");
    }

    //whether i loaded or not, it's time to draw.
    setupForms();
    drawDollCreator();
}

void setupForms() {
    querySelector("#randomize").onClick.listen((e) => randomizeDoll());



    ButtonElement copyButton = querySelector("#copyButton");
    copyButton.onClick.listen((Event e) {
        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.select();
        document.execCommand('copy');
    });

    drawDollCreator();
}



void drawDollCreator() {
    CanvasElement canvas = querySelector("#doll_creator");
    Renderer.clearCanvas(canvas);
    Renderer.drawDoll(canvas, doll);
    //TextAreaElement dataBox = querySelector("#shareableURL");
    //dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
}

void randomizeDoll() {
    print("randomizing and redrawing");
    doll.randomize();
    drawDollCreator();
}