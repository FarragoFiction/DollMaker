import 'dart:html';

import 'package:DollLibCorrect/DollRenderer.dart';

Element container;
void main() {
    container = querySelector("#contents");
    todo("for each doll, for each doll part, print out name of file path");
    todo("for each file path, print out contents as text");
    printAllDollPaths();
}

void todo(String todoString) {
    LIElement bluh = new LIElement()..setInnerHtml("<b>TODO:</b> $todoString");
    container.append(bluh);
}

void printAllDollPaths() {
    for(int i in Doll.allDollTypes) {
        printOneDollPath(Doll.randomDollOfType(i));
    }
}

void printOneDollPath(Doll doll) {
    String source = "DollPartsUpload/DollSource"; //assume we are local
    DivElement dollDiv = new DivElement()..setInnerHtml("<h1>${doll.name}</h1>");
    dollDiv.style.margin = "30px";
    dollDiv.style.border = "3px solid black";
    container.append(dollDiv);
    for(SpriteLayer layer in doll.dataOrderLayers) {
        printOneDirectory("$source/${layer.imgNameBase}", dollDiv);
    }
}

void printOneDirectory(String dir, Element div) {
    DivElement line = new DivElement();

    line.setInnerHtml("<b>$dir</b>: TODO: print contents");
    div.append(line);
}