import 'DollSlurper.dart';
import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:CommonLib/src/collection/weighted_lists.dart';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:RenderingLib/src/loader/loader.dart';

Element container;
Element parentContainer;
Element childContainer;
Element buttonContainer;

List<Doll> players = new List<Doll>();
List<Doll> currentCropChildren = new List<Doll>();

String chosenCategory;

int numBabiesInCrop = 12;

Random rand = new Random();

CanvasElement canvas1;
CanvasElement canvas2;

WeightedList<int> dollTypes = new WeightedList<int>();


Future<Null> main() async{
    loadNavbar();
    rand.nextInt(); //init
    await Loader.preloadManifest();
    initValidTypes();
    container = querySelector("#ectoContents");
    childContainer = new DivElement();
    await initParents();
    parentContainer = new DivElement();



    drawParents();
    buttonContainer = new DivElement();
    makeBreedButtons();
    container.append(parentContainer);
    container.append(buttonContainer);
    container.append(childContainer);
}

void initValidTypes() {
    dollTypes.add(1);
    dollTypes.add(2);
    dollTypes.add(15,0.5);
    dollTypes.add(16,0.5);
}

Future<Null> initParents() async {
    pickCategory();
    int number = rand.nextIntRange(2, 13);
    if(chosenCategory == null) {
        int type = rand.pickFrom(dollTypes);
        for (int i = 0; i < number; i++) {
            players.add(Doll.randomDollOfType(type));
        }
    }else {
        await slurpDolls(players, chosenCategory);
        //random amount from that category
        List<Doll> tmp = new List<Doll>();
        for (int i = 0; i < number; i++) {
            if(players.isNotEmpty) {
                Doll doll = rand.pickFrom(players);
                tmp.add(doll);
                players.remove(doll);
            }
        }

        players = tmp;
    }
}

Future<Null> drawParents() async {
    for(Doll player in players) {
        drawOneParent(player);
        await new Future.delayed(const Duration(milliseconds : 500));
    }
}

void drawOneParent(Doll parent) {
    DivElement div = new DivElement();
    div.classes.add("breedingParent");
    CanvasElement parentCanvas = new CanvasElement(width: parent.width, height: parent.height);
    parentCanvas.style.display = "block";

    ButtonElement loadButton = new ButtonElement()..text = "Load";
    loadButton.style.display = "inline-block";
    loadButton.classes.add("targetButton");
    ButtonElement randomizeButton = new ButtonElement()..text = "Random";
    randomizeButton.style.display = "inline-block";
    randomizeButton.classes.add("targetButton");
    ButtonElement randomizeTypeButton = new ButtonElement()..text = "New Type";
    randomizeTypeButton.style.display = "inline-block";
    randomizeTypeButton.classes.add("targetButton");

    ButtonElement removeButton = new ButtonElement()..text = "Remove";
    removeButton.style.display = "inline-block";
    removeButton.classes.add("targetButton");



    DivElement ectoJar = new DivElement();
    ectoJar.classes.add("ectoJarContainer");
    ImageElement jarTop = new ImageElement(src: "images/jarTop.png");
    jarTop.classes.add("jarTop");
    ectoJar.append(jarTop);

    DivElement jarElement = new DivElement();
    ectoJar.append(jarElement);
    jarElement.classes.add("jar");
    //why is it so hard to put a thing on the bottom of another thing without it suddenly
    //making it's parent think it's empty
    DivElement jarAir = new DivElement();
    jarAir.classes.add("jarAir");
    jarElement.append(jarAir);

    TextAreaElement dataBox = new TextAreaElement();
    dataBox.classes.add("ectoSlime");
    dataBox.style.display = "block";
    dataBox.value = "${parent.toDataBytesX()}";
    jarElement.append(dataBox);

    loadButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.loadSpecificDoll(dataBox.value);
        players.remove(parent);
        players.add(tmp);
        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    randomizeButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.randomDollOfType(parent.renderingType);
        players.remove(parent);
        players.add(tmp);
        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    randomizeTypeButton.onClick.listen((Event e) {
        Renderer.clearCanvas(parentCanvas);
        Doll tmp = Doll.randomDollOfType(rand.pickFrom(dollTypes));
        players.remove(parent);
        players.add(tmp);

        parent = tmp;
        parentCanvas.width = parent.width;
        parentCanvas.height = parent.height;

        DollRenderer.drawDoll(parentCanvas, parent);
    });

    removeButton.onClick.listen((Event e) {
        if(players.length ==2) {
            window.alert("I can't let you do that, Observer. You need at least two players to do ectobiology.");
        }else{
            players.remove(parent);
            div.remove();
        }
    });

    div.append(ectoJar);
    div.append(loadButton);
    div.append(randomizeButton);
    div.append(randomizeTypeButton);
    div.append(removeButton);

    div.append(parentCanvas);


    parentContainer.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}

void makeBreedButtons() {
    ButtonElement breed = new ButtonElement()..text = ">Populate Planet the Human Way";
    breed.style.display = "inline-block";
    breed.classes.add("ectoButton");


    ButtonElement breed2 = new ButtonElement()..text = ">Populate Planet the Troll Way";
    breed2.style.display = "inline-block";
    breed2.classes.add("ectoButton");


    ButtonElement clear = new ButtonElement()..text = "Clear Combinations";
    clear.classes.add("ectoButton");
    clear.style.display = "inline-block";

    ButtonElement addButton = new ButtonElement()..text = "Add Player";
    addButton.style.display = "inline-block";
    addButton.classes.add("ectoButton");


    buttonContainer.append(breed);
    buttonContainer.append(breed2);

    buttonContainer.append(clear);
    buttonContainer.append(addButton);



    breed.onClick.listen((Event e) {
        makeBabiesHumanWay();
    });

    breed2.onClick.listen((Event e) {
        makeBabiesTrollWay();
    });

    clear.onClick.listen((Event e) {
        childContainer.text = "";
    });

    addButton.onClick.listen((Event e) {
        Doll player = Doll.randomDollOfType(players.first.renderingType);
        players.add(player);
        drawOneParent(player);
    });
}

//pick random pairs of two
Future<Null> makeBabiesHumanWay() async {
    makeBabies(true);
}


//pick random pairs of two
Future<Null> makeBabies(bool humanWay) async {
    currentCropChildren.clear();
    for(int i = 0; i< numBabiesInCrop; i++) {
        int number = 2;
        if(!humanWay) {
            number = rand.nextIntRange(2, players.length);
        }
        List<Doll> parents = getXParents(number);
        Doll child = Doll.breedDolls(parents);
        //i don't have a cherub baby or satyr baby doll maker
        if(child is HomestuckTrollDoll) {
            child = Doll.convertOneDollToAnother(child, new HomestuckGrubDoll());
            (child as HomestuckTrollDoll).symbol.imgNumber = 0;
            (child as HomestuckTrollDoll).canonSymbol.imgNumber = 0;
            (child as HomestuckGrubDoll).pickCasteAppropriateBody();
        }else if(!(child is HomestuckCherubDoll) && !(child is HomestuckSatyrDoll)) {
            child = Doll.convertOneDollToAnother(child, new HomestuckBabyDoll());
            (child as HomestuckDoll).symbol.imgNumber = 0;
        }
        currentCropChildren.add(child);
    }
    drawBabies();
}

//pick random subsets between two and all parents
Future<Null> makeBabiesTrollWay() async {
    makeBabies(false);
}

List<Doll> getXParents(int x) {
    print("getting $x parents");
    List<Doll> ret = new List<Doll>();
    List<Doll> tmp = new List<Doll>.from(players);
    for(int i = 0; i<x; i++) {
        Doll doll = rand.pickFrom(tmp);
        //print("got $doll");
        ret.add(doll);
        tmp.remove(doll);
    }
    return ret;
}

Future<Null> drawBabies() async {
    int totalWidth = 800;
    int totalHeight = 600;
    CanvasElement section = new CanvasElement(width: totalWidth, height: totalHeight);
    childContainer.append(section);
    int x = 0;
    int y = 0;
    int width = 200;
    int height = 200;
    int padding = 0;
    drawTextBoxes();
    for(Doll doll in currentCropChildren) {

        CanvasElement canvas = await drawDoll(doll, 200, 200);
        section.context2D.drawImage(canvas, x, y);
        x = (x + width + padding);
        if(x > totalWidth-width) {
            x = 0;
            y = (y + height + padding);
        }
        await new Future.delayed(const Duration(milliseconds : 500));
    }
}


void drawTextBoxes() {
    DivElement tmp = new DivElement();
    childContainer.append(tmp);
    tmp.style.width = "800px";
    tmp.setInnerHtml("DataStrings in same order as Dolls.<br>");
    for(Doll doll in currentCropChildren) {
        DivElement ectoJar = new DivElement();
        ectoJar.classes.add("jarSimple");
        TextAreaElement area = new TextAreaElement();
        area.classes.add("ectoSlime");
        area.value = doll.toDataBytesX();
        ectoJar.append(area);
        AnchorElement a = new AnchorElement(href: "index.html?${doll.toDataUrlPart()}");
        a.text = "edit";
        a.target = "_blank";
        a.style.display = "block";
        a.classes.add("targetButton");
        a.style.paddingLeft = "20px";
        a.style.marginLeft = "auto";
        a.style.marginRight = "auto";
        ectoJar.append(a);
        tmp.append(ectoJar);
    }
}



Future<CanvasElement>  drawDoll(Doll doll, int w, int h) async {
        CanvasElement ret = new CanvasElement(width: w, height: h);
        CanvasElement dollCanvas = new CanvasElement(width: doll.width, height: doll.height);
        await DollRenderer.drawDoll(dollCanvas, doll);
        dollCanvas = Renderer.cropToVisible(dollCanvas);
        Renderer.drawToFitCentered(ret, dollCanvas);
        return ret;
}

void todo(String todo) {
    LIElement tmp = new LIElement();
    tmp.setInnerHtml("TODO: $todo");
    container.append(tmp);
}

void pickCategory() {
    chosenCategory = getParameterByName("target");
}
