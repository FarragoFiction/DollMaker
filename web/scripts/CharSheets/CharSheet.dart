import "package:DollLibCorrect/DollRenderer.dart";
import 'dart:async';
import 'dart:html';
import "BarLayer.dart";
/*
In addition to providing a way for ppl to share and visualize their chars,
I could use variations on this to set up chars for a particular sim.

Would need to be able to import a char sheet in it's entiretiy to a thing.
Or at least stats.
TODO: Worry about this in the future.
 */
abstract class CharSheet {
    //actual image name of sheet should be type num.
    bool hideDoll = false;
    String folder = "images/CharSheets";
    String fontName = "Courier New";
    String emphasis = "bold";
    int fontSize = 14;
    int type = 0;
    int width = 0;
    int height = 0;
    Random rand;
    Doll doll;
    List<TextLayer> get textLayers;
    List<BarLayer> get barLayers;
    CanvasElement canvas;
    Colour tint;
    AnchorElement saveLink;

    CharSheet(Doll this.doll) {
        rand = new Random();
        tint = new Colour(rand.nextInt(255),rand.nextInt(255), rand.nextInt(255));
    }


    Element makeDollLoader() {
        Element ret = new DivElement();
        ret.setInnerHtml("Doll URL: ");
        TextAreaElement dollArea = new TextAreaElement();
        dollArea.value = doll.toDataBytesX();
        ButtonElement dollButton = new ButtonElement();
        dollButton.setInnerHtml("Load Doll");
        ret.append(dollArea);
        ret.append(dollButton);

        dollButton.onClick.listen((Event e) {
            print("Trying to load doll");
            doll = Doll.loadSpecificDoll(dollArea.value);
            print("trying to draw loaded doll");
            draw();
        });
        return ret;
    }

    Element makeTextLoader() {
        Element ret = new DivElement();

        ButtonElement button = new ButtonElement();
        button.setInnerHtml("Load Text");

        button.onClick.listen((Event e) {
            print("redrawing after loading text.");
            draw();
        });
        ret.append(button);

        for(BarLayer bl in barLayers) {
            ret.append(bl.element);
        }

        for(TextLayer tl in textLayers) {
            ret.append(tl.element);
        }



        button = new ButtonElement();
        button.setInnerHtml("Load Text");

        button.onClick.listen((Event e) {
            print("redrawing after loading text.");
            draw();
        });

        ret.append(button);
        return ret;
    }

    Future<CanvasElement>  drawDoll(Doll doll, int w, int h) async {
        CanvasElement monsterElement = new CanvasElement(width:w, height: h);
        if(hideDoll) return monsterElement;
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await Renderer.drawDoll(dollCanvas, doll);
        //Renderer.drawBG(monsterElement, ReferenceColours.RED, ReferenceColours.WHITE);

        dollCanvas = Renderer.cropToVisible(dollCanvas);

        Renderer.drawToFitCentered(monsterElement, dollCanvas);
        return monsterElement;
    }

    Future<CanvasElement>  drawText() async {
        CanvasElement tmp = new CanvasElement(width: width, height: height);
        CanvasRenderingContext2D ctx = tmp.context2D;
        for(TextLayer textLayer in textLayers) {
            ctx.fillStyle = textLayer.fillStyle;
            ctx.font = textLayer.font;
            int savedSize = textLayer.fontSize;
            //ctx.fillText(textLayer.text, textLayer.topLeftX, textLayer.topLeftY);
            int numLines = Renderer.simulateWrapTextToGetFontSize(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth, textLayer.maxHeight);
            print(numLines);
            if((numLines * textLayer.fontSize)>textLayer.maxHeight) {
                print("shrinking needed");
                textLayer.fontSize = (textLayer.maxHeight/numLines).floor();
            }
            ctx.font = textLayer.font;
            textLayer.fontSize = savedSize; //restore
            Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
            //Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
        }

        CanvasElement barCanvas = new CanvasElement(width: width, height: height);

        for(BarLayer barLayer in barLayers) {
            //print("Going to render ${barLayer.imgLoc}");
            ImageElement image = await Loader.getResource((barLayer.imgLoc));
            //print("image is $image, ${barLayer.topLeftX},${barLayer.topLeftY}");
            barCanvas.context2D.drawImage(image, barLayer.topLeftX, barLayer.topLeftY);
        }
        Palette p = new CharSheetPalette()
            ..aspect_light = tint;
        Renderer.swapPalette(barCanvas,ReferenceColours.CHAR_SHEET_PALETTE, p);
        tmp.context2D.drawImage(barCanvas,0,0);
        return tmp;
    }



    Element makeTintSelector() {
        Element ret = new DivElement();
        ret.setInnerHtml("Color: ");
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = tint.toStyleString();
        colorPicker.onChange.listen((Event e) {
            tint = new Colour.fromStyleString(colorPicker.value);
            draw();
        });

        ret.append(colorPicker);
        return ret;
    }

    Element makeHideButton() {
        Element ret = new DivElement();
        CheckboxInputElement check = new CheckboxInputElement();
        ret.text = "Show Doll";
        check.checked = !hideDoll;
        ret.append(check);
        check.onChange.listen((e) {
            hideDoll = !check.checked;
            draw();
        });
        return ret;
    }

    //draws a text area for each text element, one for the doll, and a color picker for tint.
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";
        ret.append(makeDollLoader());
        ret.append(makeHideButton());
        ret.append(makeTintSelector());
        ret.append(makeTextLoader());
        ret.append(makeSaveButton());
        return ret;
    }

    Future<CanvasElement> drawSheetTemplate() async{
        CanvasElement cardElement = new CanvasElement(width: width, height: height);
        await Renderer.drawWhateverFuture(cardElement, "$folder/$type.png");
        return cardElement;
    }

    Element makeSaveButton() {
        Element ret = new DivElement();
        ret.className = "paddingTop";
        if(saveLink == null) saveLink = new AnchorElement();
        saveLink.href = canvas.toDataUrl();
        saveLink.target = "_blank";
        saveLink.setInnerHtml("Download PNG?");
        ret.append(saveLink);
        return ret;
    }




    Future<Null> draw([Element container]) async {
        throw("ABSTRACT DOESNT DO THIS");
    }

    String handleForDoll() {
        List<String> firstNames = <String>["ecto","pants","tentacle","garden","turntech","tipsy","golgothas","ghosty","gutsy","apocalypse","adios","twin","carcino","arsenic","grim","gallows","arachnids","centaurs","terminally","jaded","recursive","caligulas","cuttlefish","manic","aspiring","karmic","woo","insufferable","no","dilletant","bourbon","jaunty","faraway","fantastical","jolly","jilted","farrago","reclaimed","authorial","resting","rioting","blazing","frosty","callous","cynical","careful","magestic","proud","friendly","timaeus","uranian","undying"];
        List<String> lastNames = <String>["Biologist","Therapist","Godhead","Terror","Trickster","Gnostic","Gnostalgic","Gumshoe","Arisen","Toreador","Armageddons","Geneticist","Catnip","Auxiliatrix","Calibrator","Grip","Testicle","Capricious","Aquarium","Culler","Reseracher","Slacker","Insomniac","Watcher","Retribution","Mod","Oracle","Body","Mathematician","Recluse","Cephalopd","Squid","Fairy","Fiction","Author","Bot","Majesty","Minion","King","Queen","Fan","Scholar","Athelete","Lawyer","Dragon","Beast","Testified","Umbra","Umbrage","Frog","Turtle","Player","Gamer","Knitter","Crafter","Dreamer","Seeker"];
        return "${rand.pickFrom(firstNames)}${rand.pickFrom(lastNames)}";

    }

    String getDollType() {
        if(doll is HomestuckTrollDoll) return "Troll";
        if(doll is HomestuckDoll) return "Human";
        if(doll is ConsortDoll) return "Consort";
        if(doll is DenizenDoll) return "Denizen";
        return "???";
    }

    String guardianForDoll(String name) {
        if(doll is HomestuckTrollDoll) return trollLusus();
        if(doll is HomestuckDoll) return humanRelative(name);
        if(doll is DadDoll || doll is MomDoll) return humanRelative(name);
        return randomAsFuckName();
    }
    String nameForDoll() {
        if(doll is HomestuckTrollDoll) return trollName();
        if(doll is HomestuckDoll) return humanName();
        if(doll is DadDoll) return dadName();
        if(doll is BroDoll) return broName();
        if(doll is MomDoll) return momName();
        return randomAsFuckName();
    }

    String trollLusus() {
        List<String> firstNames = <String>["Ram","Nut","Thief","March","Feather","Slither","Claw","Tooth","Swim","Meow","Woof","Sand","Mud","Water","Hoof","Muscle","Rage","Dig","Waddle","Run"];
        List<String> lastNames = <String>["Creature","Beast","Bug"];
        return "${rand.pickFrom(firstNames)} ${rand.pickFrom(lastNames)}";
    }

    String dadName() {
        return "${"Dad"} ${humanLastName()}";
    }

    String broName() {
        return "${"Bro"} ${humanLastName()}";
    }

    String momName() {
        return "${"Mom"} ${humanLastName()}";
    }

    String humanRelative(String name) {
        List<String> titles = <String>["Mom","Dad","Pa","Grandpa","Grandma","Mother","Father","Bro","Sis","Aunt","Uncle","Cousin","Poppop", "Pop","Daddy","Mommy","Aunty"];
        List<String> names = name.split(" ");
        return "${rand.pickFrom(titles)} ${names[1]}";
    }


    String randomClass() {
        List<String> ret = <String>["Knight","Seer","Bard","Heir","Maid","Rogue","Page","Thief","Sylph","Witch","Prince","Mage"];
        return rand.pickFrom(ret);
    }

    //just random shit. 4 letters, then 6 letters.
    String randomAspect() {
        List<String> ret = <String>["Blood","Mind","Rage","Void","Time","Heart","Breath","Light","Space","Life","Hope","Doom"];
        return rand.pickFrom(ret);
    }

    String humanLastName() {
        List<String> lastNames = <String>["English","Cipher","Egbert","Lalonde","Harley","Crocker","Roberts","Brockman","Stephenson","Fox","McClure","Baker","Wilson","Parker","White","Noir","Roberts","Smith","Smithson","Jackson","Bother","Jamison","Williams","Johnson","Anderson","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Thomas","Harris","Martin","Thompson","Garcia","Martinez","Rodriguez","Clark","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Carson","Nelson","Gonzalez","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Evans","Edwards","Stewart","Cook","Murphy"];
        return rand.pickFrom(lastNames);

    }

    //just random shit. 4 letters, then 6 letters.
     String humanName() {
         List<String> firstNames = <String>["John","Dave","Fred","Rose","Dirk","Ruby","Roxy","Romy","Jade","Jane","Jake","Jill","Jack","Dale","Burt","Bess","Beth","Jimm","Joey","Jude","Jann","Jenn","Geof", "Andy","Amii","Chris","Abby", "Abel","Adam","Alex","Anna","Bill","Brad","Buck","Carl","Chad","Cody","Dick","Rich","Dora","Ella","Evan","Emil","Eric","Erin","Finn","Glen","Greg","Hank","Hugo","Ivan","Jean","Josh","Kent","Kyle","Lars","Levi","Lois","Lola","Luke","Mark","Mary","Neal","Nora","Opal","Otto","Pete","Paul","Rosa","Ruth","Ryan","Scot","Sean","Skip","Toby","Todd","Tony","Troy","Vern","Vick","Wade","Walt","Will","Zack","Zeke","Zoey","Phil"];
        return "${rand.pickFrom(firstNames)} ${humanLastName()}";
    }

    //just generate random vaguely pronouncable combos of 6 letters.
     String trollName()
    {
        WeightedList<String> letters = new WeightedList<String>();
        letters.addAll(["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w"]);
        letters.add("x",0.5);
        letters.add("y",0.5);
        letters.add("z",0.5);
        WeightedList allLetters = new WeightedList.from(letters);

        List<String> vowels = <String>["a","e","i","o","u"];
        for(String v in vowels) {
            allLetters.add(v, 20.0);
        }
        //sets of two
        WeightedList<String> sounds = new WeightedList<String>();
        sounds.addAll(<String>["th","ck","sr","ch","ph","ss","st","ng","sr","zh","sh"]);
        for(String first in letters) {
            for(String second in vowels) {
                sounds.add("$first$second");
                sounds.add("$second$first", 0.5); //less common to start with vowel
            }
        }
        String ret = "";
        //troll name is guaranted to have a vowel p frequently so it's pronuncable. small chance of double vowel.
        for(int i = 0; i<3; i++) {
            ret += "${rand.pickFrom(sounds)}";
        }
        //last name
        ret += " ";
        for(int i = 0; i<3; i++) {
            ret += "${rand.pickFrom(sounds)}";
        }

        return capitilizeEachWord(ret);
    }

    String capitilizeString(String s) {
        return "${s[0].toUpperCase()}${s.substring(1)}";
    }

    String capitilizeEachWord(String s) {
        List<String> words =  s.split(" ");
        String ret = "";
        for(String word in words) {
            ret += " ${capitilizeString(word)}";
        }
        return ret;
    }


    String randomAsFuckName() {
        List<String> titles = <String> ["Captain","Baron","The Esteemed","Mr.","Mrs.","Mdms.","Count","Countess","Clerk","President","Pounceler","Counciler","Minister","Ambassador","Admiral", "Rear Admiral","Commander","Dr.","Sir"];
        List<String> firstNames = <String>["Bubbles","Nic","Lil","Liv","Charles","Meowsers","Casey","Fred","Kid","Meowgon","Fluffy","Meredith","Bill","Ted","Frank","Flan","Squeezykins","Spot","Squeakems","Hissy","Scaley","Glubglub","Mutie","Clattersworth","Bonebone","Nibbles","Fossilbee","Skulligan","Jack","Nigel","Dazzle","Fancy","Pounce"];
        List<String> lastNames = <String>["Cage","Sebastion","Taylor","Dutton","von Wigglebottom","von Salamancer","Savage","Rock","Spangler","Fluffybutton","the Third, esquire.","S Preston","Logan","the Shippest","Clowder","Squeezykins","Boi","Oldington the Third","Malone","Ribs","Noir","Sandwich"];
        double randNum = rand.nextDouble();
        if(randNum > .6) {
            return "${rand.pickFrom(titles)} ${rand.pickFrom(firstNames)} ${rand.pickFrom(lastNames)}";

        }else if (randNum > .3) {
            return "${rand.pickFrom(titles)} ${rand.pickFrom(lastNames)}";
        }else {
            return "${rand.pickFrom(firstNames)} ${rand.pickFrom(lastNames)}";
        }
    }


}