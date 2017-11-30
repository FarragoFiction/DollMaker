import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";

HomestuckDoll doll;
void makeEgg() {
    Doll d = new EggDoll();
    d.palette = doll.palette;
    doll = d;
}
void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    doll = new HomestuckDoll();
    print("going to load doll");
    loadDoll();
    hintAtEgg();



    //bundle means i don't have to preload shit
    //Renderer.loadHomestuckDollParts(doll, loadDoll);

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
       doll = new HomestuckDoll.fromDataString(dataString.substring(1)); //chop off leading ?
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

    ButtonElement saveButton = querySelector("#saveButton");
    saveButton.onClick.listen((Event e) {
        doll.save();
    });


    Element layerControls = querySelector("#layerControls");
    Element colorControls = querySelector("#colorControls");
    Element samplePaletteControls = querySelector("#samplePaletteControls");
    for(SpriteLayer l in doll.renderingOrderLayers.reversed) {
        DollMakerTools.drawDropDownForSpriteLayer(doll, layerControls, l,drawDollCreator);
    }
    DollMakerTools.drawSamplePalettes(samplePaletteControls, doll, drawDollCreator);
    DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);

}



void drawDollCreator() {
    print("Draw doll creator");
    for(SpriteLayer l in doll.renderingOrderLayers) {
        DollMakerTools.syncDropDownToSprite(l);
    }

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