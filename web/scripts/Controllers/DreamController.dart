import 'dart:typed_data';

import '../Shipping/Participant.dart';
import '../Shipping/Trove.dart';
import 'DollSlurper.dart';
import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:CommonLib/src/colours/colour.dart';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';
//Definitely nothing important
//just as useless as the taint controlelr really.
/*
TODO
 * render an image on screen
 * fuck that image up
 * animate it becoming even more fucked up
 * ???
 * profit
 */

Random rand = new Random();

Element contents;
CanvasElement canvas = new CanvasElement(width:1000, height: 600);
ImageElement image;
int imageWidth = 13;

int seed =13;
Future<Null> main() async{
    loadNavbar();
    contents = querySelector("#contents");
    Element dream = new DivElement()..classes.add("box");
    Element taint = new DivElement()..classes.add("box");;
    contents.append(dream);
    contents.append(taint);
    ButtonElement button = new ButtonElement()..text = "Dream?";
    dream.append(button);

    ButtonElement buttonTaint = new ButtonElement()..text = "Dream of Taint?";
    taint.append(buttonTaint);
    image = await Loader.getResource("images/New_Trees_Background_Plus_Prince.png");
    //TODO let the input file either be a dream or taint dream
    InputElement fileElement = new InputElement();
    fileElement.type = "file";
    fileElement.classes.add("fileUploadButton");
    dream.append(fileElement);

    Element taintUpload = Loader.loadButton(Formats.png, processTaintImage, caption: "Sacrifice an Image to the Taint?");

    taint.append(taintUpload);
    await Doll.loadFileData();

    LabelElement label = new LabelElement()..text = "Doll String";
    TextAreaElement dollUpload = new TextAreaElement();
    dream.append(label);
    dream.append(dollUpload);

    LabelElement unitLabel = new LabelElement()..text = "Unit Width: $imageWidth";
    RangeInputElement widthElement = new RangeInputElement();
    widthElement.min = "1";
    widthElement.value="$imageWidth";
    widthElement.max="113";
    dream.append(unitLabel);
    dream.append(widthElement);

    contents.append(canvas);
    button.onClick.listen((Event e) {
        button.text = "You're Not Strong Enough To Wake Up";
        button.disabled = true;
        init();
    });

    buttonTaint.onClick.listen((Event e) {
        buttonTaint.text = "You're Not Strong Enough To Stop It. You never were.";
        buttonTaint.disabled = true;
        initTaint();
    });



    fileElement.onChange.listen((e) {
        List<File> loadFiles = fileElement.files;
        File file = loadFiles.first;
        FileReader reader = new FileReader();
        reader.readAsDataUrl(file);
        print("the file was $file");
        reader.onLoadEnd.listen((e) {
            //sparse
            String loadData = reader.result;
            seed = loadData.length;
            //String old = chat.icon.src;
           image.src = loadData;
            button.text = "You're Not Strong Enough To Wake Up";
            button.disabled = true;
            buttonTaint.disabled = true;
            init();
        });
    });



    dollUpload.onChange.listen((e) {

        button.text = "You're Not Strong Enough To Wake Up";
        button.disabled = true;
        Doll doll = Doll.loadSpecificDoll(dollUpload.value);
        initDoll(doll);

    });

    widthElement.onChange.listen((e) {
        imageWidth = int.parse(widthElement.value);
        unitLabel.text = "Unit Width: $imageWidth";
    });


}

void processTaintImage(ImageElement fileElementTaint, String words) {
        image = fileElementTaint;
      initTaint();
}

Future<Null> initDoll(Doll doll) async{
    CanvasElement tmpCanvas = doll.blankCanvas;
    tmpCanvas.width = doll.width;
    tmpCanvas.height = doll.height;

    await DollRenderer.drawDoll(tmpCanvas, doll);
    DreamDrawer pumpkinDrawer = new DreamDrawer(tmpCanvas, canvas, imageWidth,seed);
    pumpkinDrawer.noise();
    pumpkinDrawer.drawNoise();

}

Future<Null> init() async {
  CanvasElement imageCanvas = new CanvasElement(width: image.width, height: image.height);
  imageCanvas.context2D.drawImage(image,0,0);
  DreamDrawer dreamDrawer = new DreamDrawer(
      imageCanvas, canvas,imageWidth, seed);
  dreamDrawer.noise();
  dreamDrawer.drawNoise();
}

Future<Null> initTaint() async {
    CanvasElement imageCanvas = new CanvasElement(width: image.width, height: image.height);
    CanvasElement debugCanvas = new CanvasElement(width: image.width, height: image.height);
    contents.append(debugCanvas);
    imageCanvas.context2D.drawImage(image,0,0);
    DreamTaint dreamDrawer = new DreamTaint(
        imageCanvas, canvas,debugCanvas,imageWidth, seed);
    dreamDrawer.noise();
    dreamDrawer.drawNoise();
}




class DreamDrawer {
    CanvasElement imageCanvas;
    ImageData imageData;
    CanvasElement canvas;
    double cursorX = 500.0;
    double cursorY = 300.0;
    double xDirection = 13.0;
    double yDirection = 5.0;
    int imageWidth = 13;
    //higher is more consistent
    double directionConsistency = 0.1;
    Random rand;


    DreamDrawer(CanvasElement this.imageCanvas, CanvasElement this.canvas, int this.imageWidth,int seed) {
        rand = new Random(seed);
        rand.nextInt(); //init
    }

    void changeDirection() {
        //only change direction if its time
        if(rand.nextDouble() > directionConsistency) {
            xDirection = (imageWidth * (rand.nextDouble()+0.5));
            yDirection = (imageWidth * (rand.nextDouble()+0.5));
            //either amount could be negative
            if(rand.nextBool()) {
                xDirection = -1 * xDirection;
            }
            if(rand.nextBool()) {
                yDirection = -1 * yDirection;
            }
        }

    }

    void teleport() {
        cursorX = 1.0*rand.nextInt(canvas.width);
        cursorY = 1.0*rand.nextInt(canvas.height);
    }

    void move() {
        changeDirection();
        cursorY += yDirection* (rand.nextDouble()+0.5);
        cursorX += xDirection* (rand.nextDouble()+0.5);
        //if you're STILL off screen just fucking leave
        if(offScreen()) {
            changeDirection();
            teleport();
        }

    }

    bool offScreen() {
        if(cursorY > canvas.height-imageWidth || cursorY < 0) {
            return true;
        }

        if(cursorX > canvas.width-imageWidth || cursorX < 0) {
            return true;
        }
        return false;
    }

    //TODO actually use image data to get the real color
    Colour getColorAtCursor() {
        int y = cursorY.floor();
        int x = cursorX.floor();
        //dm probably gave me this math way back in modern art sim
        int i = (y * canvas.width + x)* 4; //array is in sets of rgba
        return new Colour(imageData.data[i],imageData.data[i+1],imageData.data[i+2],imageData.data[i]);
    }


    //TODO draw a square of size imageWidth where the color comes from the image buffer
    Future<Null> drawSquiggles() async {
        if(imageData == null) {
            imageData=imageCanvas.context2D.getImageData(0, 0, canvas.width, canvas.height);
            //don't want a clear canvas
            canvas.context2D.drawImage(imageCanvas,0,0);
        }

        move();
        //canvas.context2D.drawImage(image,cursorX,cursorY);
        Colour color = getColorAtCursor();
        //note to future jr this might be hella slow
        canvas.context2D.setFillColorRgb(color.red, color.green, color.blue);
        canvas.context2D.fillRect(cursorX, cursorY, imageWidth,imageWidth);
        new Timer(new Duration(milliseconds: 100), () => drawSquiggles());
    }

    //TODO draw a square of size imageWidth where the color comes from the image buffer
    Future<Null> drawNoise() async {
        noise(113);
        new Timer(new Duration(milliseconds: 100), () => drawNoise());
    }

    void noise([int amount=666]) {
      if(imageData == null) {
          imageData=imageCanvas.context2D.getImageData(0, 0, imageCanvas.width, imageCanvas.height);
          //don't want a clear canvas
          canvas.width = imageCanvas.width;
          canvas.height = imageCanvas.height;
          canvas.context2D.drawImage(imageCanvas,0,0);
      }
      for(int i =0; i<amount; i++) {
          teleport();
          //canvas.context2D.drawImage(image,cursorX,cursorY);
          Colour color = getColorAtCursor();
          //note to future jr this might be hella slow
          canvas.context2D.setFillColorRgb(
              color.red, color.green, color.blue);
          canvas.context2D.fillRect(cursorX, cursorY, imageWidth, imageWidth);
      }
    }


}

class DreamTaint extends DreamDrawer {
    double currentThreshold = 1.0;
    CanvasElement debugCanvas;
    ImageData outputImageData;
  DreamTaint(CanvasElement image, CanvasElement canvas, CanvasElement this.debugCanvas, int imageWidth, int seed) : super(image, canvas, imageWidth, seed);

  //if you give me a canvas i will paint it black and make it gradient
  void coverWithAlphaGradient(CanvasElement sacrificeCanvas) {
        //TODO go through each pixel and make it solid black wiht an alpha value that slowly decreases based on y.
      //TODO play around with this later and make it procedural. can be circular or diagnoal or whatever
      sacrificeCanvas.context2D.fillRect(0,0, sacrificeCanvas.width, sacrificeCanvas.height); //make it a black box
      //if i return here i definitly see a black canvas in the end product
      ImageData boxImageData =sacrificeCanvas.context2D.getImageData(0, 0, sacrificeCanvas.width, sacrificeCanvas.height);

      int maxY = (sacrificeCanvas.height).floor();//blindly doubling it for now to make it look right

      int maxX = (sacrificeCanvas.width).floor();//blindly doubling it for now to make it look right
      Uint8ClampedList data = boxImageData.data; //Uint8ClampedList
      int currentGradient = 255;
      for(int i =0; i<data.length; i+=4) {
          int pixelIndex = (i/4).floor();
          int y = (pixelIndex/maxX).floor();
          currentGradient = 255-(255* y/maxY).ceil();
          data[i+3] = currentGradient;
      }
      sacrificeCanvas.context2D.putImageData(boxImageData, 0,0);
  }

    //if you give me a canvas i will paint it black and make it gradient
    void coverWithLinearGradient(CanvasElement sacrificeCanvas) {
        //TODO go through each pixel and make it solid black wiht an alpha value that slowly decreases based on y.
        //TODO play around with this later and make it procedural. can be circular or diagnoal or whatever
        //sacrificeCanvas.context2D.fillRect(0,0, sacrificeCanvas.width, sacrificeCanvas.height); //make it a black box
        //if i return here i definitly see a black canvas in the end product
        ImageData boxImageData =sacrificeCanvas.context2D.getImageData(0, 0, sacrificeCanvas.width, sacrificeCanvas.height);
        //at + b * (1-t)
        //t =currentGradient
        //a and b are the two colors. a is the top color, b is the bottom color
        //
        int maxY = (sacrificeCanvas.height).floor();//blindly doubling it for now to make it look right

        int maxX = (sacrificeCanvas.width).floor();//blindly doubling it for now to make it look right
        Uint8ClampedList data = boxImageData.data; //Uint8ClampedList
        int startColor = 255;
        int endColor = 0;
        for(int i =0; i<data.length; i+=4) {
            int pixelIndex = (i/4).floor();
            int y = (pixelIndex/maxX).floor();
            double t = (y/maxY);
            int dmsGradientCalc = ((startColor * t) + (endColor * (1-t))).round();
            data[i+0] = dmsGradientCalc;
            data[i+1] = dmsGradientCalc;
            data[i+2] = dmsGradientCalc;
            data[i+3] = 255;

        }
        sacrificeCanvas.context2D.putImageData(boxImageData, 0,0);
    }

    void stepThreshold() {
      currentThreshold += -1*0.01;
      if(currentThreshold <= 0) {
        currentThreshold = 1.0;
      }
      print("threshold is ${currentThreshold}");
    }

    void thresholdFunction() {
        Uint8ClampedList data = imageData.data; //Uint8ClampedList
        Uint8ClampedList newData =outputImageData.data;

        for(int i =0; i<data.length; i+=4) {
            int pixelIndex = (i/4).floor();
            //its 0 if its above a threshold and 255 otherwise.
            //its not the raw 0-255 value, but some saturation or something
            double amount = 0.299 * (data[i]/255) + 0.587 * (data[i+1]/255) + 0.114 * (data[i+2]/255);

            if(amount > currentThreshold) {
               // window.alert("black");
                newData[i] = 0;
                newData[i+1] = 0;
                newData[i+2] = 0;
                newData[i+3] = 255;
            }else {
                newData[i] = 255;
                newData[i+1] = 255;
                newData[i+2] = 255;
                newData[i+3] = 255;
            }
        }
        canvas.context2D.putImageData(outputImageData, 0,0);
        stepThreshold();

    }


    @override
  Future<Null> noise([int speed=1]) async {
      /*
      TODO
       take in an image
    * draw a gradient with alpha over that image
    * have a variable outside the method called threshold or whatever
    * if the value (or maybe saturation) is greater than that threshold, display it as a black pixel
    * animate over time, slowly decreasing that threshold
       */
      if(imageData == null) {
          //don't want a clear canvas
          canvas.width = imageCanvas.width;
          canvas.height = imageCanvas.height;
          debugCanvas.width = imageCanvas.width;
          debugCanvas.height = imageCanvas.height;
          //canvas.context2D.drawImage(imageCanvas,0,0);
          CanvasElement sacrifice = new CanvasElement(width: imageCanvas.width, height: imageCanvas.height);
          coverWithLinearGradient(sacrifice);
          debugCanvas.context2D.drawImage(sacrifice,0,0);
          debugCanvas.context2D.globalAlpha = 0.4;
          debugCanvas.context2D.drawImage(imageCanvas,0,0);
          debugCanvas.context2D.globalAlpha = 1.0;
          imageData= debugCanvas.context2D.getImageData(0, 0, debugCanvas.width, debugCanvas.height);
          outputImageData =canvas.context2D.getImageData(0, 0, canvas.width, canvas.height);

      }
      thresholdFunction();
      await window.animationFrame;
      new Timer(new Duration(milliseconds: 90), () => noise);

    }

}

