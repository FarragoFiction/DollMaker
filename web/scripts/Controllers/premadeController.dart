import '../navbar.dart';
import "dart:html";
import "dart:async";

import 'package:CommonLib/Utility.dart';
import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:RenderingLib/RendereringLib.dart';

Element container;
List<String> cateogories = <String>["wranglers","credits","homestuck","rps"];

String chosenCategory = "wranglers";

List<Doll> dolls = new List<Doll>();

Future<Null> main() async {
    loadNavbar();
    container = querySelector("#contents");
    pickCategory();
    drawLinks();
    await slurpDolls();
    drawDolls();
}

void drawLinks() {
    DivElement div = new DivElement();
    div.style.border = "3px solid #000000";
    container.append(div);
    for(String s in cateogories) {
        drawOneLink(div, s);
    }
}

void drawOneLink(Element div, String link) {
    AnchorElement a = new AnchorElement(href: "premadeViewer.html?target=$link");
    a.style.display = "inline-block";

    if(chosenCategory != link) {
        a.classes.add("navButtonJR");
    }else {
        a.classes.add("navButtonJRSelected");
    }

    a.text = "$link";
    div.append(a);
}

Future<Null> drawDolls() async {
    for(Doll d in dolls) {
        drawOneDoll(d);
        await new Future.delayed(const Duration(milliseconds : 500));
    }
}

//go as fast as you can
Future<Null> drawOneDoll(Doll d) async {
    DivElement div = new DivElement();
    div.style.display = "inline-block";
    container.append(div);

    CanvasElement canvas = new CanvasElement(width: d.width, height: d.height);
    div.append(canvas);

    TextAreaElement area = new TextAreaElement();
    area.value = d.toDataBytesX();
    area.style.display = "block";
    div.append(area);

    ButtonElement copyButton = new ButtonElement()..text = "Copy";
    div.append(copyButton);

    DollRenderer.drawDoll(canvas, d);

    copyButton.onClick.listen((Event e) {
        area.select();
        document.execCommand('copy');
    });

    AnchorElement editLink = new AnchorElement(href: "index.html?${d.toDataUrlPart()}")..text = "Edit ${d.dollName}"..target="_blank";
    div.append(editLink);
}

void pickCategory() {
    chosenCategory = getParameterByName("target");
    if(chosenCategory == null) chosenCategory = cateogories.first;
    DivElement category = new DivElement();
    category.style.fontSize = "33px";
    category.text = "$chosenCategory PreMade Dolls";
    AnchorElement a = new AnchorElement(href: "postGameEcto.html?target=${chosenCategory}");
    a.target = "_blank";
    a.style.padding = "5px";

    a.text = "Perform Ectobiology?";
    category.append(a);

    AnchorElement a2 = new AnchorElement(href: "pesterlog.html?target=${chosenCategory}");
    a2.target = "_blank";
    a2.style.padding = "5px";
    a2.text = "View Pesterlog?";
    category.append(a2);


    AnchorElement a3 = new AnchorElement(href: "ship.html?target=${chosenCategory}");
    a3.target = "_blank";
    a3.style.padding = "5px";
    a3.text = "View Ships?";
    category.append(a3);

    container.append(category);
    if(chosenCategory == "homestuck") {
        container.appendHtml("Thanks to someoneLikeable, prismaticJelly and Grip for Canon Doll creation!");
    }
}

Future<Null> slurpDolls() async{
    //yes, i know it' sspelled wrong. no, i don't care.
    await HttpRequest.getString(PathUtils.adjusted("DollHoarde/${chosenCategory}.txt")).then((String data) {
        List<String> parts = data.split(new RegExp("\n|\r"));
        for(String line in parts) {
            if(line.isNotEmpty) {
                try {
                    dolls.add(Doll.loadSpecificDoll(line));
                }catch(e) {
                    DivElement error = new DivElement();
                    error.text = "Error loading $line, $e";
                    error.style.color = "red";
                    print(e);
                }
            }
        }
    });
}