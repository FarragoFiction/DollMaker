import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
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
    for(SavedDoll doll in savedDolls) {
        doll.drawSelf(container, refresh);
    }
}

void refresh() {
    container.setInnerHtml("");
    loadDolls();
}
