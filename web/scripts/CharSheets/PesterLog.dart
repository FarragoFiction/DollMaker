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
        //if they don't respond to you, you're legally allowed to talk about whatever.
        bool bullshit = false;
        for(int i = 0; i<7; i++) {
            validLines1.clear();
            validLines2.clear();
            for(BullshitLine l in person2Lines) {
                if(l.validResponse(line) || bullshit) validLines2.add(l);
            }

            if(validLines2.isNotEmpty) {
                bullshit = false;
                line = rand.pickFrom(validLines2).randomLine;
            }else {
                line = "...";
            }
            ret = "$ret$ch2:$line\n";

            for(BullshitLine l in person1Lines) {
                if(l.validResponse(line) || bullshit) validLines1.add(l);
            }
            if(validLines1.isNotEmpty) {
                bullshit = false;
                line = rand.pickFrom(validLines1).randomLine;
            }else {
                line = "...";
                bullshit = true;
            }
            ret = "$ret$ch1:$line\n";
        }

        return ret;
    }

    static List<BullshitLine> getLines(Doll doll) {
        List<BullshitLine> ret = new List<BullshitLine>();
        if(doll is PigeonDoll) ret.addAll(pigeonTalk());

        if(doll is HomestuckGrubDoll) {
            ret.addAll(grubTalk());
        }else if (doll is HomestuckTrollDoll || doll is HiveswapDoll) {
            ret.addAll(trollTalk());
        }

        if(doll is MomDoll) ret.addAll(momTalk());
        if(doll is DadDoll) ret.addAll(dadTalk());
        if(doll is DenizenDoll) ret.addAll(denizenTalk());

        if(doll is ConsortDoll) {
            int seed = doll.renderingOrderLayers.first.imgNumber;
            ret.addAll(consortTalk(seed));
        }


        if(!(doll is HomestuckBabyDoll) || !(doll is HomestuckGrubDoll) || !(doll is PigeonDoll) || !(doll is MonsterPocketDoll)) {
            ret.addAll(genericTalk());
            if(!(doll is HomestuckTrollDoll) || !(doll is HomestuckDoll) || !(doll is HiveswapDoll) || !(doll is HomestuckCherubDoll)) {
                ret.addAll(SBURBTalk());
            }
        }


        //TODO have Troll Dolls have quirks
        return ret;
    }

    //topics: clothes/pants, food, SBURB
    //        ret.add(new BullshitLine(<String>[""], <String>[""]));

    static List<BullshitLine> pigeonTalk() {
        return <BullshitLine>[new BullshitLine(<String>["coo","coo coo","oh-oo-oor","roo-c'too-coo"])];
    }

    static List<BullshitLine> grubTalk() {
        return <BullshitLine>[new BullshitLine(<String>["u bad","u gud","bite u","pap u"])];
    }

    static List<BullshitLine> genericTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        ret.add(new BullshitLine(<String>["Hrmmm...","Yes.","Interesting!!!","I don't think so?","Do you really think that?","I guess?"]));
    }

    static List<BullshitLine> trollTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        //clothes, food, SBURB
        ret.add(new BullshitLine(<String>["What kind of food do you keep in your thermal hull?","I'm as real as kraft grubsauce.","I kind of like to eat beefgrubs", "You can't go wrong with oink strips and cluckbeast ova.","I think it's important to try to eat lots of fart nibblets for fiber.","Do you like flavor discs?","Have you ever tried grubloaf?"], <String>["eat","food","grubs","nutrition","beast","meat","beefgrubs","grubloaf","grubsauce","flavor discs","cluckbeast ova"]));
        ret.add(new BullshitLine(<String>["Uh, trolls just kind of don't care about fashion.","Do you like my clothes?"], <String>["clothes","pants","shorts","fashion"]));

        return ret;
    }

    //ret.add(new BullshitLine(<String>[""], <String>[""]));
    static List<BullshitLine> denizenTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        //clothes, food, SBURB
        ret.add(new BullshitLine(<String>["Greetings. I have a Choice for you.","Salutations, Player. I am a Denizen.", "In SBURB, Denizens are part challenge and part ally.","Greetings, Player. Are you ready for a Quest?"]));
        ret.add(new BullshitLine(<String>["Do not grasp too strongly for power. The God Tiers are not for the hasty."], <String>["god","godtier","quest","questbed"]));
        ret.add(new BullshitLine(<String>["I do not understand the human concept of 'pants'."], <String>["clothes","pants","shirt"]));
        ret.add(new BullshitLine(<String>["Should you fail my Choice, I will eat you, Player."], <String>["food","meat","vore"]));

        return ret;
    }

    static List<BullshitLine> consortTalk(int seed) {
        List<BullshitLine> ret = <BullshitLine>[];
        //clothes, food, SBURB
        Random rand = new Random(seed);
        List<String> sounds = <String>["beep","ping","doop","schlub","rattle","fip","thwip","glub","nak"];
        String sound = rand.pickFrom(sounds);
        ret.add(new BullshitLine(<String>["${sound} ${sound} ${sound}","${sound} Hello!","I am a Secret Wizard! ${sound}!","${sound}! I don't get it!","Okay! ${sound}!","${sound}?"]));
        return ret;
    }



    static List<BullshitLine> SBURBTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        //clothes, food, SBURB
        ret.add(new BullshitLine(<String>["Huh, god tier pajamas are surprisingly comfortable.","Dream pajamas are such a weird concept.","You know, when I first started out being able to alchemize clothes was so cool, but now why even bother changing clothes..."], <String>["clothes","shorts","shopping","sburb","alchemy"]));
        ret.add(new BullshitLine(<String>["I really hate cake.","Alchemized food tastes so bad."], <String>["food","cake","gushers","alchemy","SBURB"]));
        ret.add(new BullshitLine(<String>["You ever done any alchemy?","Wow, you can make some broken shit with alchemy.","Do you use ${CharSheet.randomSpecibus()}kind","God my sylladex is such bullshit."], <String>["specibus","alchemy","sburb","sylladex","strife"]));
        ret.add(new BullshitLine(<String>["Man, my Land is absolute bullshit.","Are all denizens flaming assholes?","God, my consorts are so annoying."], <String>["quest","land","consort","denizen","bullshit","sburb"]));
        ret.add(new BullshitLine(<String>["Yeah, I'm not killing myself just to become immortal.","I hear that quest beds are how you take an epic nap?"], <String>["god tier","god","slab","quest bed","immortality","bed","nap","quest","sburb"]));
        ret.add(new BullshitLine(<String>["God, this SBURB game really is bullshit, you know?","Does this game even have a point?","I can't wait till I beat this game.","SBURB is the worst game of all time."], <String>["SBURB","SGRUB","game","land","denizen","sprite","specibus","sylladex","quest"]));

        return ret;
    }

    static List<BullshitLine> momTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        ret.add(new BullshitLine(<String>["What kind of food do you like to eat?","Sweetie, I'll show you a a killer recipe I have for a martini!","The occasional drink is perfectly healthy!","Would you like a wine cooler?","I swear if I eat another salad I will just puke."], <String>["food","eat","drinks","martini","alcohol","drunk","beer","wine","fruit","salads","wine cooler","drink"]));
        ret.add(new BullshitLine(<String>["I don't know why 'Mom Jeans' get such a bad rep. They're really comfortable.","You can pry my 'Mom Jeans' from my cold dead hands.","Do you need new pants?","We should go shopping for pants some time.","What kind of clothes do you like?"], <String>["jeans","pants","trousers","legs","tights","hose","jeggings","leg", "clothes", "shopping"]));
        return ret;
    }

    static List<BullshitLine> dadTalk() {
        List<BullshitLine> ret = <BullshitLine>[];
        ret.add(new BullshitLine(<String>["You can't go wrong with socks plus sandals.", "Cargo pants are so versitile.","I think I might need to go shopping some time.", "A perfectly well groomed man should own several suits for various occasions."], <String>["clothes", "sandals", "socks", "cargo", "shorts", "shorts","loafers","suits","pants", "cargo","cargo pants"]));
        ret.add(new BullshitLine(<String>["What kind of food do you like to eat?","The only food I eat is massive steaks.", "Can I get uhhhhhhh....burger?", "I am pretty sure you can put bacon on anything.","Would you like some cake?"], <String>["steak","food","meat","bacon","burger","cake","eat"]));
        return ret;
    }
}
