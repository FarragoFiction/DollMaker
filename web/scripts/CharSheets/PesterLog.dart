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
        intro = new TextLayer("Intro Text","X began Pestering Y",370.0,130.0, fontSize: 25, maxWidth: 220, fontName: "trollcall", emphasis: emphasis,fontColor: color);
        //TODO parse a chat log, turn into objects
    }


    @override
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";
        ret.append(makeDollLoader());
        ret.append(makeDollLoader2());
        ret.append(makeHideButton());
        ret.append(makeTintSelector());
        ret.append(makeTextLoader());
        ret.append(makeSaveButton());
        return ret;
    }

    Element makeDollLoader2() {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL2: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll2");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            print("Trying to load doll");
            secondDoll = Doll.loadSpecificDoll(dollArea.value);
            print("trying to draw loaded doll");
            draw();
        });
        return ret;
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


        CanvasElement dollElement = await drawDoll(doll,250,300);
       // secondDoll.orientation = Doll.TURNWAYS; <-- jesus fuck WHY WONT YOU WORK
        CanvasElement dollElement2 = await drawDoll(secondDoll,250,300);

        int y1 = height - dollElement.height;
        int y2= height - dollElement2.height;
        if(!hideDoll)canvas.context2D.drawImage(dollElement,0, y1);
        if(!hideDoll)canvas.context2D.drawImage(dollElement2,750, y2);

    }
}