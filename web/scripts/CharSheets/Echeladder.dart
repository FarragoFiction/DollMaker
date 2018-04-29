import "package:DollLibCorrect/DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';

//echeladder has X text boxes for echeladder rank
//and a section for boonies earned.
//doll is on left.
/*

    write out text. 16 layers.
    ability to customize all colors in echeladder pallete.
    font color is inverse of bg color.
 */
class Echeladder extends CharSheet {
    int echeladderStartX = 300;
    int echeladderStartY = 0;
    //also add procedural ones l8r
    List<String> levels = <String>["BUFFER THAN KR","NIPPER CADET", "PESKY URCHIN", "BRAVESPROUT", "JUVESQUIRT", "RUMPUS BUSTER", "CHAMP-FRY", "ANKLEBITER", "CALLOUSED TENDERFOOT", "RASCALSPRAT", "GRITTY MIDGET", "BRITCHES RIPPER", "ALIEN URCHIN", "NESTING NEWB","SINGING SCURRYWORT","MUSICAL MOPPET","NERDY NOODLER","SCAMPERING SCIENTIST","MUSCLES HOARDER","BODY BOOSTER","PRATFALL PRIEST","BEAGLE PUSS DARTABOUT","APPRENTICE ARTIST","CULTURE BUCKAROO","BATTERBRAT","GRITTY GUARDIAN","FAKEY FAKE LOVER","FANTASTIC DREAMER","JUSTICE JUICER","BALANCE RUMBLER","TRIVIA SMARTYPANTS","NIGHTLY NABBER","QUESTING CUPID","ROMANCE EXPERT","FRIEND-TO-ALL","FRIEND COLLECTOR","ENEMY #1","JERKWAD JOURNEYER","SHAKY SHAKESPEARE","QUILL RUINER","HURRYWORTH HACKER","CLANKER CURMUDGEON","GREENTIKE","RIBBIT RUSTLER","FROG-WRANGLER","MARQUIS MCFLY","JUNIOR CLOCK BLOCKER","DEAD KID COLLECTOR","BOY SKYLARK","SODAJERK'S CONFIDANTE","MAN SKYLARK","APOCALYPSE HOW","REVELATION RUMBLER","PESSIMISM PILGRIM","FRIEND HOARDER YOUTH","HEMOGOBLIN","SOCIALIST BUTTERFLY","SHARKBAIT HEARTHROB","FEDORA FLEDGLING","PENCILWART PHYLACTERY","NIPPER-CADET","COIN-FLIPPER CONFIDANTE","TWO-FACED BUCKAROO","SHOWOFF SQUIRT","JUNGLEGYM SWASHBUCKLER","SUPERSTITIOUS SCURRYWART","KNOW-NOTHING ANKLEBITER","INKY BLACK SORROWMASTER","FISTICUFFSAFICTIONADO","MOPPET OF MADNESS","FLEDGLING HATTER","RAGAMUFFIN REVELER","GADABOUT PIPSQUEAK","BELIVER EXTRAORDINAIRE","DOCTOR FEELGOOD","BRUISE BUSTER","LODESTAR LIFER","BREACHES HEALER","ADHDLED YOUTH","LUCID DREAMER","LUCID DREAMER","QUESTING QUESTANT","LADABOUT LANCELOT","SIR SKULLDODGER","SEEING iDOG","PIPSQUEAK PROGNOSTICATOR","SCAMPERVIEWER 5000","SKAIA'S TOP IDOL","POPSTAR BOPPER","SONGSCUFFER","SKAIA'S TOP IDOL","POPSTAR BOPPER","SONGSCUFFER","SCURRYWART SERVANT","SAUCY PILGRIM","MADE OF SUCCESS","KNEEHIGH ROBINHOOD","DASHING DARTABOUT","COMMUNIST COMMANDER","APPRENTICE ANKLEBITER","JOURNEYING JUNIOR","OUTFOXED BUCKAROO","RUMPUS RUINER","HAMBURGLER YOUTH","PRISONBAIT","SERENE SCALLYWAG","MYSTICAL RUGMUFFIN","FAE FLEDGLING","PRINCE HARMING","ROYAL RUMBLER","DIGIT PRINCE","WESTWORD WORRYBITER","BUBBLETROUBLER","EYE OF GRINCH","WIZARDING TIKE","THE SORCERER'S SCURRYWART","FAMILIAR FRAYMOTTIFICTIONADO","4TH WALL AFICIONADO","CATACLYSM COMMANDER","AUTHOR","BOSTON SCREAMPIE","COOKIE OFFERER","FIRE FRIEND","MIDNIGHT BURNER","WRITER WATCHER","DIARY DEAREST","HERBAL ESSENCE","CHICKEN SEASONER","TOMEMASTER","SNOWMAN SAVIOR","NOBODY NOWHERE","NULLZILLA","KNEEHIGH ROBINHOOD","DASHING DARTABOUT","COMMUNIST COMMANDER","AMUSING AMATEUR","SPOTLIGHT POINTER","GREEK GOD","LAUGHING STOCKINGS","DELEGATION DELIVERER","LORDLING"];

    @override
    List<TextLayer> textLayers = new List<TextLayer>();

    TextLayer first;
    TextLayer second;
    TextLayer third;
    TextLayer fourth;
    TextLayer fifth;
    TextLayer six;
    TextLayer seven;
    TextLayer eight;
    TextLayer nine;
    TextLayer ten;
    TextLayer eleven;
    TextLayer twelve;
    TextLayer thirteen;
    TextLayer fourteen;
    TextLayer fifteen;
    TextLayer sixteen;

    Echeladder(Doll doll) : super(doll) {
        randomizePalette();
        initLevels();
        double x = echeladderStartX + 6.0;
        double y = echeladderStartY + 291.0;
        Random rand = new Random();
        int maxWidth = 180;
        int maxHeight = 14;
        textLayers.add(new TextLayer("one", rand.pickFrom(levels), x, y, fontSize: 14, maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("two", rand.pickFrom(levels), x, y, fontSize: 14, maxHeight: maxHeight,maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("three", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("four", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("five", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("six", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("seven", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("eight", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("nine", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("ten", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: maxWidth, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("eleven", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("twelve", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("thirteen", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("Fourteen", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("Fifteen", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));
        y += -17;
        textLayers.add(new TextLayer("Sixteen", rand.pickFrom(levels), x, y, fontSize: 14,maxHeight: maxHeight, maxWidth: 200, fontName: "Courier New", emphasis: "Bold", fontColor: ReferenceColours.BLACK));

        textLayers = new List<TextLayer>.from(textLayers.reversed);
    }

    void initLevels() {
        List<String> effects = <String>["asleep","legal","illegal","extra legal","ironic","ripe","angsting","shitty","disappointing","amazing","perfect","confused","poisoned","dead","alive", "audited", "insane", "immortal", "on fire","boring","missing","lost","litigated","deceitful","irrelevant","annoying","smelly","chaotic","trembling","afraid","beserk","vomiting","depressed","disappointing","unloved","apathetic","addicted","uncomfortable","boggling", "goaded", "enhanced", "murdered"];
        List<String> nouns =<String> ["Baby","Grub","Bro","Mom","royalty","Queen","guardian","parent","Dad","opponent","graveyard","card","monster","item","deed","feat","artifact","weapon","armor","shield","ring","mana","deck","creature","sword","legendary","legendary","god","meme","red mile", "ring of orbs no-fold","arm","mechanical bull","mystery","token","shrubbery","Blue Lady","gem","egg","coin","talisman", "turn", "head","goddamn mushroom"];
        List<String> verbs = <String>["imagine","tap","use","discard","draw","imbibe","create","devour","vore","scatter","shred","place","select","choose","levitate","burn","throw away","place","dominate","humiliate","oggle","auto-parry","be","wear","flip","fond","retrieve","throw","slay","defeat","become","grab","order","steal","smell","sample","taste","caress","fondle","placate","handle","pirouette","entrench","crumple","shatter","drop","farm","sign","pile","smash","resist","sip","understand","contemplate", "murder", "elevate", "enslave"];

        for(int i = 0; i<100; i++) {
            levels.add("${rand.pickFrom(effects).toUpperCase()} ${rand.pickFrom(nouns).toUpperCase()}");
            levels.add("${rand.pickFrom(verbs).toUpperCase()} ${rand.pickFrom(nouns).toUpperCase()}");
        }
    }

    @override
    int width = 500;
    @override
    int height = 300;

    @override
    int type = 3;

    Palette paletteToReplace = new EcheladderPalette()
        ..border = '#4a92f7'
        ..first = '#8ff74a'
        ..second = '#ba1212'
        ..third = '#ffffee'
        ..fourth = '#f0ff00'
        ..fifth = '#9c00ff'
        ..six = '#2b6ade'
        ..seven = '#003614'
        ..eight = '#f8e69f'
        ..nine = '#0000ff'
        ..ten = '#eaeaea'
        ..eleven = '#ff9600'
        ..twelve = '#581212'
        ..thirteen = '#ffa6ac'
        ..fourteen = '#1f7636'
        ..fifteen = '#ffe1fc'
        ..sixteen = '#fcff00';


    Palette palette = new EcheladderPalette()
        ..border = '#444444'
        ..first = '#000000'
        ..second = '#000000'
        ..third = '#000000'
        ..fourth = '#000000'
        ..fifth = '#000000'
        ..six = '#000000'
        ..seven = '#000000'
        ..eight = '#000000'
        ..nine = '#000000'
        ..ten = '#000000'
        ..eleven = '#000000'
        ..twelve = '#000000'
        ..thirteen = '#000000'
        ..fourteen = '#000000'
        ..fifteen = '#000000'
        ..sixteen = '#000000';


    // TODO: implement barLayers
    @override
    List<BarLayer> get barLayers => [];

    @override
    Element makeForm() {
        Element ret = new DivElement();
        ret.className = "cardForm";
        ret.append(makeDollLoader());
        ret.append(makeHideButton());
        ret.append(makeTextLoader());
        ret.append(makePaletteStuff());
        ret.append(makeSaveButton());
        return ret;
    }

    Element makePaletteStuff() {
        Element container = new DivElement();
        container.style.padding = "10px";
        List<String> names = new List<String>.from(palette.names);
        //don't do for loop on keys, order is important
        container.append(makeColorPicker(EcheladderPalette._BORDER, palette[EcheladderPalette._BORDER]));
        container.append(makeColorPicker(EcheladderPalette._SIXTEEN, palette[EcheladderPalette._SIXTEEN]));
        container.append(makeColorPicker(EcheladderPalette._FIFTEEN, palette[EcheladderPalette._FIFTEEN]));
        container.append(makeColorPicker(EcheladderPalette._FOURTEEN, palette[EcheladderPalette._FOURTEEN]));
        container.append(makeColorPicker(EcheladderPalette._THIRTEEN, palette[EcheladderPalette._THIRTEEN]));
        container.append(makeColorPicker(EcheladderPalette._TWELVE, palette[EcheladderPalette._TWELVE]));
        container.append(makeColorPicker(EcheladderPalette._ELEVEN, palette[EcheladderPalette._ELEVEN]));
        container.append(makeColorPicker(EcheladderPalette._TEN, palette[EcheladderPalette._TEN]));
        container.append(makeColorPicker(EcheladderPalette._NINE, palette[EcheladderPalette._NINE]));
        container.append(makeColorPicker(EcheladderPalette._EIGHT, palette[EcheladderPalette._EIGHT]));
        container.append(makeColorPicker(EcheladderPalette._SEVEN, palette[EcheladderPalette._SEVEN]));
        container.append(makeColorPicker(EcheladderPalette._SIX, palette[EcheladderPalette._SIX]));
        container.append(makeColorPicker(EcheladderPalette._FIFTH, palette[EcheladderPalette._FIFTH]));
        container.append(makeColorPicker(EcheladderPalette._FOURTH, palette[EcheladderPalette._FOURTH]));
        container.append(makeColorPicker(EcheladderPalette._THIRD, palette[EcheladderPalette._THIRD]));
        container.append(makeColorPicker(EcheladderPalette._SECOND, palette[EcheladderPalette._SECOND]));
        container.append(makeColorPicker(EcheladderPalette._FIRST, palette[EcheladderPalette._FIRST]));


        return container;
    }

    Element makeColorPicker(String name, Colour color) {
        Element container = new DivElement();
        InputElement colorPicker = new InputElement();
        colorPicker.type = "color";
        colorPicker.value = color.toStyleString();
        colorPicker.onChange.listen((Event e) {
            color = new Colour.fromStyleString(colorPicker.value);
            palette.add(name, color, true);
            draw();
        });
        container.append(colorPicker);
        SpanElement text = new SpanElement();
        text.text = " $name";
        container.append(text);
        return container;
    }


    //for each color in pallete, make font layer have invert color
    void invertFont() {
        EcheladderPalette p = palette as EcheladderPalette;
        textLayers[0].fontColor = invertColour(p.sixteen);
        textLayers[1].fontColor = invertColour(p.fifteen);
        textLayers[2].fontColor = invertColour(p.fourteen);
        textLayers[3].fontColor = invertColour(p.thirteen);
        textLayers[4].fontColor = invertColour(p.twelve);
        textLayers[5].fontColor = invertColour(p.eleven);
        textLayers[6].fontColor = invertColour(p.ten);
        textLayers[7].fontColor = invertColour(p.nine);
        textLayers[8].fontColor = invertColour(p.eight);
        textLayers[9].fontColor = invertColour(p.seven);
        textLayers[10].fontColor = invertColour(p.six);
        textLayers[11].fontColor = invertColour(p.fifth);
        textLayers[12].fontColor = invertColour(p.fourth);
        textLayers[13].fontColor = invertColour(p.third);
        textLayers[14].fontColor = invertColour(p.second);
        textLayers[15].fontColor = invertColour(p.first);
    }

    Colour invertColour(Colour color) {
        Colour ret = new Colour(255 -color.red, 255-color.green, 255-color.blue);
        return ret;
    }


    void randomizePalette() {
        Random rand = new Random();
        EcheladderPalette p = new EcheladderPalette();
        for (String key in palette.names) {
            Colour newColor = new Colour(rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
            newColor.setHSV(newColor.hue, rand.nextDouble(0.5)+0.5, newColor.value);
            p.add(key, newColor, true);
        }
        if(doll is HomestuckDoll) {
            HomestuckPalette h = doll.palette as HomestuckPalette;
            p.border = h.aspect_light;
        }
        for (String key in p.names) {
            palette.add(key, p[key], true);
        }
    }

    @override
    Future<Null> draw([Element container]) async {
        invertFont();
        if(canvas == null) {
            print("making new canvas");
            canvas = new CanvasElement(width: width, height: height);
            canvas.className = "cardCanvas";
        }
        if(container != null) {
            print("appending canvas to container $container");
            container.append(canvas);
        }
        canvas.context2D.clearRect(0, 0, width, height);

        CanvasElement sheetElement = await drawSheetTemplate();
        Renderer.swapPalette(sheetElement, paletteToReplace, palette);
        canvas.context2D.drawImage(sheetElement, echeladderStartX, echeladderStartY);


        CanvasElement textCanvas = await drawText();
        canvas.context2D.drawImage(textCanvas, 0, 0);

        CanvasElement dollElement = await drawDoll(doll, 200, 200);
        if (!hideDoll) canvas.context2D.drawImage(dollElement, 75, 100);
        syncSaveLink();
        //return canvas;
    }
}


class EcheladderPalette extends Palette {
    static String _BORDER = "border";
    static String _FIRST = "one";
    static String _SECOND = "two";
    static String _THIRD = "three";
    static String _FOURTH = "four";
    static String _FIFTH = "five";
    static String _SIX = "six";
    static String _SEVEN = "seven";
    static String _EIGHT = "eight";
    static String _NINE = "nine";
    static String _TEN = "ten";
    static String _ELEVEN = "eleven";
    static String _TWELVE = "twelve";
    static String _THIRTEEN = "thirteen";
    static String _FOURTEEN = "fourteen";
    static String _FIFTEEN = "fifteen";
    static String _SIXTEEN = "sixteen";

    static Colour _handleInput(Object input) {
        if (input is Colour) {
            return input;
        }
        if (input is int) {
            return new Colour.fromHex(input, input
                .toRadixString(16)
                .padLeft(6, "0")
                .length > 6);
        }
        if (input is String) {
            if (input.startsWith("#")) {
                return new Colour.fromStyleString(input);
            } else {
                return new Colour.fromHexString(input);
            }
        }
        throw "Invalid AspectPalette input: colour must be a Colour object, a valid colour int, or valid hex string (with or without leading #)";
    }

    Colour get text => this[_BORDER];

    Colour get border => this[_BORDER];

    void set border(dynamic c) => this.add(_BORDER, _handleInput(c), true);

    Colour get first => this[_FIRST];

    void set first(dynamic c) => this.add(_FIRST, _handleInput(c), true);

    Colour get second => this[_SECOND];

    void set second(dynamic c) => this.add(_SECOND, _handleInput(c), true);

    Colour get third => this[_THIRD];

    void set third(dynamic c) => this.add(_THIRD, _handleInput(c), true);

    Colour get fourth => this[_FOURTH];

    void set fourth(dynamic c) => this.add(_FOURTH, _handleInput(c), true);

    Colour get fifth => this[_FIFTH];

    void set fifth(dynamic c) => this.add(_FIFTH, _handleInput(c), true);

    Colour get six => this[_SIX];

    void set six(dynamic c) => this.add(_SIX, _handleInput(c), true);

    Colour get seven => this[_SEVEN];

    void set seven(dynamic c) => this.add(_SEVEN, _handleInput(c), true);

    Colour get eight => this[_EIGHT];

    void set eight(dynamic c) => this.add(_EIGHT, _handleInput(c), true);

    Colour get nine => this[_NINE];

    void set nine(dynamic c) => this.add(_NINE, _handleInput(c), true);

    Colour get ten => this[_TEN];

    void set ten(dynamic c) => this.add(_TEN, _handleInput(c), true);

    Colour get eleven => this[_ELEVEN];

    void set eleven(dynamic c) => this.add(_ELEVEN, _handleInput(c), true);

    Colour get twelve => this[_TWELVE];

    void set twelve(dynamic c) => this.add(_TWELVE, _handleInput(c), true);

    Colour get thirteen => this[_THIRTEEN];

    void set thirteen(dynamic c) => this.add(_THIRTEEN, _handleInput(c), true);

    Colour get fourteen => this[_FOURTEEN];

    void set fourteen(dynamic c) => this.add(_FOURTEEN, _handleInput(c), true);

    Colour get fifteen => this[_FIFTEEN];

    void set fifteen(dynamic c) => this.add(_FIFTEEN, _handleInput(c), true);

    Colour get sixteen => this[_SIXTEEN];

    void set sixteen(dynamic c) => this.add(_SIXTEEN, _handleInput(c), true);


}