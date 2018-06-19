import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";
import "BaseController.dart";


class QueenController extends BaseController {
    QueenController(Doll doll, CanvasElement canvas) : super(doll, canvas);

    @override
    Future<Null> drawDollCreator([bool inQueue = false]) async {
        DollMakerTools.syncColorPickersToSprite(doll.palette);
        drawLayerControls();
        print("Draw doll creator");
        Renderer.clearCanvas(canvas);
        DollRenderer.drawDoll(canvas, doll);
        TextAreaElement dataBox = querySelector("#shareableURL");
        dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataUrlPart()}";
        //don't add it to the queue if you're already messing around in it, dunkass. you'll never escape the loop.
        if (!inQueue) {
            actionQueue.add(doll.toDataBytesX());
            actionQueueIndex = actionQueue.length - 1;
        }
    }


    @override
    void randomizeDoll() {
        print("randomizing and redrawing");
        doll.randomize();
        drawDollCreator();
    }

    @override
    void randomizeDollNotColors() {
        print("randomizing and redrawing");
        doll.randomizeNotColors();
        //can't do it in regular draw part cuz onChange is a bitch.
        DollMakerTools.syncColorPickersToSprite(doll.palette);
        drawDollCreator();
        drawLayerControls();
    }


    @override
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


        Element colorControls = querySelector("#colorControls");

        drawLayerControls();
        DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);

        if (undo == null) {
            undo = new ButtonElement();
            undo.setInnerHtml("Undo");
            querySelector("#contents").append(undo);
            undo.onClick.listen((e) => undoFunction());
        }

        if (redo == null) {
            redo = new ButtonElement();
            redo.setInnerHtml("Redo");
            querySelector("#contents").append(redo);
            redo.onClick.listen((e) => redoFunction());
        }
    }

    void drawLayerControls() {
        Element layerControls = querySelector("#layerControls");
        layerControls.setInnerHtml("");
        for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
            DollMakerTools.drawDropDownForSpriteLayer(this, layerControls, l, drawDollCreator);
        }


        //want to be able to add new layers
        DollMakerTools.addNewNamedLayerButton(this, layerControls, drawDollCreator);
    }
}


