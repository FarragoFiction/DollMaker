import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";


void main() {
    print("Hello World");
    loadNavbar();

    printPalette();

}

void printPalette() {
    Element paletteDiv = querySelector("#palette");
    String html = "<table><tr><th><b>Trolls/Kids</b></th><th><b>Consorts</b></th></tr><td valign='top'>";
    List<String> names = new List<String>.from(ReferenceColours.TROLL_PALETTE.names);
    names.sort();

    for(String name in names) {
        html += "<li>$name: ${ReferenceColours.TROLL_PALETTE[name].toStyleString()}</li>";
    }
    html += "</td><td valign='top'>";
    names = new List<String>.from(ReferenceColours.CONSORT_PALETTE.names);
    names.sort();

    for(String name in names) {
        html += "<li>$name: ${ReferenceColours.CONSORT_PALETTE[name].toStyleString()}</li>";
    }
    html+="</td></td></table>";
    paletteDiv.setInnerHtml(html);
}