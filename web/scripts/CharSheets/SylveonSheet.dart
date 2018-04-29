import "package:DollLibCorrect/DollRenderer.dart";
import "CharSheet.dart";
import 'dart:async';
import "BarLayer.dart";
import 'dart:html';

/*
Based on the char sheet by Sylveon on discord
https://linkedsylveon.tumblr.com/
 */

class SylveonSheet extends CharSheet {

    @override
    int width = 1000;
    @override

    int height = 825;

    @override
    int type = 1;

    //but what if you don't want STRANGTH?
    BarLayer strength;
    BarLayer stamina;
    BarLayer agility;
    BarLayer perception;
    BarLayer accuracy;
    BarLayer stealth;
    BarLayer intelligence;
    BarLayer imagination;
    BarLayer psionics;
    BarLayer occultLore;
    BarLayer tactics;
    BarLayer weaponSkill;
    BarLayer persuasion;
    BarLayer willpower;
    BarLayer empathy;
    BarLayer intimidation;
    BarLayer expression;
    BarLayer performance;
    CheckLayer prospit;
    CheckLayer derse;

    TextLayer name;
    TextLayer age;
    TextLayer guardian;
    TextLayer owner;
    TextLayer handle;
    TextLayer heightLayer;
    TextLayer weight;
    TextLayer fetchModus;
    TextLayer species;
    TextLayer textColor;
    TextLayer gender;
    TextLayer specibus;
    TextLayer ancestor;
    TextLayer weightLayer;
    TextLayer heart;
    TextLayer diamonds;
    TextLayer clubs;
    TextLayer spades;
    TextLayer className;
    TextLayer aspect;
    TextLayer spriteName;
    TextLayer proto1;
    TextLayer proto2;
    TextLayer consorts;
    TextLayer denizen;
    TextLayer land;
    //TODO checkboxes for prospit and derse (can pick both)
    //TODO drop range selectors for stats

    //want to be able to get layers independantly
  @override
  List<TextLayer> get textLayers => <TextLayer>[name,age,guardian,owner,handle, heightLayer, weightLayer,fetchModus,species,textColor,gender,specibus,ancestor,heart, spades, diamonds, clubs,className, aspect,proto1, spriteName,proto2,consorts,denizen,land];
  List<BarLayer> get barLayers => <BarLayer>[strength,stamina,agility,perception,accuracy,stealth,intelligence,imagination,psionics,occultLore,tactics,weaponSkill,persuasion,willpower,empathy,intimidation,expression,performance,prospit,derse];

  SylveonSheet(Doll doll):super(doll) {
        double lineY = 70.0;
        name = new TextLayer("Name",nameForDoll(),60.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);
        age = new TextLayer("Age","${rand.nextInt(7)+3}",350.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        guardian = new TextLayer("Guardian",guardianForDoll(name.text),540.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);
        owner = new TextLayer("creator","AuthorBot",810.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);

        lineY = 86.0;
        handle = new TextLayer("Handle",handleForDoll(),70.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        heightLayer = new TextLayer("Height","???",342.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        weightLayer = new TextLayer("Weight","???",413.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        fetchModus = new TextLayer("Fetch Modus",randomFetchModus(),564.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        species = new TextLayer("Species",getDollType(),824.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);

        lineY = 102.0;
        textColor = new TextLayer("Text Color: ",doll.associatedColor.toStyleString(),132.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        gender = new TextLayer("Gender: ",rand.pickFrom(<String>["F","M","???"]),373.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        specibus = new TextLayer("Strife Specibus: ",CharSheet.randomSpecibus(),596.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        ancestor = new TextLayer("Ancestor: ","???",832.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);

        lineY = 145.0;
        heart = new TextLayer("Heart Quadrant: ",randomHeart(),48.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);
        spades = new TextLayer("Spades Quadrant: ",randomNotHeart(),322.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);
        lineY = 172.0;
        diamonds = new TextLayer("Diamond Quadrant: ",randomNotHeart(),48.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);
        clubs = new TextLayer("Club Quadrant: ",randomClubs(),322.0,lineY, fontSize: fontSize, maxWidth: 235, fontName: fontName, emphasis: emphasis);

        double leftx = 57.0;
        double rightx= 313.0;


        strength = new BarLayer("Strength", "${rand.nextInt(10)}",leftx,228.0);
        stamina = new BarLayer("Stamina", "${rand.nextInt(10)}",rightx,228.0);

        agility = new BarLayer("Agility", "${rand.nextInt(10)}",leftx,282.0);
        perception = new BarLayer("Perception", "${rand.nextInt(10)}",rightx,282.0);

        accuracy = new BarLayer("Accuracy", "${rand.nextInt(10)}",leftx,332.0);
        stealth = new BarLayer("Stealth", "${rand.nextInt(10)}",rightx,332.0);

        intelligence = new BarLayer("Intelligence", "${rand.nextInt(10)}",leftx,398.0);
        imagination = new BarLayer("Imagination", "${rand.nextInt(10)}",rightx,398.0);

        psionics = new BarLayer("Psionics", "${rand.nextInt(10)}",leftx,450.0);
        occultLore = new BarLayer("Occult Lore", "${rand.nextInt(10)}",rightx,450.0);


        tactics = new BarLayer("Tactics", "${rand.nextInt(10)}",leftx,502.0);
        weaponSkill = new BarLayer("Weapon Skill", "${rand.nextInt(10)}",rightx,502.0);

        persuasion = new BarLayer("Persuasion", "${rand.nextInt(10)}",leftx,570.0);
        willpower = new BarLayer("Will Power", "${rand.nextInt(10)}",rightx,570.0);

        empathy = new BarLayer("Empathy", "${rand.nextInt(10)}",leftx,620.0);
        intimidation = new BarLayer("Intimidation", "${rand.nextInt(10)}",rightx,620.0);

        expression = new BarLayer("Expression", "${rand.nextInt(10)}",leftx,670.0);
        performance = new BarLayer("Performance", "${rand.nextInt(10)}",rightx,670.0);


        lineY = 728.0;
        className = new TextLayer("Class: ",randomClass(),119.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        spriteName = new TextLayer("SpriteName: ","???",334.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);

        lineY = 746.0;
        aspect = new TextLayer("Aspect: ",randomAspect(),127.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        proto1 = new TextLayer("Prototype1: ","???",335.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        proto2 = new TextLayer("Prototype2: ","???",335.0,762.0, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        consorts = new TextLayer("Consorts: ","???",312.0,778.0, fontSize: fontSize, fontName: fontName, emphasis: emphasis);

        bool moon = rand.nextBool();
        prospit = new CheckLayer("Prospit", "${moon ? 0:1}",89.0,749.0);
        derse = new CheckLayer("Derse", "${moon ? 1:0}",89.0,766.0);


        lineY = 794.0;
        land = new TextLayer("Land: ","???",142.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        denizen = new TextLayer("Denizen: ","???",413.0,lineY, fontSize: fontSize, fontName: fontName, emphasis: emphasis);
        tint = doll.associatedColor;
  }

  String randomHeart() {
      if(rand.nextBool()) {
        return nameForDoll();
      }else {
        return "";
      }
  }

    String randomNotHeart() {
        if(doll is HomestuckTrollDoll) {
            return randomHeart();
        }else {
            return "N/A";
        }
    }

    String randomClubs() {
        if(doll is HomestuckTrollDoll) {
            if(rand.nextBool()) {
                return "${nameForDoll()} & ${nameForDoll()}";
            }else {
                return "";
            }
        }else {
            return "N/A";
        }
    }



  String randomFetchModus() {
    List<String> possibilities = <String>["Video Game","Investment","EXP","Computer","Phone","Hacker","Television","Array","HashSet","Stack","Queue","Git","Wallet","Linked List","Queuestack","Tree","Hash Map","Memory","Jenga","Pictionary","Recipe","Fibonacci Heap ","Puzzle","Message in a Bottle ","Tech-Hop","Encryption","Ouija","Miracle","Chastity ","8 Ball","Scratch and Sniff","Pogs","JuJu","Sweet Bro","Purse","Meme","Cards Against Humanity","LARP"];
    return rand.pickFrom(possibilities);
  }



    Future<CanvasElement>  drawText() async {
      CanvasElement tmp = new CanvasElement(width: width, height: height);
      CanvasRenderingContext2D ctx = tmp.context2D;
      for(TextLayer textLayer in textLayers) {
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
            CanvasElement ret = new CanvasElement(width: 66, height: 66);

            //print("after cropping card element is ${cardElement.width} by ${cardElement.height}");

            Renderer.drawToFitCentered(ret, cardElement);
            return ret;
        }
        return null;
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

      CanvasElement symbolElement = await drawSymbol();
      if(symbolElement != null) canvas.context2D.drawImage(symbolElement,582, 702);

      CanvasElement textCanvas = await drawText();
      canvas.context2D.drawImage(textCanvas, 0, 0);

      CanvasElement dollElement = await drawDoll(doll,375,480);
      canvas.context2D.drawImage(dollElement,590, 180);

      //Renderer.drawBG(dollElement, ReferenceColours.RED, ReferenceColours.RED);


      if(saveLink == null) saveLink = new AnchorElement();
      saveLink.href = canvas.toDataUrl();
      syncSaveLink();
  }
}

