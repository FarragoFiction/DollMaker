import "../HomestuckDollLib.dart";
import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "dart:async";
import 'package:RenderingLib/src/loader/loader.dart';

import "BaseController.dart";
List<SavedDoll> savedDolls = new List<SavedDoll>();
Element container;

void main() {
    loadNavbar();
    loadDolls();
}

Future<Null> loadDolls() async {
    await Loader.preloadManifest();
    savedDolls = Doll.loadAllFromLocalStorage();
    print("loaded ${savedDolls.length} dolls");
    container = querySelector("#contents");

    if(savedDolls.length == 0) {
        container.setInnerHtml("<h1>You have no saved dolls! Maybe you should <a href = 'index.html?type=1'>make some</a> or something???</h1>");
    }

    for(SavedDoll doll in savedDolls) {
        doll.drawSelf(container, refresh);
    }
}

void refresh() {
    container.setInnerHtml("");
    loadDolls();
}
