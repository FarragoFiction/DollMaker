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
CanvasElement buffer = new CanvasElement(width:1000, height: 1000);
CanvasElement canvas = new CanvasElement(width:1000, height: 1000);
ImageElement image;
//TODO draw single pumpkin
//TODO draw animated line of pumpkins
//TODO allow pumpkin direction to sudddenly change by 90 degrees
//TODO allow pumpkin drawer to teleport to any existing pumpkin location
//TODO allow multiple pumpkin drawers at a time
//TODO allow ppl to upload an image so long as it can be resized to 50 px wide
//TODO maybe have a diff image for each indepednant pumpking drawer?
//TODO ????????????????????????????????????????

int seed =13;
Future<Null> main() async{
    loadNavbar();
    contents = querySelector("#contents");
    contents.append(canvas);
    image = await Loader.getResource("images/this_pumpkin.png");
    PumpkinDrawer pumpkinDrawer = new PumpkinDrawer(image,canvas,buffer,seed);
    pumpkinDrawer.draw();
}



//each pumpkin drawer is responsible for drawing a single pumpking that moves in a line
class PumpkinDrawer {
    ImageElement image;
    CanvasElement canvas;
    CanvasElement buffer;
    int cursorX = 500;
    int cursorY = 500;
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

    PumpkinDrawer(ImageElement this.image, CanvasElement this.canvas, CanvasElement this.buffer, int seed) {
        rand = new Random(seed);
        xDirection = imageWidth;
        rand.nextInt(); //init
    }



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
        buffer.context2D.drawImage(image,cursorX,cursorY);
        drawBuffer();
        numPumpkinsInRow ++;
        history.add(new Point(cursorX, cursorY));
        new Timer(new Duration(milliseconds: 100), () => draw());
    }
}


