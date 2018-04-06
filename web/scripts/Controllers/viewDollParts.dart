import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "dart:html";
import "dart:async";


List<Doll> dollExamples = new List<Doll>();
List<CustomRadio> dollRadios = new List<CustomRadio>();
List<CustomRadio> partRadios = new List<CustomRadio>();
DivElement div;
Doll selectedDoll;
DivElement detailDiv;
DivElement partDetailDiv;
void main() {
    loadNavbar();
    div = querySelector("#output");
    detailDiv = new DivElement();
    detailDiv.text = "Select a Doll to View It's Details";
    detailDiv.id = "detailDiv";
    partDetailDiv = new DivElement();
    partDetailDiv.id = "partDetailDiv";
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
    div.append(detailDiv);
    detailDiv.append(partDetailDiv);
}

void handleSelections() {
    for(CustomRadio cr in dollRadios) {
        cr.syncSelected();
    }
}

void selectDoll(Doll doll) {
    selectedDoll = doll;
    detailDiv.setInnerHtml("");
    drawPalette();
    todo("print out layers for ${doll.name}");
    todo("have layers be clickable to show all images for that layer");
}

void drawPalette() {
    TableElement table = new TableElement();
    for(String name in selectedDoll.paletteSource.names) {
        TableRowElement line = new TableRowElement();
        TableCellElement td1 = new TableCellElement();
        td1.text = "${name}";
        TableCellElement td2 = new TableCellElement();
        td2.text = "${selectedDoll.paletteSource[name].toStyleString()}";
        TableCellElement td3 = new TableCellElement();
        td3.style.backgroundColor = "${selectedDoll.paletteSource[name].toStyleString()}";
        td3.style.width = "50px";
        td1.style.border = "1px solid black";
        td2.style.border = "1px solid black";
        td3.style.border = "1px solid black";

        line.append(td1);
        line.append(td2);
        line.append(td3);
        table.append(line);
    }
    detailDiv.append(table);
}

void drawBox(Doll doll) {
    DivElement box = new DivElement();
    div.append(box);
    CustomRadio cr = new CustomRadio(box, doll.name);
    dollRadios.add(cr);

    box.onClick.listen((e)
    {
        cr.radioHidden.checked = true;
        handleSelections();
        selectDoll(doll);
    });
}

class CustomRadio
{
    RadioButtonInputElement radioHidden;
    Element radioVisible;

    CustomRadio(Element this.radioVisible, String label) {
        radioVisible.style.display = "inline-block";
        radioVisible.style.padding = "5px";
        radioVisible.style.border = "3px solid black";
        DivElement name = new DivElement();
        name.text = label;
        radioVisible.append(name);
        radioHidden = new RadioButtonInputElement();
        radioHidden.name = "DollRadioGroup";
        radioVisible.append(radioHidden);
    }



    void syncSelected() {
        if(radioHidden.checked) {
            radioVisible.classes.add("selected");
        }else {
            radioVisible.classes.remove("selected");
        }
    }
}