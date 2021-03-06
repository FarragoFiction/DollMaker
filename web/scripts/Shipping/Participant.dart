import 'Trove.dart';
import 'dart:html';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:CommonLib/Colours.dart';
import 'package:CommonLib/Random.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';
/*
a participant has a doll and a name and....a....gender???
 */
class Participant{
    static String REPLACE = "REPLACE";
    Doll doll;
    CanvasElement cachedDollCanvas;
    //??? gender???

    String get name {
        return doll.dollName;
    }

    Trove trove; //so it knows to rewrite it if you change the doll
    Participant(Doll this.doll);

    void draw(Element element) {
        cachedDollCanvas = null; //reload l8r, don't do now cuz this isn't asysnc
        DivElement div = new DivElement();
        div.classes.add("breedingParent");
        CanvasElement tmpCanvas = new CanvasElement(width: doll.width, height: doll.height);
        tmpCanvas.style.border = "3px solid #000000";

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
            Renderer.clearCanvas(tmpCanvas);
            cachedDollCanvas = null;
            doll = Doll.loadSpecificDoll(dataBox.value);

            tmpCanvas.width = doll.width;
            tmpCanvas.height = doll.height;

            DollRenderer.drawDoll(tmpCanvas, doll);
            trove.setCharmsRandom();
        });

        randomizeButton.onClick.listen((Event e) {
            Renderer.clearCanvas(tmpCanvas);
            cachedDollCanvas = null;
            if(trove.possibleDolls != null && trove.possibleDolls.isNotEmpty) {
                doll = new Random().pickFrom(trove.possibleDolls);
            }else {
                doll = Doll.randomDollOfType(doll.renderingType);
            }
            tmpCanvas.width = doll.width;
            tmpCanvas.height = doll.height;

            DollRenderer.drawDoll(tmpCanvas, doll);
            trove.setCharmsRandom();
            dataBox.value = "${doll.toDataBytesX()}";

        });

        randomizeTypeButton.onClick.listen((Event e) {
            Renderer.clearCanvas(tmpCanvas);
            cachedDollCanvas = null;
            Random rand = new Random(); //true random
            doll = Doll.randomDollOfType(rand.pickFrom(Doll.allDollTypes));
            tmpCanvas.width = doll.width;
            tmpCanvas.height = doll.height;

            DollRenderer.drawDoll(tmpCanvas, doll);
            dataBox.value = "${doll.toDataBytesX()}";
            trove.setCharmsRandom();
        });

        div.append(tmpCanvas);
        div.append(dataBox);
        div.append(loadButton);
        div.append(randomizeButton);
        div.append(randomizeTypeButton);

        element.append(div);


        DollRenderer.drawDoll(tmpCanvas, doll);
    }
}