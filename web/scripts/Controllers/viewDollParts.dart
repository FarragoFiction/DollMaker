import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "dart:html";
import "dart:async";


List<Doll> dollExamples = new List<Doll>();
List<CustomRadio> dollRadios = new List<CustomRadio>();
DivElement div;
Doll selectedDoll;
void main() {
    loadNavbar();
    div = querySelector("#output");
    initDollList();
    todo("get selected Doll");
    todo("display dolls palette automatically, both color and box");
    todo("drop down menu of each types parts Name: Number of Options");
    todo("when a part is selected, display all of them, min to max");
    todo("take in a doll type for initial selection");
    todo("have each doll maker or prt tester link to this page with doll type set");
    drawAllBoxes();

}

void todo(String text) {
    DivElement container = new DivElement();
    container.setInnerHtml("<b>TODO</b>: $text");
    div.append(container);
}

void initDollList() {
    List<int> dollTypes = <int>[1,2,16,12,13,3,4,7,9,10,14,113,15,8,151,17,18];
    for(int type in dollTypes) {
        dollExamples.add(Doll.randomDollOfType(type));
    }
}

Future<Null> drawAllBoxes() async {
    await Loader.preloadManifest();

    for(Doll doll in dollExamples) {
        drawBox(doll);
    }
}

void handleSelections() {
    for(CustomRadio cr in dollRadios) {
        cr.syncSelected();
    }
}

void selectDoll(Doll doll) {
    selectedDoll = doll;
    todo("Print out palette for ${doll.name}");
    todo("print out layers for ${doll.name}");
    todo("have layers be clickable to show all images for that layer");
}

void drawBox(Doll doll) {
    DivElement box = new DivElement();
    box.style.display = "inline-block";
    box.style.padding = "5px";
    box.style.border = "3px solid black";
    DivElement name = new DivElement();
    name.text = doll.name;
    box.append(name);
    div.append(box);
    RadioButtonInputElement radio = new RadioButtonInputElement();
    radio.name = "DollRadioGroup";
    box.append(radio);
    dollRadios.add(new CustomRadio(box, radio));

    box.onClick.listen((e)
    {
        radio.checked = true;
        handleSelections();
        selectDoll(doll);
    });
}

class CustomRadio
{
    RadioButtonInputElement radioHidden;
    Element radioVisible;

    CustomRadio(Element this.radioVisible, RadioButtonInputElement this.radioHidden);

    void syncSelected() {
        if(radioHidden.checked) {
            radioVisible.classes.add("selected");
        }else {
            radioVisible.classes.remove("selected");
        }
    }
}