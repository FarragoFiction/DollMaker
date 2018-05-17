import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';

Element container;

Doll doll1;
Doll doll2;
Doll child;
Random rand = new Random();



Future<Null> main() async{
    loadNavbar();
    await Loader.preloadManifest();
    container = querySelector("#contents");
    container.text = "testing";
    todo("draw two dolls");
    todo("draw two text area inputs");
    todo("draw drop down of and/or/breed");
    todo("draw combine button");
    todo("output single canvas of parents + operation +  result");
    todo("can output as many as you want");
    initParents();
    drawParents();
}

void initParents() {
    doll1 = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    if(rand.nextBool()) {
        doll2 = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    }else {
        doll2 = Doll.randomDollOfType(doll1.renderingType);
    }
}

Future<Null> drawParents() async {
    drawOneParent(doll1);
    drawOneParent(doll2);
}

Future<Null> drawOneParent(Doll parent) async {
    DivElement div = new DivElement();
    div.classes.add("breedingParent");
    CanvasElement parentCanvas = new CanvasElement(width: parent.width, height: parent.height);
    parentCanvas.style.border = "3px solid #000000";

    ButtonElement loadButton = new ButtonElement()..text = "Load";

    TextAreaElement dataBox = new TextAreaElement();
    dataBox.style.display = "block";
    dataBox.value = "${parent.toDataBytesX()}";
    loadButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        parent = Doll.loadSpecificDoll(dataBox.value);
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    div.append(parentCanvas);
    div.append(dataBox);
    div.append(loadButton);
    container.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}

void todo(String todo) {
    LIElement tmp = new LIElement();
    tmp.setInnerHtml("TODO: $todo");
    container.append(tmp);
}
