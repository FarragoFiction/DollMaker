import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";
import 'package:RenderingLib/src/loader/loader.dart';

import "BaseController.dart";


Doll doll;
Random rand = new Random();
int currentBuffer = 0;
int buffersForDoll = 3;
int tickRate = 1800;
CanvasElement canvas;
CanvasElement buffer;

AudioElement music;
AnchorElement editLink;

bool loading = false;
bool paused = false;

Future<Null> main() async {
    await Loader.preloadManifest();
    loadNavbar();
    DivElement borderElement = new DivElement();
    borderElement.style.marginLeft = "auto";
    borderElement.style.marginRight = "auto";
    borderElement.style.borderRadius = "25px";
    borderElement.style.display = "inline-block";
    borderElement.style.border = "13px solid #000000";
    canvas = new CanvasElement();
    canvas.style.border = "3px solid #ffffff";
    canvas.style.borderRadius = "25px";
    borderElement.append(canvas);

    ButtonElement pauseButton = new ButtonElement()..text = "Pause";
    pauseButton.onClick.listen((MouseEvent e) => pause());
    ButtonElement editButton = new ButtonElement()..text = "Edit Current Doll";

    editLink = new AnchorElement()..append(editButton)..target = "_blank";

    querySelector("#contents").append(pauseButton);
    querySelector("#contents").append(editLink);
    querySelector("#contents").append(borderElement);
    music = querySelector("#bgAudio");

    if(getParameterByName("tickRateInMilliseconds",null)  != null) {
        tickRate = int.parse(getParameterByName("tickRateInMilliseconds", null)); //chop off leading ?
    }
    tick();

}

void pause() {
    paused = !paused;
    if(paused) {
        music.pause();
    }else {
        music.play();
    }

}

Future<Null> tick() async {
    print("buffer $currentBuffer, tick rate is $tickRate");
    if(!paused) {
        if (currentBuffer % buffersForDoll == 0 || doll == null) {
            //print("new doll");
            loading = false;
            newDoll();
        } else {
            //print("new color");
            newColor();
        }

        if (buffer != null) await drawDoll();
        getNextBuffer(); //don't need to wait for it.
        //what's the bpm of manic's music? 90, he says
    }
    new Timer(new Duration(milliseconds: tickRate), () => tick());
}

Future<Null> drawDoll() {
    if(loading) return null; //not ready to render yet
    canvas.width = buffer.width;
    canvas.height = buffer.height;
    canvas.context2D.drawImage(buffer,0,0);
    //print("updated canvas from buffer");
    editLink.href= "index.html?${doll.toDataUrlPart()}";

}

Future<Null> getNextBuffer() async {
    if(loading) return null; //don't try to get the same doll multiple times.
    loading = true;
    buffer = new CanvasElement(width: doll.width, height: doll.height);
     await  DollRenderer.drawDoll(buffer, doll);
    currentBuffer ++;
    //print("got buffer");
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


