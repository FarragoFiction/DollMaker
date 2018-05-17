import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';

Element container;

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
    initParents();
    drawParents();
    makeBreedButtons();
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
    ButtonElement randomizeButton = new ButtonElement()..text = "Randomize";


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
    });

    div.append(parentCanvas);
    div.append(dataBox);
    div.append(loadButton);
    div.append(randomizeButton);

    container.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}

void makeBreedButtons() {
    ButtonElement and = new ButtonElement()..text = "Combine with AND Alchemy";
    ButtonElement or = new ButtonElement()..text = "Combine with OR Alchemy";
    ButtonElement breed = new ButtonElement()..text = "Combine the Old Fashioned Way";
    container.append(and);
    container.append(or);
    container.append(breed);

    and.onClick.listen((Event e) {
        child = Doll.andAlchemizeDolls(<Doll>[doll1, doll2]);
        drawResult("and and and and and");
    });

    or.onClick.listen((Event e) {
        child = Doll.orAlchemizeDolls(<Doll>[doll1, doll2]);
        drawResult("or or or or or");
    });

    breed.onClick.listen((Event e) {
        child = Doll.breedDolls(<Doll>[doll1, doll2]);
        drawResult("x x x x x x x x");
    });
}

Future<Null> drawResult(String text) async {
    CanvasElement result = new CanvasElement(width: 1200, height: 300);
    container.append(result);

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
    AnchorElement anchorElement = new AnchorElement(href:"index.html?${child.toDataBytesX()}");
    anchorElement.target = "_blank";
    anchorElement.text = "Edit Child";
    container.append(label);
    container.append(anchorElement);
}

void drawTextBG(CanvasElement canvas, String text) {
    int fontSize = 400;
    canvas.context2D.font = "${fontSize}px Strife";
    canvas.context2D.fillStyle = "#000000";
    Random rand = new Random();
    int y = (canvas.height/2).round() + rand.nextInt(10)+50;
    int x = (canvas.width/2).round()+ rand.nextInt(10)-200;
    Renderer.wrap_text(canvas.context2D,"$text",x,y,fontSize,canvas.width,"center");
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
