
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
    Doll doll = new QueenDoll();
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    querySelector("#doll").append(canvas);
    controller = new QueenController(doll,canvas);
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
  QueenController(Doll doll, CanvasElement canvas) : super(doll, canvas);

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
  void randomizeDoll() {
      print("randomizing and redrawing");
      doll.randomize();
      //can't do it in regular draw part cuz onChange is a bitch.
      DollMakerTools.syncColorPickersToSprite(doll.palette);
      drawLayerControls();
      drawDollCreator();
  }

  @override
  void randomizeDollNotColors() {
      print("randomizing and redrawing");
      doll.randomizeNotColors();
      //can't do it in regular draw part cuz onChange is a bitch.
      DollMakerTools.syncColorPickersToSprite(doll.palette);
      drawDollCreator();
      drawLayerControls();
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


      Element colorControls = querySelector("#colorControls");

        drawLayerControls();
      DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);
  }

  void drawLayerControls() {
      Element layerControls = querySelector("#layerControls");
      layerControls.setInnerHtml("");
      for (SpriteLayer l in doll.renderingOrderLayers.reversed) {
          DollMakerTools.drawDropDownForSpriteLayer(doll, layerControls, l, drawDollCreator);
      }


      //want to be able to add new layers
      DollMakerTools.addNewNamedLayerButton(doll, layerControls, drawDollCreator);
  }



}