import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
HomestuckTrollDoll doll;


void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    doll = new HomestuckTrollDoll();

    loadDoll();
    hintAtEgg();

    //don't need to preload anymore, thanks PL!
    //Renderer.loadHomestuckTrollDollParts(doll, loadDoll);
}

void hintAtEgg() {
    AnchorElement a = new AnchorElement();
    a.setInnerHtml("???");
    a.onClick.listen((e) => makeEgg());
    querySelector("#contents").append(a);
}

void makeEgg() {
    doll = new TrollEggDoll();
}

void loadDoll() {
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    if(dataString.isNotEmpty) {
        doll = new HomestuckTrollDoll.fromDataString(dataString.substring(1)); //chop off leading ?

    }
    //whether i loaded or not, it's time to draw.
    setupForms();
    drawDollCreator();
}

void setupForms() {
    querySelector("#randomize").onClick.listen((e) => randomizeDoll());
    querySelector("#randomizeColors").onClick.listen((e) => randomizeDollColors());
    querySelector("#randomizeNotColors").onClick.listen((e) => randomizeDollNotColors());

    ButtonElement copyButton = querySelector("#copyButton");
    copyButton.onClick.listen((Event e) {
        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.select();
        document.execCommand('copy');
    });


    Element layerControls = querySelector("#layerControls");
    Element colorControls = querySelector("#colorControls");
    Element samplePaletteControls = querySelector("#samplePaletteControls");
    for(SpriteLayer l in doll.layers.reversed) {
        DollMakerTools.drawDropDownForSpriteLayer(layerControls, l,drawDollCreator);
    }
    DollMakerTools.drawSamplePalettes(samplePaletteControls, doll, drawDollCreator);

    DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);


}



void drawDollCreator() {
    for(SpriteLayer l in doll.layers) {
        DollMakerTools.syncDropDownToSprite(l);
    }
    //DollMakerTools.syncColorPickersToSprite(doll.palette);

    CanvasElement canvas = querySelector("#doll_creator");
    Renderer.clearCanvas(canvas);
    Renderer.drawDoll(canvas, doll);
    TextAreaElement dataBox = querySelector("#shareableURL");
    dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
}

void randomizeDoll() {
    print("randomizing and redrawing");
    doll.randomize();
    //can't do it in regular draw part cuz onChange is a bitch.
    DollMakerTools.syncColorPickersToSprite(doll.palette);
    drawDollCreator();
}


void randomizeDollNotColors() {
    print("randomizing and redrawing");
    doll.randomizeNotColors();
    //can't do it in regular draw part cuz onChange is a bitch.
    DollMakerTools.syncColorPickersToSprite(doll.palette);
    drawDollCreator();
}

void randomizeDollColors() {
    print("randomizing and redrawing");
    doll.randomizeColors();
    //can't do it in regular draw part cuz onChange is a bitch.
    DollMakerTools.syncColorPickersToSprite(doll.palette);
    drawDollCreator();
}