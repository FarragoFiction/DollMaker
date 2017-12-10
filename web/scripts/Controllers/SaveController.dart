import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";

import "BaseController.dart";
List<SavedDoll> savedDolls = new List<SavedDoll>();
Element container;

void main() {
    loadNavbar();
    loadDolls();
}

void loadDolls() {
    savedDolls = Doll.loadAllFromLocalStorage();
    print("loaded ${savedDolls.length} dolls");
    container = querySelector("#contents");

    if(savedDolls.length == 0) {
        container.setInnerHtml("<h1>You have no saved dolls! Maybe you should make <a href = 'index.html'>make some</a> or something???</h1>");
    }

    for(SavedDoll doll in savedDolls) {
        doll.drawSelf(container, refresh);
    }
}

void refresh() {
    container.setInnerHtml("");
    loadDolls();
}
