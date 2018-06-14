import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';

Element container;
Element childContainer;

Doll doll1;
Doll doll2;
Doll child;
Random rand = new Random();

CanvasElement canvas1;
CanvasElement canvas2;


Future<Null> main() async{
    loadNavbar();
    await Loader.preloadManifest();
    container = querySelector("#contents");
    childContainer = new DivElement();
    initParents();
    drawParents();
    ship();
    container.append(childContainer);
}

void ship() {
        container.appendText("TODO");
}

void initParents() {
    doll1 = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    if(rand.nextBool()) {
        doll2 = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    }else {
        doll2 = Doll.randomDollOfType(doll1.renderingType);
    }
}

void drawParents() {
    drawOneParent(doll1);
    drawOneParent(doll2);
}

void drawOneParent(Doll parent) {
    DivElement div = new DivElement();
    div.classes.add("breedingParent");
    CanvasElement parentCanvas = new CanvasElement(width: parent.width, height: parent.height);
    parentCanvas.style.border = "3px solid #000000";

    ButtonElement loadButton = new ButtonElement()..text = "Load";
    loadButton.style.display = "inline-block";
    ButtonElement randomizeButton = new ButtonElement()..text = "Randomize";
    randomizeButton.style.display = "inline-block";
    ButtonElement randomizeTypeButton = new ButtonElement()..text = "Randomize Type";
    randomizeTypeButton.style.display = "inline-block";



    TextAreaElement dataBox = new TextAreaElement();
    dataBox.style.display = "block";
    dataBox.value = "${parent.toDataBytesX()}";
    loadButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.loadSpecificDoll(dataBox.value);
        if(parent == doll1) doll1 = tmp;
        if(parent == doll2) doll2 = tmp;

        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    randomizeButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.randomDollOfType(parent.renderingType);
        if(parent == doll1) doll1 = tmp;
        if(parent == doll2) doll2 = tmp;

        parent = tmp;        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
        dataBox.value = "${parent.toDataBytesX()}";

    });

    randomizeTypeButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
        if(parent == doll1) doll1 = tmp;
        if(parent == doll2) doll2 = tmp;

        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
        dataBox.value = "${parent.toDataBytesX()}";
    });

    div.append(parentCanvas);
    div.append(dataBox);
    div.append(loadButton);
    div.append(randomizeButton);
    div.append(randomizeTypeButton);

    container.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}



void drawTextBG(CanvasElement canvas, String text) {
    int fontSize = 100;
    canvas.context2D.font = "${fontSize}px Strife";
    canvas.context2D.fillStyle = "#000000";
    Random rand = new Random();
    int y = (canvas.height/2).round();
    int x = (canvas.width/2).round()-400;
    Renderer.wrap_text(canvas.context2D,"$text",x,y,fontSize,400,"center");
    Renderer.wrap_text(canvas.context2D,"=",x+400,y,fontSize,400,"center");

}

Future<CanvasElement>  drawDoll(Doll doll, int w, int h) async {
        CanvasElement ret = new CanvasElement(width: w, height: h);
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await DollRenderer.drawDoll(dollCanvas, doll);
        dollCanvas = Renderer.cropToVisible(dollCanvas);
        Renderer.drawToFitCentered(ret, dollCanvas);
        return ret;
}

void todo(String todo) {
    LIElement tmp = new LIElement();
    tmp.setInnerHtml("TODO: $todo");
    container.append(tmp);
}
