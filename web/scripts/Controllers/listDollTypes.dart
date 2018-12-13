import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "dart:html";
import "dart:async";
import 'package:RenderingLib/RendereringLib.dart';


List<Doll> dollExamples = new List<Doll>();
DivElement div;
Future<Null> main() async {
    loadNavbar();
    div = querySelector("#output");
    initDollList();
    drawAllBoxes();
}

void initDollList() {
    List<int> dollTypes = Doll.allDollTypes;
    for(int type in dollTypes) {
        dollExamples.add(Doll.randomDollOfType(type));
        print("made doll example ${dollExamples.last} from type $type");

    }
}

Future<Null> drawAllBoxes() async {

    for(Doll doll in dollExamples) {
        drawBox(doll);
    }
}

Future<Null> drawBox(Doll doll) async{
    print ("drawing box for $doll");
    DivElement box = new DivElement();
    box.style.width = "${doll.width}";
    box.style.display ="inline-block";
    AnchorElement a = new AnchorElement(href: "index.html?type=${doll.renderingType}");
    a.target = "_blank";
    box.append(a);
    CanvasElement canvas = new CanvasElement(width:doll.width, height:doll.height);
    CanvasElement realCanvas = new CanvasElement(width:300,height:300);
    box.style.border = "3px solid black";
    canvas.style.marginTop = "10px";
    canvas.style.border = "3px solid black";

    DivElement name = new DivElement();
    name.text = "${doll.name}";

    DivElement credit = new DivElement();
    credit.setInnerHtml("<br>Original Idea and Parts: <br>${doll.originalCreator}");

    box.append(name);
    box.append(credit);
    a.append(realCanvas);
    div.append(box);
    //this is async but i don't care. i WANT it to not wait.
    await DollRenderer.drawDoll(canvas, doll);
    Renderer.drawToFitCentered(realCanvas, canvas);
}