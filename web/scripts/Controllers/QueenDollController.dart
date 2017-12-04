
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
  void drawDollCreator([bool inQueue = false]) {
      DollMakerTools.syncColorPickersToSprite(doll.palette);
      drawLayerControls();
      print("Draw doll creator");
      Renderer.clearCanvas(canvas);
      Renderer.drawDoll(canvas, doll);
      TextAreaElement dataBox = querySelector("#shareableURL");
      dataBox.value = "${window.location.origin}${window.location.pathname}?${doll.toDataBytesX()}";
      //don't add it to the queue if you're already messing around in it, dunkass. you'll never escape the loop.
      if(!inQueue) {
          actionQueue.add(doll.toDataBytesX());
          actionQueueIndex = actionQueue.length-1;
      }
  }


@override
  void randomizeDoll() {
      print("randomizing and redrawing");
      doll.randomize();
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

      ButtonElement saveButton = querySelector("#saveButton");
      saveButton.onClick.listen((Event e) {
          doll.save();
      });


      Element colorControls = querySelector("#colorControls");

        drawLayerControls();
      DollMakerTools.drawColorPickersForPallete(colorControls, doll.palette, drawDollCreator);

      if(undo == null) {
          undo = new ButtonElement();
          undo.setInnerHtml("Undo");
          querySelector("#contents").append(undo);
          undo.onClick.listen((e) => undoFunction());
      }

      if(redo == null) {
          redo = new ButtonElement();
          redo.setInnerHtml("Redo");
          querySelector("#contents").append(redo);
          redo.onClick.listen((e) => redoFunction());
      }
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