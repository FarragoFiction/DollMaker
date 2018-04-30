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
    drawAllBoxes();
}

void initDollList() {
    List<int> dollTypes = Doll.allDollTypes;
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