import "../HomestuckDollLib.dart";
import "dart:html";
import 'package:CommonLib/Collection.dart';
import "package:DollLibCorrect/DollRenderer.dart";
import "../navbar.dart";
import "../CharSheetLib.dart";
import 'dart:async';
import 'package:TextEngine/TextEngine.dart';

void main() {
    loadNavbar();
    Random rand = new Random();
    List<int> types = new List.from(Doll.allDollTypes);
    types.addAll(<int>[33,34,35]); //add tree some in manually
    SCP scp = new SCP(querySelector("#contents"), Doll.randomDollOfType(rand.pickFrom(types)));
}

class SCP {
    static WeightedList<String> categories = new WeightedList();
    Doll doll;
    String name;
    Element container;
    String objectClass;

    String containmentProcedure;
    String description;

    int get id {
        //so two dolls with the same seed have different ids if they are different sub types
        int ret = doll.renderingType * 10000000;
        ret += doll.seed;
        return ret;
    }

    SCP(Element this.container, Doll this.doll) {
        name = "SCP ${id}";
        setObjectClass();
        renderSelf();
    }

    bool isNotAnimate() {
        return doll is BroomDoll || doll is TreeDoll || doll is FruitDoll || doll is EasterEggDoll || doll is FlowerDoll;
    }

    void setObjectClass() {

        if(isNotAnimate()) {
            categories.add("Safe", 3); //the living are neve safe (which sounds hella obvious but its an scp thing)
        }
        categories.add("Euclid",10);
        categories.add("Keter",0.3);
        categories.add("Thaumiel",0.001);

        if(doll is PigeonDoll) {
            objectClass = "Thaumiel";
        }else {
            objectClass = new Random(doll.seed).pickFrom((categories));
        }

    }

    Future<Null> setContainmentProcedures() async{
        TextStory story = new TextStory();
        story.setString("name","$name");
        TextEngine textEngine = new TextEngine(doll.seed);
        //top level things everything can access rember to import in words files
        await textEngine.loadList("containment");
        containmentProcedure = "${textEngine.phrase("ContainmentTop", story: story)}";
        await textEngine.loadList("scpDescription");
        description = "${textEngine.phrase("DescriptionTop", story: story)}";

    }

    Future<Null> renderSelf() async {
        await setContainmentProcedures();
        renderHeader();
        new SCPSection(container, "Item #", "$name");
        renderImage();
        new SCPSection(container, "Object Class", "$objectClass");
        new SCPSection(container, "Special Containment Procedures", "$containmentProcedure");
        new SCPSection(container, "Description", "$description");
    }

    void renderImage() {
        CanvasElement canvas = doll.blankCanvas;
        int max = 500;
        if(canvas.height > max) {
            double ratio = max/canvas.height;
            canvas.height = (canvas.height * ratio).round();
            canvas.width = (canvas.width * ratio).round();

        }
        canvas.classes.add("scpPortrait");
        container.append(canvas);
        finishDrawingCanvasWhenever(canvas);
    }

    Future<Null> finishDrawingCanvasWhenever(CanvasElement canvas) async{
        CanvasElement tmp = await doll.getNewCanvas();
        Renderer.drawToFitCentered(canvas, tmp);
    }

    void renderHeader() {
       HeadingElement header = new HeadingElement.h1()..classes.add("scpHeader")..text = "$name";
      container.append(header);
      container.append(new HRElement());
    }
}

class SCPSection {
    String title;
    String body;
    Element container;
    SCPSection(Element this.container, String this.title, String this.body) {
        renderSelf();
    }

    void renderSelf() {
        DivElement section = new DivElement()..classes.add("scpSection");
        SpanElement label = new SpanElement()..setInnerHtml("<b>$title: </b>");
        SpanElement text = new SpanElement()..setInnerHtml("$body");
        section.append(label);
        section.append(text);
        container.append(section);
    }
}

