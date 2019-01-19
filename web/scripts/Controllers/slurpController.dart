import 'dart:async';
import 'dart:html';

import 'package:DollLibCorrect/DollRenderer.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';


List<String> extensions = <String>[
    "png",
    "gif",
    "jpg",
    "jpeg",
];
Element container;
RegExp filePattern = new RegExp('<a href="([^?]*?)">');
RegExp extensionPattern = new RegExp("\\\.(${extensions.join("|")})\$");
RegExp numberedFilePattern = new RegExp("([a-zA-Z_]+?)(\\d+?)\\.");

Future<Null> main() async{
    await Doll.loadFileData();
    container = querySelector("#contents");
    todo("for each doll, for each doll part, print out name of file path");
    todo("for each file path, print out contents as text");
    printAllDollPaths();
}

void todo(String todoString) {
    LIElement bluh = new LIElement()..setInnerHtml("<b>TODO:</b> $todoString");
    container.append(bluh);
}

void printAllDollPaths() {
    for(int i in Doll.allDollTypes) {
        printOneDollPath(Doll.randomDollOfType(i));
    }
}

void printOneDollPath(Doll doll) {
    //String source = "http://www.farragofiction.com/DollPartsUpload/DollSource"; //assume we are local
    String source = "http://www.farragofiction.com/DollPartsUpload/"; //assume we are local

    DivElement dollDiv = new DivElement()..setInnerHtml("<h1>${doll.name}</h1>");
    dollDiv.style.margin = "30px";
    dollDiv.style.border = "3px solid black";
    dollDiv.style.backgroundColor = "#aaaaaa";
    container.append(dollDiv);
    for(SpriteLayer layer in doll.renderingOrderLayers) {
        printOneDirectory(doll, layer, "$source/${layer.imgNameBase}", dollDiv);
    }
}

Future<Null> printOneDirectory(Doll doll, SpriteLayer layer, String dir, Element div) async {
    DivElement line = new DivElement();
    line.style.padding = "10px";
    div.append(line);
    List<String> files = await getDirectoryListing(dir);
    if(files.isEmpty) {
        line.setInnerHtml("<b>${layer.name}</b>: No New Parts");
    }else {
        int max = getHighestSequentialFile(files);
        line.setInnerHtml(" <b>${layer.name}</b>:   Highest: ${max} ........ so ${max - layer.maxImageNumber} parts found");
    }

    ButtonElement view = new ButtonElement()..text = "Show Parts";
    line.append(view);
    DivElement parts = new DivElement();
    parts.style.display == "none";
    line.append(parts);
    view.onClick.listen((Event e) {
        print("toggling");
        if(parts.children.isEmpty) {
            fillParts(doll, dir, files, parts);
        }
        if(parts.style.display == "inline-block") {
            view.text = "Show Parts";
            parts.style.display = "none";
        }else {
            view.text = "Hide Parts";
            parts.style.display = "inline-block";
        }
    });
}

Future<Null> fillParts(Doll doll ,String dir, List<String> files, DivElement parts) async {
    for(String file in files) {
        String fileName = "$dir$file";
        print("trying out $fileName");
        DivElement container = new DivElement();
        container.style.display = "inline-block";
        DivElement label = new DivElement()..text = "$fileName";
        container.append(label);
        CanvasElement visible = new CanvasElement(width:150,height:150);
        container.append(visible);
        parts.append(container);
        ImageElement img = new ImageElement();
        img.crossOrigin = "Anonymous";
        //can't use pl's loader cuz it doesn't set cross origin
        img.src = fileName;
        img.onLoad.listen((Event e) {
            CanvasElement temp = new CanvasElement(
                width: doll.width, height: doll.height);
            temp.context2D.drawImage(img, 0, 0);
            Renderer.swapPalette(temp, doll.paletteSource, doll.palette);
            visible.context2D.drawImageScaled(temp, 0, 0, 150, 150);
        });

        img.onError.listen((Event e) {
            DivElement error = new DivElement()..text = "Error loading part $e";
            container.append(error);
        });
    }
}


Future<List<String>> getDirectoryListing(String url) async {
    List<String> files = <String>[];
    String content = await HttpRequest.getString(url);
    Iterable<Match> matches = filePattern.allMatches(content); // find all link targets
    for (Match m in matches) {
        String filename = m.group(1);
        if (!extensionPattern.hasMatch(filename)) { continue; } // extension rejection

        //print(filename);

        files.add(filename);
    }

    return files;
}


//thanks PL, yoinked this from SBURBSim then modified it. uh. heavily.
int getHighestSequentialFile(List<String> files) {
    List<int> numbers = <int>[];

    for (String file in files) {
         numbers.add(int.parse(file.split(".png")[0]));
    }
    numbers.sort();

    return numbers.last;
}