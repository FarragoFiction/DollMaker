import '../Shipping/Participant.dart';
import '../Shipping/Trove.dart';
import 'DollSlurper.dart';
import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';


Random rand = new Random();

Element contents;
CanvasElement buffer = new CanvasElement(width:1000, height: 600);
CanvasElement canvas = new CanvasElement(width:1000, height: 600);
ImageElement image;
int imageWidth = 13;
//TODO let people import a doll that gets resized.


//TODO if an image is uploaded the seed should be the data length?
int seed =13;
Future<Null> main() async{
    loadNavbar();
    contents = querySelector("#contents");
    ButtonElement button = new ButtonElement()..text = "Consent To Spread Taint?";
    contents.append(button);
    image = await Loader.getResource("images/this_pumpkin.png");
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
    widthElement.min = "13";
    widthElement.value="$imageWidth";
    widthElement.max="113";
    contents.append(unitLabel);
    contents.append(widthElement);

    contents.append(canvas);
    button.onClick.listen((Event e) {
        button.text = "The Taint Cannot Be Stopped";
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
            button.text = "The Taint Cannot Be Stopped";
            button.disabled = true;
            init();
        });
    });

    dollUpload.onChange.listen((e) {

        button.text = "The Taint Cannot Be Stopped";
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
    CanvasElement imageCanvas = new CanvasElement(width: imageWidth, height: imageWidth);
    imageCanvas.context2D.drawImageScaled(tmpCanvas, 0, 0, imageWidth, imageWidth);
    PumpkinDrawer pumpkinDrawer = new PumpkinDrawer(
        imageCanvas, canvas, buffer, imageWidth,seed);
    pumpkinDrawer.draw();

}

Future<Null> init() async {
  CanvasElement imageCanvas = new CanvasElement(width: imageWidth, height: imageWidth);
  imageCanvas.context2D.drawImageScaled(image, 0, 0, imageWidth, imageWidth);
  PumpkinDrawer pumpkinDrawer = new PumpkinDrawer(
      imageCanvas, canvas, buffer,imageWidth, seed);
  pumpkinDrawer.draw();
}



//each pumpkin drawer is responsible for drawing a single pumpking that moves in a line
class PumpkinDrawer {
    CanvasElement image;
    CanvasElement canvas;
    CanvasElement buffer;
    int cursorX = 500;
    int cursorY = 300;
    int xDirection = 13;
    int yDirection = 0;
    int imageWidth = 13;
    double oddsTurning = .03;
    double teleportationRate = 0.01;
    int minBeforeTurning = 13;
    int numPumpkinsInRow = 0;
    Random rand;

    //so i can teleport to somewhere i've previously drawn
    List<Point> history = new List<Point>();

    PumpkinDrawer(CanvasElement this.image, CanvasElement this.canvas, CanvasElement this.buffer, int this.imageWidth,int seed) {
        rand = new Random(seed);
        xDirection = imageWidth;
        rand.nextInt(); //init
    }



    //huh, using a buffer makes it just a shade nondeterministic which is weird, it wobbles
    Future<Null> drawBuffer() async {
        canvas.context2D.drawImage(buffer,0,0);
    }

    void changeDirection() {
        int direction = (-0.9*imageWidth).round();
        if(rand.nextBool()) {
            direction = direction * -1;
        }
        //if you're currently going horizontally go vertical or vice versa.
        if(xDirection != 0) {
            yDirection = direction;
            xDirection = 0;
        }else {
            xDirection = direction;
            yDirection = 0;
        }
        numPumpkinsInRow = 0;
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

    void teleport() {
        Point newPoint = rand.pickFrom(history);
        cursorY = newPoint.y;
        cursorX = newPoint.x;
    }

    void move() {
        if(numPumpkinsInRow > minBeforeTurning && (rand.nextDouble() < oddsTurning || offScreen())) {
            changeDirection();
        }
        cursorY += yDirection;
        cursorX += xDirection;
        //if you're STILL off screen just fucking leave
        if(offScreen() || rand.nextDouble() < teleportationRate) {
            changeDirection();
            teleport();
        }

    }

    Future<Null> draw() async {
        move();
        canvas.context2D.drawImage(image,cursorX,cursorY);
        //drawBuffer();
        numPumpkinsInRow ++;
        history.add(new Point(cursorX, cursorY));
        new Timer(new Duration(milliseconds: 100), () => draw());
    }
}


