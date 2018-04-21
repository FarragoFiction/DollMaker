//https://swirlygerm-art.tumblr.com/post/167621990417/hey-wanna-make-a-trollsona-for-hiveswap-like-how
import "package:DollLibCorrect/DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';
class PesterLog extends CharSheet {


    @override
    int width = 1000;
    @override
    int height = 300;

    @override
    int type = 5;

    TextLayer intro;
    Doll secondDoll;

    String chatHandle1;
    String chatHandle2;

    /**
     *
     * TODO:
     * draw two dolls with empty pester log in between
     * generate two random chat handles
     * draw intro text
     *
     * make "line" object
     *
     * make dumbshit random conversations.
     * a conversation is text + responseive key words. if previous line contains any of your key words, you can be a response
     * i want to see how dumb this is.
     */


    PesterLog(Doll doll, Doll this.secondDoll) : super(doll) {
        tint = doll.associatedColor;

        Colour color = new Colour.from(tint)..setHSV(tint.hue, 0.2, 1.0 );
        intro = new TextLayer("Fact1","X began Pestering Y",370.0,130.0, fontSize: 25, maxWidth: 220, fontName: "trollcall", emphasis: emphasis,fontColor: color);
        //TODO parse a chat log, turn into objects
    }





    //empty
    List<BarLayer> barLayers = new List<BarLayer>();


    @override
    List<TextLayer> get textLayers => <TextLayer>[intro]; //placeholder

    @override
    Future<CanvasElement>  drawText() async {

    }




    @override
    Future<Null> draw([Element container]) async {
        if(canvas == null) {
            print("making new canvas");
            canvas = new CanvasElement(width: width, height: height);
            canvas.className = "cardCanvas";
        }
        if(container != null) {
            print("appending canvas to container $container");
            container.append(canvas);
        }

        canvas.context2D.clearRect(0,0,width,height);

        CanvasElement sheetElement = await drawSheetTemplate();
        canvas.context2D.drawImage(sheetElement, 0, 0);

        //CanvasElement textCanvas = await drawText();
       //canvas.context2D.drawImage(textCanvas, 0, 0);


        CanvasElement dollElement = await drawDoll(doll,400,300);
        CanvasElement dollElement2 = await drawDoll(secondDoll,400,300);

        if(!hideDoll)canvas.context2D.drawImage(dollElement,-100, 275);
        if(!hideDoll)canvas.context2D.drawImage(dollElement2,650, 275);

    }
}