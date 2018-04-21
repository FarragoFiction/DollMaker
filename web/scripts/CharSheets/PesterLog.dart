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

    String chatHandle1 = "jadedResearcher";
    String chatHandle2 = "authorBot";
    Colour tint2;
    String chatText = "JR: HELLO WORLD\nAB:No need to shout.";
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
        tint2 = secondDoll.associatedColor;

        Colour color = new Colour.from(tint)..setHSV(tint.hue, 0.2, 1.0 );
        intro = new TextLayer("Intro Text","",290.0,65.0, fontSize: 12, maxWidth: 220,fontColor: ReferenceColours.BLACK);
        //TODO parse a chat log, turn into objects
    }

    String get introText {
        String first = chatHandleShort(chatHandle1);
        String second = chatHandleShortCheckDup(chatHandle2, first);
        return "--$chatHandle1 [$first] began pestering $chatHandle2[${second}]--";
    }



    Element makeTintSelector2() {
        Element ret = new DivElement();
        ret.setInnerHtml("Color2: ");
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = tint.toStyleString();
        colorPicker.onChange.listen((Event e) {
            tint2 = new Colour.fromStyleString(colorPicker.value);
            draw();
        });

        ret.append(colorPicker);
        return ret;
    }


    String joinMatches(Iterable<Match> matches, [String joiner = ""]) => joinCollection(matches, convert: (Match m) => m.group(0), combine: (String p, String e) => "$p$joiner$e", initial: "");

    U joinCollection<T, U>(Iterable<T> list, {U convert(T input), U combine(U previous, U element), U initial = null}) {
        Iterator<T> iter = list.iterator;

        bool first = true;
        U ret = initial;

        while (iter.moveNext()) {
            if (first) {
                first = false;
                ret = convert(iter.current);
            } else {
                ret = combine(ret, convert(iter.current));
            }
        }

        return ret;
    }


    String chatHandleShort(String chatHandle) {
        RegExp exp = new RegExp(r"""\b(\w)|[A-Z]""", multiLine: true);
        return joinMatches(exp.allMatches(chatHandle)).toUpperCase();
    }

    String chatHandleShortCheckDup(String chatHandle, String otherHandle) {
        RegExp exp = new RegExp(r"""\b(\w)|[A-Z]""", multiLine: true);
        String tmp = joinMatches(exp.allMatches(chatHandle)).toUpperCase();
        if (tmp == otherHandle) {
            tmp = "${tmp}2";
        }
        return tmp;
    }


    //matches line color to player font color
    void fillChatTextMultiLine(CanvasElement canvas, String chat,int x, num y) {
        CanvasRenderingContext2D ctx = canvas.getContext("2d");
        double lineHeight = ctx
            .measureText("M")
            .width * 1.2;
        List<String> lines = chat.split("\n");
        String player1Start = chatHandleShort(chatHandle1);
        String player2Start = chatHandleShortCheckDup(chatHandle2, player1Start);
        for (int i = 0; i < lines.length; ++i) {
            //does the text begin with player 1's chat handle short? if so: getChatFontColor
            String ct = lines[i].trim();

            //check player 2 first 'cause they'll be more specific if they have same initials
            if (ct.startsWith(player2Start)) {
                ctx.fillStyle = tint;
                ctx.font = "12px Times New Roman";
            } else if (ct.startsWith(player1Start)) {
                ctx.fillStyle = tint2;
                    ctx.font = "12px Times New Roman";
            } else {
                ctx.fillStyle = "#000000";
            }
            int lines_wrapped = Renderer.wrap_text(ctx, ct, x, y, lineHeight, canvas.width - 50, "left");
            y += lineHeight * lines_wrapped;
        }
        //word wrap these
        ctx.fillStyle = "#000000";
    }


    @override
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";
        ret.append(makeDollLoader());
        ret.append(makeDollLoader2());
        ret.append(makeHideButton());
        ret.append(makeTintSelector());
        ret.append(makeTintSelector2());
        ret.append(makeTextLoader());
        ret.append(makeChatLoader());
        ret.append(makeSaveButton());
        return ret;
    }

    Element makeChatLoader() {
        Element ret = new DivElement();
        ret.setInnerHtml("Pesterlog Text, with Chat Initials On First Line:");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            draw();
        });
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

        if(intro.text == "") intro.text = introText;
        CanvasElement textCanvas = await drawText();
        canvas.context2D.drawImage(textCanvas, 0, 0);

        fillChatTextMultiLine(textCanvas, chatText, 8, 80);


        CanvasElement dollElement = await drawDoll(doll,250,300);
       // secondDoll.orientation = Doll.TURNWAYS; <-- jesus fuck WHY WONT YOU WORK
        CanvasElement dollElement2 = await drawDoll(secondDoll,250,300);

        int y1 = height - dollElement.height;
        int y2= height - dollElement2.height;
        if(!hideDoll)canvas.context2D.drawImage(dollElement,0, y1);
        if(!hideDoll)canvas.context2D.drawImage(dollElement2,750, y2);

    }
}

