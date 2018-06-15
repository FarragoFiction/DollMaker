import '../Shipping/Participant.dart';
import '../Shipping/Trove.dart';
import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';

Element container;
Element childContainer;

//TODO eventually let this be an array
Random rand = new Random();
Trove trove;
int numberParticipants = 2;

CanvasElement canvas1;
CanvasElement canvas2;


Future<Null> main() async{
    loadNavbar();
    await Loader.preloadManifest();
    container = querySelector("#contents");
    childContainer = new DivElement();
    ship();
    container.append(childContainer);
}

void ship() {
        List<Participant> p = new List<Participant>();
        for(int i = 0; i<numberParticipants; i++) {
           p.add( new Participant("${Participant.REPLACE}$i", Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes))));
        }
        trove = new Trove(p);
        trove.drawParticipants(container);
        trove.drawRomTypeDropdowns(container);
        trove.drawCharms(container);
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
