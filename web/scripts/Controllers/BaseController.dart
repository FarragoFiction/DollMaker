
import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";
//bluh
class BaseController {
    Doll doll;
    CanvasElement canvas;
    ButtonElement undo;
    ButtonElement redo;
    bool disclaimed = false;

    AnchorElement eastereggLink;
    AnchorElement trollCallLink;
    AnchorElement trollCardLink;
    AnchorElement echeladderLink;
    AnchorElement pesterlogLink;
    AnchorElement charSheetLink;




    AnchorElement hatchLink;

    List<String> actionQueue = new List<String>();
    int actionQueueIndex = 0;


    BaseController(this.doll, this.canvas) {
        window.onError.listen((e) {
            window.alert("Shit. There's been an error.");
        });
    }


    void setupLinks(Element container) {
        trollCallLink = new AnchorElement(href: "trollCall.html?${doll.toDataUrlPart()}")..style.padding = "5px";
        trollCallLink.text = "Troll Call";
        trollCallLink.target = "_blank";
        container.append(trollCallLink);

        trollCardLink = new AnchorElement(href: "trollCard.html?${doll.toDataUrlPart()}")..style.padding = "5px";
        trollCardLink.text = "Troll Card";
        trollCardLink.target = "_blank";
        container.append(trollCardLink);

        echeladderLink = new AnchorElement(href: "echeladder.html?${doll.toDataUrlPart()}")..style.padding = "5px";
        echeladderLink.text = "Echeladder";
        echeladderLink.target = "_blank";
        container.append(echeladderLink);

        pesterlogLink = new AnchorElement(href: "pesterlog.html?${doll.toDataUrlPart()}")..style.padding = "5px";
        pesterlogLink.text = "Pesterlog";
        pesterlogLink.target = "_blank";
        container.append(pesterlogLink);

        charSheetLink = new AnchorElement(href: "charSheetCreator.html?${doll.toDataUrlPart()}")..style.padding = "5px";
        charSheetLink.text = "Charsheet";
        charSheetLink.target = "_blank";
        container.append(charSheetLink);
    }

    void syncLinks() {
        if(trollCallLink != null) trollCallLink.href = "trollCall.html?${doll.toDataUrlPart()}";
        if(trollCardLink != null) trollCardLink.href = "trollCard.html?${doll.toDataUrlPart()}";
        if(echeladderLink != null) echeladderLink.href = "echeladder.html?${doll.toDataUrlPart()}";
        if(pesterlogLink != null) pesterlogLink.href = "pesterlog.html?${doll.toDataUrlPart()}";
        if(charSheetLink != null) charSheetLink.href = "charSheetCreator.html?${doll.toDataUrlPart()}";

    }

    void setupForms() {
        querySelector("#randomize").onClick.listen((e) => randomizeDoll());
        querySelector("#randomizeColors").onClick.listen((e) => randomizeDollColors());
        querySelector("#randomizeNotColors").onClick.listen((e) => randomizeDollNotColors());

        ButtonElement copyButton = querySelector("#copyButton");
        LabelElement nameLabel = new LabelElement()..text = "Name:";
        TextInputElement name = new TextInputElement();
        name.value = doll.dollName;



        TextAreaElement dataBox = querySelector("#shareableURL");
        querySelector("#samplePaletteControls").append(nameLabel)..append(name);
        dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataUrlPart()}";
        copyButton.onClick.listen((Event e) {
            TextAreaElement dataBox = querySelector("#shareableURL");
            dataBox.select();
            document.execCommand('copy');
        });

        setupLinks(querySelector("#info"));


        name.onInput.listen((Event e) {
            doll.dollName = name.value;
            syncLinks();
            dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataUrlPart()}";
        });

        if(doll is HatchableDoll) {

            Doll newDoll = (doll as HatchableDoll).hatch();

            hatchLink = new AnchorElement(href:"${window.location.origin}${window.location.pathname}?${newDoll.toDataBytesX()}" );
            hatchLink.text = "Transform?";
            hatchLink.style.display="block";
            hatchLink.target = "_blank";
            querySelector("#info").append(hatchLink);
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
        doll.load(null,actionQueue[actionQueueIndex]);
        DollMakerTools.syncColorPickersToSprite(doll.palette);
        drawDollCreator(true);
    }

    Future<Null> drawDollCreator([bool inQueue = false]) async {

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
            await DollRenderer.drawDoll(canvas, doll);
        }

        TextAreaElement dataBox = querySelector("#shareableURL");
        if(dataBox != null) dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
        syncLinks();
        if(hatchLink != null && doll is HatchableDoll) {
            hatchLink.href = "${window.location.origin}${window.location.pathname}?${(doll as HatchableDoll).hatch().toDataBytesX()}";
        }


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