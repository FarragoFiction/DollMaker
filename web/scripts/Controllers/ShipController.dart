import '../Shipping/Participant.dart';
import '../Shipping/Trove.dart';
import 'DollSlurper.dart';
import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:RenderingLib/src/loader/loader.dart';

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

Future<Null> ship() async{
        List<Participant> p = new List<Participant>();
        String chosenCategory = getParameterByName("target");
        List<Doll> possibleDolls = new List<Doll>();
        if(chosenCategory == null) {
            randomParticipants(p);
        }else {
            await slurpDolls(possibleDolls, chosenCategory);
            possibleDolls.shuffle();//true random
            //todo have name/doll pairing
            p.add(new Participant(possibleDolls.first));
            p.add(new Participant(possibleDolls.last));
        }
        trove = new Trove(p, possibleDolls);
        trove.drawParticipants(container);
        trove.drawRomTypeDropdowns(container);
        trove.drawCharms(container);
        trove.drawTextBox(container);

}

void randomParticipants(List<Participant> p) {
    for (int i = 0; i < numberParticipants; i++) {
        p.add(new Participant(Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes))));
    }
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
