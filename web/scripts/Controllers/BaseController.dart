
import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
//bluh
class BaseController {
    Doll doll;
    CanvasElement canvas;
    ButtonElement undo;
    ButtonElement redo;

    List<String> actionQueue = new List<String>();
    int actionQueueIndex = 0;


    BaseController(this.doll, this.canvas) {
        window.onError.listen((e) {
            window.alert("Shit. There's been an error.");
        });
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
        for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
            DollMakerTools.drawLoadButtonForSpriteLayer(this, layerControls, l, drawDollCreator);
            DollMakerTools.drawDropDownForSpriteLayer(this, layerControls, l, drawDollCreator);

        }
        DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);

        if(undo == null) {
            undo = new ButtonElement();
            undo.setInnerHtml("Undo");
            querySelector("#contents").append(undo);
            undo.onClick.listen((e) => undoFunction());
        }

        if(redo == null) {
            redo = new ButtonElement();
            redo.setInnerHtml("Redo");
            querySelector("#contents").append(redo);
            redo.onClick.listen((e) => redoFunction());
        }
    }


    void undoFunction() {
        print("undo");
        actionQueueIndex += -1;
        loadFromQueue();
    }
    void redoFunction() {
        print("redo");
        actionQueueIndex += 1;
        loadFromQueue();
    }

    void loadFromQueue() {
        print("loading doll from queue");
        if(actionQueueIndex >= actionQueue.length) {
            window.alert("no more to redo");
            actionQueueIndex = actionQueue.length-1;
            return;
        }else if(actionQueueIndex < 0 || actionQueue.isEmpty || actionQueue.length == 1) {
            window.alert("no more to undo");
            actionQueueIndex =0;
            return;
        }
        doll.load(actionQueue[actionQueueIndex]);
        DollMakerTools.syncColorPickersToSprite(doll.palette);
        drawDollCreator(true);
    }

    void drawDollCreator([bool inQueue = false]) {
        print("Draw doll creator: ${doll.toDataBytesX()}");
        for (SpriteLayer l in doll.renderingOrderLayers) {
            DollMakerTools.syncDropDownToSprite(l);
        }

        Renderer.clearCanvas(canvas);
        Renderer.drawDoll(canvas, doll);
        //don't add it to the queue if you're already messing around in it, dunkass. you'll never escape the loop.
        if(!inQueue) {
            actionQueue.add(doll.toDataBytesX());
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