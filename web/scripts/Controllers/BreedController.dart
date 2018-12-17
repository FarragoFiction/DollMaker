import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';
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
    await Doll.loadFileData();
    container = querySelector("#contents");
    childContainer = new DivElement();
    initParents();
    drawParents();
    makeBreedButtons();
    container.append(childContainer);
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

void makeBreedButtons() {
    DivElement buttonContainer = new DivElement();
    ButtonElement and = new ButtonElement()..text = "Combine with AND Alchemy";
    and.style.display = "inline-block";

    ButtonElement or = new ButtonElement()..text = "Combine with OR Alchemy";
    or.style.display = "inline-block";

    ButtonElement breed = new ButtonElement()..text = "Combine the Old Fashioned Way";
    breed.style.display = "inline-block";

    ButtonElement clear = new ButtonElement()..text = "Clear Combinations";

    buttonContainer.append(and);
    buttonContainer.append(or);
    buttonContainer.append(breed);
    buttonContainer.append(clear);
    container.append(buttonContainer);


    and.onClick.listen((Event e) {
        child = Doll.andAlchemizeDolls(<Doll>[doll1, doll2]);
        drawResult("and");
    });

    or.onClick.listen((Event e) {
        child = Doll.orAlchemizeDolls(<Doll>[doll1, doll2]);
        drawResult("or");
    });

    breed.onClick.listen((Event e) {
        child = Doll.breedDolls(<Doll>[doll1, doll2]);
        drawResult("x");
    });

    clear.onClick.listen((Event e) {
        childContainer.text = "";
    });
}

Future<Null> drawResult(String text) async {
    CanvasElement result = new CanvasElement(width: 1200, height: 300);
    childContainer.append(result);

    CanvasElement one = await drawDoll(doll1, 400,300);
    CanvasElement two = await drawDoll(doll2, 400,300);
    CanvasElement three = await drawDoll(child, 400,300);
    drawTextBG(result, text);
    result.context2D.fillText("",0,0);
    result.context2D.drawImage(one, 0, 0);
    result.context2D.drawImage(two, 400, 0);
    result.context2D.drawImage(three, 800, 0);

    LabelElement label = new LabelElement()..text = "Child Code:";
    TextAreaElement code = new TextAreaElement();
    code.value = child.toDataBytesX();
    label.append(code);
    AnchorElement anchorElement = new AnchorElement(href:"index.html?${child.toDataUrlPart()}");
    anchorElement.target = "_blank";
    anchorElement.text = "Edit Child";
    childContainer.append(label);
    childContainer.append(anchorElement);
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
