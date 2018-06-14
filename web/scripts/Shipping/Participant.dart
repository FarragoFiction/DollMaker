import 'Trove.dart';
import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';

/*
a participant has a doll and a name and....a....gender???
 */
class Participant {
    Doll doll;
    String name;
    //??? gender???
    Trove trove; //so it knows to rewrite it if you change the doll
    Participant(String this.name, Doll this.doll);

    void draw(Element element) {
        DivElement div = new DivElement();
        div.classes.add("breedingParent");
        CanvasElement parentCanvas = new CanvasElement(width: doll.width, height: doll.height);
        parentCanvas.style.border = "3px solid #000000";

        ButtonElement loadButton = new ButtonElement()..text = "Load";
        loadButton.style.display = "inline-block";
        ButtonElement randomizeButton = new ButtonElement()..text = "Randomize";
        randomizeButton.style.display = "inline-block";
        ButtonElement randomizeTypeButton = new ButtonElement()..text = "Randomize Type";
        randomizeTypeButton.style.display = "inline-block";



        TextAreaElement dataBox = new TextAreaElement();
        dataBox.style.display = "block";
        dataBox.value = "${doll.toDataBytesX()}";
        loadButton.onClick.listen((Event e) {
            Renderer.clearCanvas(parentCanvas);
            doll = Doll.loadSpecificDoll(dataBox.value);

            parentCanvas.width = doll.width;
            parentCanvas.height = doll.height;

            DollRenderer.drawDoll(parentCanvas, doll);
            trove.setCharms();
        });

        randomizeButton.onClick.listen((Event e) {
            Renderer.clearCanvas(parentCanvas);
            doll = Doll.randomDollOfType(doll.renderingType);
            parentCanvas.width = doll.width;
            parentCanvas.height = doll.height;

            DollRenderer.drawDoll(parentCanvas, doll);
            trove.setCharms();
            dataBox.value = "${doll.toDataBytesX()}";

        });

        randomizeTypeButton.onClick.listen((Event e) {
            Renderer.clearCanvas(parentCanvas);
            Random rand = new Random(); //true random
            doll = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
            parentCanvas.width = doll.width;
            parentCanvas.height = doll.height;

            DollRenderer.drawDoll(parentCanvas, doll);
            dataBox.value = "${doll.toDataBytesX()}";
            trove.setCharms();
        });

        div.append(parentCanvas);
        div.append(dataBox);
        div.append(loadButton);
        div.append(randomizeButton);
        div.append(randomizeTypeButton);

        element.append(div);

        DollRenderer.drawDoll(parentCanvas, doll);
    }
}