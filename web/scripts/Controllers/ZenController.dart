import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";

import "BaseController.dart";


Doll doll;
Random rand = new Random();
int currentBuffer = 0;
int buffersForDoll = 3;
CanvasElement canvas;
CanvasElement buffer;

bool loading = false;

Future<Null> main() async {
    await Loader.preloadManifest();
    loadNavbar();
    DivElement borderElement = new DivElement();
    borderElement.style.marginLeft = "auto";
    borderElement.style.marginRight = "auto";
    borderElement.style.display = "inline-block";
    borderElement.style.border = "3px solid #000000";
    canvas = new CanvasElement();
    canvas.style.border = "3px solid #ffffff";
    borderElement.append(canvas);
    querySelector("#contents").append(borderElement);

    tick();

}

Future<Null> tick() async {
    print("buffer $currentBuffer");
    if(currentBuffer % buffersForDoll == 0 || doll == null) {
        print("new doll");
        loading = false;
        newDoll();
    }else {
        print("new color");
        newColor();
    }

    if(buffer != null) await drawDoll();
    getNextBuffer(); //don't need to wait for it.
    //todo what's the bpm of manic's music? 90, he says
    new Timer(new Duration(milliseconds: 1000), () => tick());
}

Future<Null> drawDoll() {
    if(loading) return null; //not ready to render yet
    canvas.width = buffer.width;
    canvas.height = buffer.height;
    canvas.context2D.drawImage(buffer,0,0);
    print("updated canvas from buffer");

}

Future<Null> getNextBuffer() async {
    if(loading) return null; //don't try to get the same doll multiple times.
    loading = true;
    buffer = new CanvasElement(width: doll.width, height: doll.height);
     await  DollRenderer.drawDoll(buffer, doll);
    currentBuffer ++;
    print("got buffer");

    loading = false;
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


