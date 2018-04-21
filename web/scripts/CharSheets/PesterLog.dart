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

    bool dollDirty2 = true;
    CanvasElement cachedDollCanvas2;
    String chatHandle1 = "jadedResearcher";
    String chatHandle2 = "authorBot";
    Colour tint2;
    String chatText = "JR: HELLO WORLD\nAB:No need to shout.";

    bool useRandomChat = true;
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
        chatHandle1 = handleForDoll();
        chatHandle2 = handleForDoll();
        intro = new TextLayer("X Began Pestering Y","",290.0,65.0, fontSize: 12, maxWidth: 220,fontColor: ReferenceColours.BLACK);
    }

    String get introText {
        String first = chatHandleShort(chatHandle1);
        String second = chatHandleShortCheckDup(chatHandle2, first);
        return "--$chatHandle1 [$first] began pestering $chatHandle2[${second}]--";
    }

    void makeRandomChatBasedOnDolls() {
        String first = chatHandleShort(chatHandle1);
        String second = chatHandleShortCheckDup(chatHandle2, first);
        chatText = BullshitLine.buildConversation(doll, secondDoll, first, second);
    }



    Element makeTintSelector2() {
        Element ret = new DivElement();
        ret.setInnerHtml("Color2: ");
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = tint2.toStyleString();
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
        print("trying to draw $chat");
        CanvasRenderingContext2D ctx = canvas.getContext("2d");
        double lineHeight = ctx
            .measureText("M")
            .width * 1.2;
        List<String> lines = chat.split("\n");
        String player1Start = chatHandleShort(chatHandle1);
        String player2Start = chatHandleShortCheckDup(chatHandle2, player1Start);
        for (int i = 0; i < lines.length; ++i) {
            print("line is ${lines[i]}");
            //does the text begin with player 1's chat handle short? if so: getChatFontColor
            String ct = lines[i].trim();

            //check player 2 first 'cause they'll be more specific if they have same initials
            if (ct.startsWith(player2Start)) {
                ctx.fillStyle = tint.toStyleString();
                ctx.font = "12px Times New Roman";
            } else if (ct.startsWith(player1Start)) {
                ctx.fillStyle = tint2.toStyleString();
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
        ret.append(makeChatHandle1());
        ret.append(makeChatHandle2());
        makeChatHandle1();
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
        dollArea.value = chatText;
        dollArea.rows = 10;
        dollArea.cols = 60;
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Change Chat");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            chatText = dollArea.value;
            useRandomChat = false;
            draw();
        });
        return ret;
    }

    Element makeChatHandle1() {
        Element ret = new DivElement();
        ret.setInnerHtml("chatHandle1");
        TextInputElement dollArea = new TextInputElement();
        dollArea.value = chatHandle1;
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Change ChatHandle");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            chatHandle1 = dollArea.value;
            draw();
        });
        return ret;
    }

    Element makeChatHandle2() {
        Element ret = new DivElement();
        ret.setInnerHtml("chatHandle1");
        TextInputElement dollArea = new TextInputElement();
        dollArea.value = chatHandle2;
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Change ChatHandle");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            chatHandle2 = dollArea.value;
            draw();
        });
        return ret;
    }

    Element makeDollLoader2() {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL2: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = secondDoll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll2");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            print("Trying to load doll");
            dollDirty2 = true;
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

    Future<CanvasElement>  drawDoll2(Doll doll, int w, int h) async {
        if(dollDirty2 || cachedDollCanvas2 == null) {
            cachedDollCanvas2 = new CanvasElement(width: w, height: h);
            if (hideDoll) return cachedDollCanvas2;
            CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
            dollCanvas.context2D.translate(dollCanvas.width, 0);
            dollCanvas.context2D.scale(-1, 1);
            await DollRenderer.drawDoll(dollCanvas, doll);
            //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

            dollCanvas = Renderer.cropToVisible(dollCanvas);

            Renderer.drawToFitCentered(cachedDollCanvas2, dollCanvas);
            dollDirty2 = false;
        }
        return cachedDollCanvas2;
    }


    Future<Null> drawREst([Element container]) async {

    }

    @override
    Future<Null> draw([Element container]) async {
        if(useRandomChat) {
            makeRandomChatBasedOnDolls();
        }

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

        if((intro.element.children.last as TextAreaElement).value == "") {
            intro.text = introText;
        }
        CanvasElement textCanvas = await drawText();
        fillChatTextMultiLine(textCanvas, chatText, 270, 80);
        canvas.context2D.drawImage(textCanvas, 0, 0);



        CanvasElement dollElement = await drawDoll(doll,250,300);
        CanvasElement dollElement2 = await drawDoll2(secondDoll,250,300);

        int y1 = height - dollElement.height;
        int y2= height - dollElement2.height;
        if(!hideDoll)canvas.context2D.drawImage(dollElement,0, y1);
        if(!hideDoll)canvas.context2D.drawImage(dollElement2,750, y2);
        syncSaveLink();
    }
}


class BullshitLine {
    //things that are all basically the same thing.
    List<String> textOptions;
    //if i'm responding to something, what should it have in it somewhere?
    //if empty, assume it can respond to anything.
    List<String> responseKeyWords;

    String get randomLine {
        Random rand = new Random();
        return rand.pickFrom(textOptions);
    }

    BullshitLine(List<String> this.textOptions, [List<String> this.responseKeyWords = null]) {
        if(responseKeyWords == null) responseKeyWords = <String>[];
    }

    bool validResponse(String line) {
        if(responseKeyWords.isEmpty) return true; //all are valid
        for(String word in responseKeyWords) {
            if(line.contains(word)) return true;
        }
        return false;
    }



    //is this the simplest possible "coherent" conversation?
    static String buildConversation(Doll doll, Doll secondDoll, String ch1, String ch2) {
        List<BullshitLine> person1Lines = BullshitLine.getLines(doll);
        List<BullshitLine> person2Lines = BullshitLine.getLines(secondDoll);
        String ret = "";
        Random rand = new Random();
        String line = rand.pickFrom(person1Lines).randomLine;
        ret = "$ret$ch1:$line\n";
        List<BullshitLine> validLines1 = new List<BullshitLine>();
        List<BullshitLine> validLines2 = new List<BullshitLine>();

        for(int i = 0; i<7; i++) {
            validLines1.clear();
            validLines2.clear();
            for(BullshitLine l in person2Lines) {
                if(l.validResponse(line)) validLines2.add(l);
            }

            if(validLines2.isNotEmpty) {
                line = rand.pickFrom(validLines2).randomLine;
            }else {
                line = "...";
            }
            ret = "$ret$ch2:$line\n";

            for(BullshitLine l in person1Lines) {
                if(l.validResponse(line)) validLines1.add(l);
            }
            if(validLines1.isNotEmpty) {
                line = rand.pickFrom(validLines1).randomLine;
            }else {
                line = "...";
            }
            ret = "$ret$ch1:$line\n";
        }

        return ret;
    }

    static List<BullshitLine> getLines(Doll doll) {
        List<BullshitLine> ret = new List<BullshitLine>();
        if(doll is PigeonDoll) ret.addAll(pigeonTalk());

        if(doll is HomestuckGrubDoll) ret.addAll(grubTalk());
        //TODO have lines for most dolls, and have Troll Dolls have quirks
        ret.addAll(pigeonTalk());
        return ret;
    }

    static List<BullshitLine> pigeonTalk() {
        return <BullshitLine>[new BullshitLine(<String>["coo","coo coo","oh-oo-oor","roo-c'too-coo"])];
    }

    static List<BullshitLine> grubTalk() {
        return <BullshitLine>[new BullshitLine(<String>["u bad","u gud","bite u","pap u"])];
    }
}
