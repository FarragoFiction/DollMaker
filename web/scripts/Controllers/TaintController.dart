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
CanvasElement buffer;
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
    int xDirection = 50;
    int yDirection = 0;
    int imageWidth = 50;
    double oddsTurning = .13;
    Random rand;

    PumpkinDrawer(ImageElement this.image, CanvasElement this.canvas, CanvasElement this.buffer, int seed) {
        rand = new Random(seed);
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
        }else {
            xDirection = direction;
        }
    }

    void move() {
        cursorY += yDirection;
        cursorX += xDirection;
        if(rand.nextDouble() < oddsTurning) {
            changeDirection();
        }
    }

    Future<Null> draw() async {
        move();
        buffer.context2D.drawImage(image,cursorX,cursorY);
        drawBuffer();
    }
}

