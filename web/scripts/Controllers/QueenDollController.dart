
import "../HomestuckDollLib.dart";
import "dart:html";
import "../DollLib/DollRenderer.dart";
import "../DollMakerTools.dart";
import "../navbar.dart";
import "BaseController.dart";

QueenController controller;

void main() {
    print("Hello World");
    loadNavbar();
    Random rand = new Random();
    controller = new QueenController(new QueenDoll());
    print("going to load doll");
    loadDoll();
    //bundle means i don't have to preload shit
    //Renderer.loadHomestuckDollParts(doll, loadDoll);

}

void loadDoll() {
    print("loading doll");
    String dataString = window.location.search;
    print("dataSTring is $dataString");
    if(dataString.isNotEmpty) {
       controller.doll = new QueenDoll.fromDataString(dataString.substring(1)); //chop off leading ?
    }

    //whether i loaded or not, it's time to draw.
    controller.setupForms();
    controller.drawDollCreator();
}


class QueenController extends BaseController {
  QueenController(Doll doll) : super(doll);


}