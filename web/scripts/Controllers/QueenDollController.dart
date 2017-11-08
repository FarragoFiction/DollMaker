
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

  @override
  void drawDollCreator() {
      print("Draw doll creator");
      for (SpriteLayer l in doll.renderingOrderLayers) {
          //TODO this will work differently for named layers
          //DollMakerTools.syncDropDownToSprite(l);
      }

      CanvasElement canvas = querySelector("#doll_creator");
      Renderer.clearCanvas(canvas);
      Renderer.drawDoll(canvas, doll);
      TextAreaElement dataBox = querySelector("#shareableURL");
      dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
  }


@override
  void setupForms() {
      querySelector("#randomize").onClick.listen((e) => randomizeDoll());
      querySelector("#randomizeColors").onClick.listen((e) => randomizeDollColors());
      querySelector("#randomizeNotColors").onClick.listen((e) => randomizeDollNotColors());

      ButtonElement copyButton = querySelector("#copyButton");
      copyButton.onClick.listen((Event e) {
          TextAreaElement dataBox = querySelector("#shareableURL");
          dataBox.select();
          document.execCommand('copy');
      });


      Element layerControls = querySelector("#layerControls");
      Element colorControls = querySelector("#colorControls");
      for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
          DollMakerTools.drawDropDownForSpriteLayer(doll, layerControls, l, drawDollCreator);
      }

      NamedLayerDoll d = doll as NamedLayerDoll;
      NamedSpriteLayer newLayer = new NamedSpriteLayer(d.possibleParts, "New Layer", "", 0, 0);
      //TODO need to have a section for adding a new layer.
      DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);
  }

}