import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";

Doll doll;

void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    doll = new HomestuckDoll();
    drawDollCreator();
    setupForms();
}


void setupForms() {


    ButtonElement loadButton = querySelector("#loadButton");
    loadButton.onClick.listen((Event e) {
        print('loading');
        TextAreaElement dataBox = querySelector("#shareableURL");
        //TODO if i'm given a url, chop it off till the ? do this in doll.
        String dataString = dataBox.value;
        doll = Doll.loadSpecificDoll(dataString);
        drawDollCreator();
    });

}



void drawDollCreator() {
    print("Draw doll creator");

    CanvasElement canvas = querySelector("#doll_creator");
    Renderer.clearCanvas(canvas);
    Renderer.drawDoll(canvas, doll);

}
