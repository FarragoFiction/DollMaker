//https://swirlygerm-art.tumblr.com/post/167621990417/hey-wanna-make-a-trollsona-for-hiveswap-like-how
import "package:DollLibCorrect/DollRenderer.dart";
import "package:TextEngine/TextEngine.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';

class TrollCallSheet extends CharSheet {

    TextEngine textEngine;
    @override
    int width = 728;
    @override
    int height = 781;

    @override
    int type = 2;

    TextLayer name;
    TextLayer fact1;
    TextLayer fact2;
    TextLayer fact3;


    TrollCallSheet(Doll doll, List<Doll>possibleDolls) : super(doll, possibleDolls) {
        tint = doll.associatedColor;

    }

    Future<Null> setup() async {

        Colour color = new Colour.from(tint)..setHSV(tint.hue, 0.2, 1.0 );
        if(doll.dollName == doll.name || doll.dollName == null || doll.dollName.isEmpty) {
            await doll.setNameFromEngine();
        }
        name = new TextLayer("Name",await doll.dollName.toUpperCase(),345.0,470.0, fontSize: 60, maxWidth: 100, fontName: "trollcall", emphasis: emphasis,fontColor: color);
        fact1 = new TextLayer("Fact1","",370.0,130.0, fontSize: 25, maxWidth: 220, fontName: "trollcall", emphasis: emphasis,fontColor: color);
        fact2 = new TextLayer("Fact2","",370.0,210.0, fontSize: 25, maxWidth: 220, fontName: "trollcall", emphasis: emphasis,fontColor:color);
        fact3 = new TextLayer("Fact3","",370.0,290.0, fontSize: 25, maxWidth: 220, fontName: "trollcall", emphasis: emphasis,fontColor: color);
        await setFacts();
    }

    Future<Null> setFacts() async {
        if(textEngine != null) textEngine.setSeed(doll.seed);

        fact1.text = await randomFact();
        fact2.text = await randomFact();
        fact3.text = await randomFact();
    }


    Future<CanvasElement> drawSymbol() async {
        CanvasElement cardElement = new CanvasElement(width: width, height: height);

        bool foundSymbol = false;
        for (SpriteLayer layer in doll.renderingOrderLayers) {
            if (layer.imgNameBase.contains("Symbol")) {
                // print("found a symbol ${layer.imgLocation}");
                //if it's zero it tries to draw something clear to the end product and it messes up online???
                //but only firefox, chrome is fine
                if(layer.imgNumber != 0) {
                    foundSymbol = true;
                    await Renderer.drawWhateverFuture(cardElement, layer.imgLocation);
                    Renderer.swapPalette(cardElement, doll.paletteSource, doll.palette);
                }
            }
        }
        if (foundSymbol) {
            cardElement = Renderer.cropToVisible(cardElement);
            //Renderer.drawBG(cardElement, ReferenceColours.RED, ReferenceColours.RED);
            CanvasElement ret = new CanvasElement(width: 90, height: 90);

            //print("after cropping card element is ${cardElement.width} by ${cardElement.height}");

            Renderer.drawToFitCentered(ret, cardElement);
            return ret;
        }
        return null;
    }



    //empty
    List<BarLayer> barLayers = new List<BarLayer>();


    @override
    List<TextLayer> get textLayers => <TextLayer>[name,fact1,fact2,fact3]; //placeholder


    Future<String> randomFact() async{
        if(textEngine == null) {
            textEngine = new TextEngine();
            await textEngine.loadList("trollcall");
            textEngine.setSeed(doll.seed);
        }

        return "${textEngine.phrase("TrollCall")}";
    }

    //obsessed with nouns. verbs a noun every single day. JR did this
    String randomFactOld() {
        List<String> verbs = <String>["imagine","tap","use","discard","draw","imbibe","create","devour","vore","scatter","shred","place","select","choose","levitate","burn","throw away","place","dominate","humiliate","oggle","auto-parry","be","wear","flip","fondly regard","retrieve","throw","slay","defeat","become","grab","order","steal","smell","sample","taste","caress","fondle","placate","handle","pirouette","entrench","crumple","shatter","drop","farm","sign","pile","smash","resist","sip","understand","contemplate", "murder", "elevate", "enslave"];
        List<String> nouns =<String> ["Bro","Mom","royalty","Queen","guardian","parent","Dad","opponent","graveyard","irrelevancy corner","card","monster","item","deed","feat","artifact","weapon","armor","shield","ring","mana","deck","creature","sword","legendary artifact","legendary weapon","god","meme","red mile", "ring of orbs no-fold","arm","mechanical bull","mystery","token","shrubbery","Blue Lady","gem","egg","coin","talisman", "turn", "head","goddamn mushroom"];
        List<String> effects = <String>["legal","so totally illegal","illegal","extra legal","ironic","ripe","angsting","shitty","disappointing","amazing","perfect","confused","poisoned","dead","alive", "audited", "insane","unconditionally immortal", "immortal", "on fire","boring","missing","lost","litigated","deceitful","irrelevant","a lost cause","annoying","smelly","chaotic","trembling","afraid","beserk","vomiting","depressed","disappointing","in a fandom","unloved","apathetic","addicted","uncomfortable","boggling", "goaded", "enhanced", "murdered","asleep"];
        List<String> quadrants = <String>["moirail","kismesis","matesprit","auspistice"];
        Random rand = new Random();

        String noun = rand.pickFrom(nouns);
        String verb = rand.pickFrom(verbs);
        String effect = rand.pickFrom(effects);
        String quadmate = rand.pickFrom(quadrants);

        List<String> templates = <String>["Is part $noun","Master of the $noun","Practices ${verb}ing the ${noun} every day","Been in detention their whole life","Imitation $noun bracelet","sweet ${noun}s","13 ${noun}s at last count","Sleeps once a week","Does not $verb $noun","Aspiring $noun","Always reblogs $noun posts","Keeps hydrated","Omnicidal except towards ${noun}s","Has a soft spot for $effect ${noun}s","Really into ${noun}s","Probably $effect when you aren't looking","Actually a sweetheart","Ask them about $effect ${noun}s if you can spare an hour","is currently $effect","Never ${verb}s. Ever.","Has two ${quadmate}s.","Is a good $quadmate","Is a bad $quadmate"];
        templates.addAll(<String>["Is part of a rebellion.","Has ${verb}ed 13 easter eggs. Yes, even the $effect one.","Is a close personal friend of the Heiress.","Is $effect.","Tries to hide how $effect they are.","${verb}s once a week","Owns a small $noun","Thinks everybody is $effect","Thinks all $effect ${noun}s should be arrested","Never $effect","Always $effect","Wakes up early to $verb ${noun}s","Thinks you can never have too much ${noun}s","Collects antique ${noun}s","Addicted to love.","Has filled all their quadrants.","Has ${verb}ed all their quadrantmates.","Tries to push their $quadmate to $verb ${noun}s"]);
        return "* ${rand.pickFrom(templates)}";
    }



    @override
    Future<CanvasElement>  drawText() async {
        Colour color = new Colour.from(tint)..setHSV(tint.hue, 0.2, 1.0 );

        CanvasElement tmp = new CanvasElement(width: width, height: height);
        CanvasRenderingContext2D ctx = tmp.context2D;
        for(TextLayer textLayer in textLayers) {
            textLayer.fontColor = color;
            ctx.fillStyle = textLayer.fillStyle;
            ctx.font = textLayer.font;
            Renderer.wrap_text(ctx,textLayer.text,textLayer.topLeftX,textLayer.topLeftY,textLayer.fontSize,textLayer.maxWidth,"left");
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




    @override
    Future<Null> draw([Element container]) async {
        if(canvas == null) {
            print("making new canvas");
            canvas = new CanvasElement(width: width, height: height);
            canvas.className = "cardCanvas";
        }
        //if i just loaded the doll, change tint, otherwise keep it(could be users)
        if(dollDirty) {
            tint = doll.associatedColor;
            setFacts();
        }
        if(container != null) {
            print("appending canvas to container $container");
            container.append(canvas);
        }

        canvas.context2D.clearRect(0,0,width,height);

        CanvasElement sheetElement = await drawSheetTemplate();
        Renderer.swapColors(sheetElement, tint);
        canvas.context2D.drawImage(sheetElement, 0, 0);

        CanvasElement textCanvas = await drawText();
        canvas.context2D.drawImage(textCanvas, 0, 0);

        CanvasElement symbolElement = await drawSymbol();
        if(symbolElement != null) canvas.context2D.drawImage(symbolElement,459, 610);

        CanvasElement dollElement = await drawDoll(doll,300,450);
        if(!hideDoll)canvas.context2D.drawImage(dollElement,50, 275);
        syncSaveLink();
    }
}