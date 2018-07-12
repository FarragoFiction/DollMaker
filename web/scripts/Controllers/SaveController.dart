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
    downloadBackupLink();
    loadBackupButton();
}


void downloadBackupLink() {
    AnchorElement saveLink2 = new AnchorElement();
    Blob blob = new Blob([saveDataToTextFile()]); //needs to take in a list o flists
    saveLink2.href = Url.createObjectUrl(blob).toString();
    saveLink2.target = "_blank";
    saveLink2.download = "savedDollsBackup.txt";
    saveLink2.setInnerHtml("Download Backup");
    querySelector('#output').append(saveLink2);
}

//because past jr was a dunkass and didn't use json
String saveDataToTextFile() {
    List<String> ret = new List<String>();
    for(SavedDoll d in savedDolls) {
        ret.add( d.doll.toDataBytesX());
    }
    return ret.join(",");
}

void loadBackupButton() {
    InputElement fileElement = new InputElement();
    fileElement.type = "file";
    fileElement.setInnerHtml("Load from Backup?");
    querySelector("#output").appendHtml("Load from Backup?");
    querySelector("#output").append(fileElement);


    fileElement.onChange.listen((e) {
        List<File> loadFiles = fileElement.files;
        File file = loadFiles.first;
        FileReader reader = new FileReader();
        reader.readAsText(file);
        reader.onLoadEnd.listen((e) {
            String loadData = reader.result;
            clearDolls();
            saveAllDolls(loadData);
            window.location.href= "index.html";
        });
    });
}

void clearDolls() {
    //fuck you if you want to store more than 1k dolls.
    for(int i = 0; i<255; i++) {
        if(window.localStorage.containsKey("${Doll.localStorageKey}$i")) {
            window.localStorage.remove("${Doll.localStorageKey}$i");
        }
    }
}

void saveAllDolls(String loadData) {
    List<String> dataStrings = loadData.split(",");
    for(int i = 0; i< dataStrings.length; i++) {
        window.localStorage["${Doll.localStorageKey}$i"] = dataStrings[i];
    }
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
