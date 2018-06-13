import 'UploadObject.dart';
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../../DollMakerTools.dart";
import "../../navbar.dart";

import "../BaseController.dart";
import "../QueenController.dart";
import "dart:async";
BaseController controller;

DivElement uploaderDiv;

//probably don't need to keep refs but it can't hurt
List<UploadObject> uploadObjects = new List<UploadObject>();
Future<Null> main() async {
    loadNavbar();
    Random rand = new Random();
    uploaderDiv = querySelector("#uploader");
    print("going to load doll");
    await loadDoll();
    shitpost(); //enable this when i need to know all directories
    makeUploadObjects();
}

void makeUploadObjects() {
    for(SpriteLayer layer in controller.doll.renderingOrderLayers) {
        //skip slaves and partners here too
        if(!layer.slave && layer.primaryPartner) {
            List<SpriteLayer> layers = <SpriteLayer>[layer];
            layers.addAll(layer.syncedWith);
            layers.addAll(layer.partners);
            UploadObject u = new UploadObject(controller,layers);
            uploadObjects.add(u);
            u.draw(uploaderDiv);
        }
    }
}

//do this when i need to know all directories
void shitpost() {
    //it's a set so no repeats
    Set<String> oneOfEachDollDirectory = new Set<String>();
    for(int i in Doll.allDollTypes) {
        Doll doll = Doll.randomDollOfType(i);
        oneOfEachDollDirectory.addAll(doll.getAllNeededDirectories());
    }
    oneOfEachDollDirectory.addAll(Doll.randomDollOfType(25).getAllNeededDirectories());
    oneOfEachDollDirectory.addAll(Doll.randomDollOfType(26).getAllNeededDirectories());
    oneOfEachDollDirectory.addAll(Doll.randomDollOfType(24).getAllNeededDirectories());


    int i = 0;
    for(String text in oneOfEachDollDirectory) {
        String t = text;
        i ++;
        //this is for if i want to know how many directories there are
        //t = "$i: $text";
        DivElement li = new DivElement()..text = t;
        uploaderDiv.append(li);
    }
}

void todo(String text) {
    LIElement li = new LIElement()..text = text;
    uploaderDiv.append(li);
}


Future<Null> loadDoll() async {
    print("loading doll");
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    Doll doll;
    if(dataString.isNotEmpty && getParameterByName("type",null)  != null) {
        doll = Doll.randomDollOfType(int.parse(getParameterByName("type",null))); //chop off leading ?

    }else if (dataString.isNotEmpty) {
        doll = Doll.loadSpecificDoll(dataString.substring(1)); //chop off leading ?
    }

    //doing it this way ensures no incorrect sized canvas from a default doll.
    if(doll == null) doll =  Doll.randomDollOfType(1);
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    querySelector("#doll").append(canvas);
    if(doll is QueenDoll) {
        controller = new QueenController(doll, canvas);

    }else {
        controller = new BaseController(doll, canvas);
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
}