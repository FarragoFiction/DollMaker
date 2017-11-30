import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import 'dart:async';

import "BaseController.dart";
List<SavedDoll> savedDolls = new List<SavedDoll>();

void main() {
    List<Doll> dolls = Doll.loadAllFromLocalStorage();
    print("loaded ${dolls.length} dolls");

    Element container = querySelector("#contents");

    for(Doll doll in dolls) {
        savedDolls.add(new SavedDoll(doll, container));
    }
}

class SavedDoll {
    Doll doll;
    CanvasElement canvas;
    TextAreaElement textAreaElement;

    SavedDoll(this.doll, Element container) {
        Element bluh = new DivElement();
        bluh.style.display = "inline-block";
        container.append(bluh);
        renderSelfToContainer(bluh);
        renderDataUrlToContainer(bluh);
    }


    Future<Null> renderSelfToContainer(Element container) async {
        canvas = new CanvasElement(width: doll.width, height: doll.height);
        container.append(canvas);
        Renderer.drawDoll(canvas, doll);
    }

    Future<Null> renderDataUrlToContainer(Element container) async {
        Element bluh = new DivElement();
        container.append(bluh);
        textAreaElement = new TextAreaElement();
        textAreaElement.setInnerHtml(doll.toDataBytesX());
        bluh.append(textAreaElement);

        ButtonElement copyButton = new ButtonElement();
        bluh.append(copyButton);
        copyButton.setInnerHtml("Copy");
        copyButton.onClick.listen((Event e) {
            textAreaElement.select();
            document.execCommand('copy');
        });
    }


}