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

WeightedList<int> dollTypes = new WeightedList<int>();


Future<Null> main() async{
    loadNavbar();
    rand.nextInt(); //init
    await Loader.preloadManifest();
    initValidTypes();
    container = querySelector("#ectoContents");
    childContainer = new DivElement();
    initParents();
    drawParents();
    makeBreedButtons();
    container.append(childContainer);
}

void initValidTypes() {
    dollTypes.add(1);
    dollTypes.add(2);
    dollTypes.add(15,0.3);
    dollTypes.add(16,0.3);
}

void initParents() {
    doll1 = Doll.randomDollOfType(rand.pickFrom(dollTypes));
    if(rand.nextBool()) {
        doll2 = Doll.randomDollOfType(rand.pickFrom(dollTypes));
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

    ButtonElement loadButton = new ButtonElement()..text = "Load";
    loadButton.style.display = "inline-block";
    loadButton.classes.add("targetButton");
    ButtonElement randomizeButton = new ButtonElement()..text = "Randomize";
    randomizeButton.style.display = "inline-block";
    randomizeButton.classes.add("targetButton");
    ButtonElement randomizeTypeButton = new ButtonElement()..text = "Randomize Type";
    randomizeTypeButton.style.display = "inline-block";
    randomizeTypeButton.classes.add("targetButton");



    DivElement ectoJar = new DivElement();
    ectoJar.classes.add("ectoJarContainer");
    ImageElement jarTop = new ImageElement(src: "images/jarTop.png");
    jarTop.classes.add("jarTop");
    ectoJar.append(jarTop);

    DivElement jarElement = new DivElement();
    ectoJar.append(jarElement);
    jarElement.classes.add("jar");
    //why is it so hard to put a thing on the bottom of another thing without it suddenly
    //making it's parent think it's empty
    DivElement jarAir = new DivElement();
    jarAir.classes.add("jarAir");
    jarElement.append(jarAir);

    TextAreaElement dataBox = new TextAreaElement();
    dataBox.classes.add("ectoSlime");
    dataBox.style.display = "block";
    dataBox.value = "${parent.toDataBytesX()}";
    jarElement.append(dataBox);

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

    randomizeTypeButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
        if(parent == doll1) doll1 = tmp;
        if(parent == doll2) doll2 = tmp;

        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    div.append(parentCanvas);
    div.append(ectoJar);
    div.append(loadButton);
    div.append(randomizeButton);
    div.append(randomizeTypeButton);

    container.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}

void makeBreedButtons() {
    DivElement buttonContainer = new DivElement();
    ButtonElement breed = new ButtonElement()..text = ">";
    breed.style.display = "inline-block";
    breed.classes.add("ectoButton");

    ButtonElement clear = new ButtonElement()..text = "Clear Combinations";
    clear.classes.add("ectoButton");

    buttonContainer.append(breed);
    buttonContainer.append(clear);
    container.append(buttonContainer);


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
    AnchorElement anchorElement = new AnchorElement(href:"index.html?${child.toDataBytesX()}");
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
