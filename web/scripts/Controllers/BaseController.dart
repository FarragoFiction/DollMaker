
import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
class BaseController {
    Doll doll;
    CanvasElement canvas;
    List<String> actionQueue = new List<String>();
    int actionQueueIndex = 0;


    BaseController(this.doll, this.canvas);



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
        for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
            DollMakerTools.drawDropDownForSpriteLayer(doll, layerControls, l, drawDollCreator);
        }
        DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);
    }


    void drawDollCreator([bool inQueue = false]) {
        print("Draw doll creator");
        for (SpriteLayer l in doll.renderingOrderLayers) {
            DollMakerTools.syncDropDownToSprite(l);
        }

        Renderer.clearCanvas(canvas);
        Renderer.drawDoll(canvas, doll);
        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
        actionQueue.add(doll.toDataBytesX());
        if(!inQueue) {
            actionQueueIndex = actionQueue.length-1;
        }
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

}