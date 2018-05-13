
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
    bool disclaimed = false;

    AnchorElement eastereggLink;

    TextAreaElement hatchBox;

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

        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
        copyButton.onClick.listen((Event e) {
            TextAreaElement dataBox = querySelector("#shareableURL");
            dataBox.select();
            document.execCommand('copy');
        });

        if(doll is EasterEggDoll) {
            ButtonElement copyButton2 = new ButtonElement();
            copyButton2.text = "Copy Hatched Egg";
            hatchBox = new TextAreaElement();
            HatchedChick pigeon = (doll as EasterEggDoll).hatch();
            hatchBox.value = "${window.location.origin}${window.location.pathname}?${pigeon.toDataBytesX()}";
            copyButton2.onClick.listen((Event e) {
                hatchBox.select();
                document.execCommand('copy');
            });
            querySelector("#info").append(hatchBox);
            querySelector("#info").append(copyButton2);
        }

        if(doll is HatchedChick) {
            ButtonElement copyButton2 = new ButtonElement();
            copyButton2.text = "Copy Grown Bird";
            hatchBox = new TextAreaElement();
            PigeonDoll pigeon = (doll as HatchedChick).hatch();
            hatchBox.value = "${window.location.origin}${window.location.pathname}?${pigeon.toDataBytesX()}";
            copyButton2.onClick.listen((Event e) {
                hatchBox.select();
                document.execCommand('copy');
            });
            querySelector("#info").append(hatchBox);
            querySelector("#info").append(copyButton2);
        }

        ButtonElement saveButton = querySelector("#saveButton");
        saveButton.onClick.listen((Event e) {
            doll.save();
        });


        Element layerControls = querySelector("#layerControls");
        Element colorControls = querySelector("#colorControls");
        for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
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

        if(doll is EasterEggDoll) {
            if(eastereggLink == null) {
                eastereggLink = new AnchorElement(href: (doll as EasterEggDoll).getEasterEgg());
                eastereggLink.target = "_blank";
                eastereggLink.text = "Would you like some eggs with your eggs? (${(doll as EasterEggDoll).base.imgNumber % EasterEggDoll.eggs.length})";
                querySelector('#layerControls').append(eastereggLink);
            }else {
                eastereggLink.href = (doll as EasterEggDoll).getEasterEgg();
                eastereggLink.text = "Would you like some eggs with your eggs? (${(doll as EasterEggDoll).base.imgNumber % EasterEggDoll.eggs.length})";
            }
        }
        print("Draw doll creator: ${doll.toDataBytesX()}");
        for (SpriteLayer l in doll.renderingOrderLayers) {
            if(!l.slave) DollMakerTools.syncDropDownToSprite(l);
        }

        Renderer.clearCanvas(canvas);
        canvas.context2D.font = "48px Courier New";
        if(doll.width<100) disclaimed = true; //too small
        if(!disclaimed) {
            disclaimed = true;
            Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Click here to acknowledge that all sprites and sprite parts are provided for non commercial use only. Please link to DollSim credits if used. (creative commons attribution plus noncommercial)", "Courier New", 50, 50, 180, doll.width - 50, doll.height - 50);
            canvas.onClick.listen((e) {
                Renderer.clearCanvas(canvas);
                DollRenderer.drawDoll(canvas, doll);
            });
        }else {
            DollRenderer.drawDoll(canvas, doll);
        }

        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
        if(hatchBox != null && doll is EasterEggDoll) hatchBox.value = "${window.location.origin}${window.location.pathname}?${(doll as EasterEggDoll).hatch().toDataBytesX()}";
        if(hatchBox != null && doll is HatchedChick) hatchBox.value = "${window.location.origin}${window.location.pathname}?${(doll as HatchedChick).hatch().toDataBytesX()}";

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