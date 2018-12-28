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
    ButtonElement button = new ButtonElement()..text = "Dream?";
    contents.append(button);
    image = await Loader.getResource("images/New_Trees_Background_Plus_Prince.png");
    InputElement fileElement = new InputElement();
    fileElement.type = "file";
    fileElement.classes.add("fileUploadButton");
    contents.append(fileElement);
    await Doll.loadFileData();

    LabelElement label = new LabelElement()..text = "Doll String";
    TextAreaElement dollUpload = new TextAreaElement();
    contents.append(label);
    contents.append(dollUpload);

    LabelElement unitLabel = new LabelElement()..text = "Unit Width: $imageWidth";
    RangeInputElement widthElement = new RangeInputElement();
    widthElement.min = "1";
    widthElement.value="$imageWidth";
    widthElement.max="113";
    contents.append(unitLabel);
    contents.append(widthElement);

    contents.append(canvas);
    button.onClick.listen((Event e) {
        button.text = "You're Not Strong Enough To Wake Up";
        button.disabled = true;
        init();
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



class DreamDrawer {
    CanvasElement image;
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


    DreamDrawer(CanvasElement this.image, CanvasElement this.canvas, int this.imageWidth,int seed) {
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
            imageData=image.context2D.getImageData(0, 0, canvas.width, canvas.height);
            //don't want a clear canvas
            canvas.context2D.drawImage(image,0,0);
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
          imageData=image.context2D.getImageData(0, 0, image.width, image.height);
          //don't want a clear canvas
          canvas.width = image.width;
          canvas.height = image.height;
          canvas.context2D.drawImage(image,0,0);
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


