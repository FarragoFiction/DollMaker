import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";

import "BaseController.dart";


Doll doll;
Random rand = new Random();
int currentTick = 0;
int ticksForDoll = 3;
CanvasElement canvas;

Future<Null> main() async {
    await Loader.preloadManifest();
    loadNavbar();
    canvas = new CanvasElement();
    canvas.style.marginLeft = "auto";
    canvas.style.marginRight = "auto";
    querySelector("#contents").append(canvas);
    tick();

}

Future<Null> tick() async {
    if(ticksForDoll == 0 || doll == null) {
        newDoll();
    }else {
        newColor();
    }
    await drawDoll();
    //todo what's the bpm of manic's music?
    new Timer(new Duration(milliseconds: 100), () => tick());
    ticksForDoll ++;

}

Future<Null> drawDoll() {
    CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
    DollRenderer.drawDoll(buffer, doll);
    canvas.width = buffer.width;
    canvas.height = buffer.height;
    canvas.context2D.drawImage(buffer,0,0);
}

Future<Null> newDoll() async {
    if(getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?
    }else{
        doll = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
    }
}

Future<Null> newColor() async {
    doll.randomizeColors();
}


