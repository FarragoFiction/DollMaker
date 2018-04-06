import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "dart:html";
import "dart:async";


List<Doll> dollExamples = new List<Doll>();
List<CustomRadio> dollRadios = new List<CustomRadio>();
List<CustomRadio> partRadios = new List<CustomRadio>();
DivElement div;
Doll selectedDoll;
SpriteLayer selectedPart;
SpanElement detailDiv;
SpanElement partDetailDiv;
void main() {
    loadNavbar();
    div = querySelector("#output");
    detailDiv = new SpanElement();
    detailDiv.text = "Select a Doll to View It's Details";
    detailDiv.id = "detailDiv";
    partDetailDiv = new SpanElement();
    partDetailDiv.id = "partDetailDiv";
    initDollList();
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

void drawAllParts(Element container) {
    if(selectedDoll is QueenDoll) {
        container.setInnerHtml("Apologies, this doll type is not yet supported.");
        return;
    }
    for(SpriteLayer s in selectedDoll.renderingOrderLayers) {
        drawPartBox(s, container);
    }
}

Future<Null> drawAllBoxes() async {
    await Loader.preloadManifest();

    for(Doll doll in dollExamples) {
        drawDollBox(doll);
    }

    div.append(detailDiv);
    detailDiv.append(partDetailDiv);
}

void handleSelections(List<CustomRadio> list) {
    for(CustomRadio cr in list) {
        cr.syncSelected();
    }
}

void selectDoll(Doll doll) {
    selectedDoll = doll;
    detailDiv.setInnerHtml("");
    TableElement detailTable = new TableElement();
    TableRowElement tr = new TableRowElement();
    TableCellElement td1 = new TableCellElement();
    TableCellElement td2 = new TableCellElement();
    tr.append(td1);
    tr.append(td2);
    detailTable.append(tr);
    detailDiv.append(detailTable);

    drawPalette(td1);
    drawAllParts(td2);
}

void selectPart(SpriteLayer part) {
    selectedPart = part;
    partDetailDiv.setInnerHtml("");
    drawAllImagesForPart();
}

void drawAllImagesForPart() {
    DivElement container = new DivElement();
    for(int i = 0; i<selectedPart.maxImageNumber; i++) {
        ImageElement img = new ImageElement();
        //auto async
        img.src = "${selectedPart.imgNameBase}${i}.${selectedPart.imgFormat}";
        container.append(img);
    }
    partDetailDiv.append(container);
}

void drawPalette(Element container) {
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
    container.append(table);
}

void drawDollBox(Doll doll) {
    DivElement box = new DivElement();
    div.append(box);
    CustomRadio cr = new CustomRadio(box, doll.name, "DollRadioGroup");
    dollRadios.add(cr);

    box.onClick.listen((e)
    {
        cr.radioHidden.checked = true;
        handleSelections(dollRadios);
        selectDoll(doll);
    });
}

void drawPartBox(SpriteLayer part, Element container) {
    DivElement box = new DivElement();
    container.append(box);
    CustomRadio cr = new CustomRadio(box, part.name, "PartRadioGroup");
    partRadios.add(cr);

    box.onClick.listen((e)
    {
        cr.radioHidden.checked = true;
        handleSelections(partRadios);
        selectPart(part);
    });
}

class CustomRadio
{
    RadioButtonInputElement radioHidden;
    Element radioVisible;

    CustomRadio(Element this.radioVisible, String label, String group) {
        radioVisible.style.display = "inline-block";
        radioVisible.style.padding = "5px";
        radioVisible.style.border = "3px solid black";
        DivElement name = new DivElement();
        name.text = label;
        radioVisible.append(name);
        radioHidden = new RadioButtonInputElement();
        radioHidden.name = group;
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