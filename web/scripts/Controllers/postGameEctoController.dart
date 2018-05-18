import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:DollLibCorrect/DollRenderer.dart';

Element container;
Element childContainer;

List<Doll> players = new List<Doll>();
List<Doll> currentCropChildren = new List<Doll>();

int numBabiesInCrop = 13;

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
    initParents();
    drawParents();
    makeBreedButtons();
    container.append(childContainer);
}

void initValidTypes() {
    dollTypes.add(1);
    dollTypes.add(2);
    dollTypes.add(15,0.3);
    dollTypes.add(16,0.3);
}

void initParents() {
    int type = rand.pickFrom(dollTypes);
    int number = rand.nextIntRange(2, 13);
    for(int i = 0; i<number; i++) {
        players.add(Doll.randomDollOfType(type));
    }
}

void drawParents() {
    for(Doll player in players) {
        drawOneParent(player);
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
    ButtonElement randomizeButton = new ButtonElement()..text = "Randomize";
    randomizeButton.style.display = "inline-block";
    randomizeButton.classes.add("targetButton");
    ButtonElement randomizeTypeButton = new ButtonElement()..text = "Randomize Type";
    randomizeTypeButton.style.display = "inline-block";
    randomizeTypeButton.classes.add("targetButton");



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

    div.append(ectoJar);
    div.append(loadButton);
    div.append(randomizeButton);
    div.append(randomizeTypeButton);
    div.append(parentCanvas);


    container.append(div);

    DollRenderer.drawDoll(parentCanvas, parent);
}

void makeBreedButtons() {
    DivElement buttonContainer = new DivElement();
    ButtonElement breed = new ButtonElement()..text = ">Populate Planet the Human Way";
    breed.style.display = "inline-block";
    breed.classes.add("ectoButton");


    ButtonElement breed2 = new ButtonElement()..text = ">Populate Planet the Troll Way";
    breed2.style.display = "inline-block";
    breed2.classes.add("ectoButton");


    ButtonElement clear = new ButtonElement()..text = "Clear Combinations";
    clear.classes.add("ectoButton");

    buttonContainer.append(breed);
    buttonContainer.append(breed2);

    buttonContainer.append(clear);
    container.append(buttonContainer);


    breed.onClick.listen((Event e) {
        makeBabiesHumanWay();
        drawBabies();
    });

    breed.onClick.listen((Event e) {
        makeBabiesTrollWay();
        drawBabies();
    });

    clear.onClick.listen((Event e) {
        childContainer.text = "";
    });
}

//pick random pairs of two
Future<Null> makeBabiesHumanWay() async {
    makeBabies(true);
}


//pick random pairs of two
Future<Null> makeBabies(bool humanWay) async {
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
        }else if(!(child is HomestuckCherubDoll) && !(child is HomestuckSatyrDoll)) {
            child = Doll.convertOneDollToAnother(child, new HomestuckBabyDoll());
        }
        currentCropChildren.add(child);
    }
}

//pick random subsets between two and all parents
Future<Null> makeBabiesTrollWay() async {
    makeBabies(false);
}

List<Doll> getXParents(int x) {
    List<Doll> ret = new List<Doll>();
    List<Doll> tmp = new List<Doll>.from(players);
    for(int i = 0; i<x; i++) {
        Doll doll = rand.pickFrom(tmp);
        tmp.add(doll);
        tmp.remove(doll);
    }
    return ret;
}

Future<Null> drawBabies() async {
    for(Doll doll in currentCropChildren) {
        CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
        childContainer.append(canvas);
        DollRenderer.drawDoll(canvas, doll);
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
