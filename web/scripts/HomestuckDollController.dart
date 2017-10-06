import "HomestuckDollLib.dart";
import "dart:html";
import "includes/colour.dart";
import "DollMakerTools.dart";

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

    Element layerControls = querySelector("#layerControls");
    Element colorControls = querySelector("#colorControls");
    for(SpriteLayer l in doll.layers) {
        DollMakerTools.drawDropDownForSpriteLayer(layerControls, l,drawDollCreator);
    }
    DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);


    drawDollCreator();
}



void drawDollCreator() {
    for(SpriteLayer l in doll.layers) {
        DollMakerTools.syncDropDownToSprite(l);
    }
    DollMakerTools.syncColorPickersToSprite(doll.palette);

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