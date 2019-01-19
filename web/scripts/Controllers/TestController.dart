import 'dart:async';

import 'dart:html';
import 'package:DollLibCorrect/src/Dolls/Doll.dart';
import 'package:DollLibCorrect/src/Dolls/KidBased/HomestuckLamiaDoll.dart';
import 'package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart';
import 'package:LoaderLib/Loader.dart';
import 'package:RenderingLib/RendereringLib.dart';

Element container = querySelector("#contents");

Future<Null> main() async {
    await Doll.loadFileData();
    //draw each horn for each doll, colored
    HomestuckLamiaDoll selectedDoll = new HomestuckLamiaDoll();
    SpriteLayer leftHorn = selectedDoll.extendedLeftHorn;
    SpriteLayer rightHorn = selectedDoll.extendedRightHorn;

    for(int i = 0; i<leftHorn.maxImageNumber+1; i++) {
        drawPart(selectedDoll,leftHorn,rightHorn, i);
    }


}

Future<Null> drawPart(Doll doll, SpriteLayer part1, SpriteLayer part2, int imgNumber) async{
    ImageElement img1 = await Loader.getResource("${part1.imgNameBase}${imgNumber}.${part1.imgFormat}");
    ImageElement img2 = await Loader.getResource("${part2.imgNameBase}${imgNumber}.${part2.imgFormat}");

    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    canvas.context2D.drawImage(img1,0,0);
    canvas.context2D.drawImage(img2,0,0);

    CanvasElement visible = new CanvasElement(width:100,height:100);

    Renderer.swapPalette(canvas, doll.paletteSource, doll.palette);
    visible.context2D.drawImageScaled(canvas,0,0,100,100);
    DivElement me = new DivElement();
    me.style.border= "1px solid black";
    me.style.width = "100px";
    me.style.display = "inline-block";
    me.append(visible);
    DivElement number = new DivElement()..text = "$imgNumber";
    me.append(number);
    container.append(me);

}
