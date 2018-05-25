import 'UploadObject.dart';
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../../DollMakerTools.dart";
import "../../navbar.dart";

import "../BaseController.dart";
import "../QueenController.dart";

BaseController controller;

DivElement uploaderDiv;

//probably don't need to keep refs but it can't hurt
List<UploadObject> uploadObjects = new List<UploadObject>();
void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    uploaderDiv = querySelector("#uploader");
    print("going to load doll");
    loadDoll();
    //shitpost(); //enable this when i need to know all directories
    makeUploadObjects();
    todo("if a layer is slaved, it has it's slave in teh UploadObject with it");
    todo("new concept of 'partner' for things like eyes and horns that aren't slaves but should still be paired");
    todo("stub out form for each UploadObject: want nameToCredit (sanitize), the file itself, and the file path, and the max number known ");
}

void makeUploadObjects() {
    for(SpriteLayer layer in controller.doll.renderingOrderLayers) {
        //TODO eventually add slaves and partners? or have it do it itself?
        //skip slaves and partners here too
        if(!layer.slave) {
            List<SpriteLayer> layers = <SpriteLayer>[layer];
            layers.addAll(layer.syncedWith);
            UploadObject u = new UploadObject(layers);
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


void loadDoll() {
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