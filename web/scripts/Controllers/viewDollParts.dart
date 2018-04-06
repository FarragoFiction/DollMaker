import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "dart:html";
import "dart:async";


List<Doll> dollExamples = new List<Doll>();
DivElement div;
void main() {
    loadNavbar();
    div = querySelector("#output");
    initDollList();
    //drawAllBoxes();
    todo("list of all doll types in a row");
    todo("drop down menu of each types parts Name: Number of Options");
    todo("when a part is selected, display all of them, min to max");
}

void todo(String text) {
    DivElement container = new DivElement();
    container.setInnerHtml("<b>TODO</b>: $text");
    div.append(container);
}

void initDollList() {
    List<int> dollTypes = <int>[1,2,16,12,13,3,4,7,9,10,14,113,15,8,151,17,18];
    for(int type in dollTypes) {
        dollExamples.add(Doll.randomDollOfType(type));
    }
}

Future<Null> drawAllBoxes() async {
    await Loader.preloadManifest();

    for(Doll doll in dollExamples) {
        drawBox(doll);
    }
}

void drawBox(Doll doll) {
    DivElement box = new DivElement();
    box.style.width = "${doll.width}";
    AnchorElement a = new AnchorElement(href: "index.html?type=${doll.renderingType}");
    box.append(a);
    CanvasElement canvas = new CanvasElement(width:doll.width, height:doll.height);
    box.style.border = "3px solid black";
    canvas.style.marginTop = "10px";
    canvas.style.border = "3px solid black";

    DivElement name = new DivElement();
    name.text = doll.name;
    box.append(name);
    a.append(canvas);
    div.append(box);
    //this is async but i don't care. i WANT it to not wait.
    DollRenderer.drawDoll(canvas, doll);
}