import "../Dolls/Doll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckDoll.dart";
import "package:DollLibCorrect/src/Dolls/KidBased/HomestuckTrollDoll.dart";
import "dart:html";
import 'dart:async';
import "package:DollLibCorrect/src/Dolls/Layers/SpriteLayer.dart";
import 'package:RenderingLib/RendereringLib.dart';


import "dart:math" as Math;

import "../Dolls/ConsortDoll.dart";
import "package:LoaderLib/Loader.dart";

class DollRenderer {
    static int imagesWaiting = 0;
    static int imagesLoaded = 0;

    //drawing this out into a wrapper so a doll can ask to just draw sub parts of itself
    static  Future<bool>  drawDoll(CanvasElement canvas, Doll doll, [bool legacy = false, bool debugTime = false]) async {
        return await drawSubsetLayers(canvas, doll,doll.renderingOrderLayers);
    }


    //ideal timeline has us not pass the doll at all, but until i need that i'm not coding it, things like upways matter here.
    static  Future<bool>  drawSubsetLayers(CanvasElement canvas, Doll doll,List<SpriteLayer> layers, [bool legacy = false, bool debugTime = false]) async {
        //print("Drawing a doll of width ${doll.width}");
        //most dolls will do nothing here, but if they need to calculate where their layers get positioned they do it here.
        //or if they need to figure out if they even have shit
        DateTime now;
        if(debugTime) now = new DateTime.now();
        await doll.beforeRender();
        if(doll.width == null) {
            ImageElement image = await Loader.getResource((layers.first.imgLocation));
            doll.width = image.width;
            doll.height = image.height;
           // print("loaded image of ${doll.width} and height ${doll.height}. ");

        }
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        buffer.context2D.imageSmoothingEnabled = false;
        doll.setUpWays();
        buffer.context2D.save();

        processOrientation(buffer, doll);
        processRotation(buffer, doll);

        for(SpriteLayer l in layers) {
            //print("drawing rendering order layer $l for doll $doll");
            await l.drawSelf(buffer);
        }
        //print("done drawing images");

        if(doll.palette.isNotEmpty) {
            if(legacy) {
                Renderer.swapPaletteLegacy(buffer, doll.paletteSource, doll.palette);
            }else {
                Renderer.swapPalette(buffer, doll.paletteSource, doll.palette);
            }
        }
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        Renderer.copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);

        buffer.context2D.restore();
        if(debugTime) {
            DateTime now2 = new DateTime.now();
            Duration diff = now2.difference(now);
            print("Legacy was $legacy. It took ${diff.inMilliseconds} ms to render $doll.");

        }

    }

    //whatever calls this handles save and restore
    static void processRotation(buffer, doll) {
        if(doll.rotation != 0) {
            //print("rotating ${doll.rotation}");
            buffer.context2D.translate(buffer.width/2, buffer.height/2);
            buffer.context2D.rotate(doll.rotation*Math.PI/180);
            //return
            buffer.context2D.translate(-buffer.width/2, -buffer.height/2);
        }
    }

    static void processOrientation(CanvasElement buffer, Doll doll) {
        if(doll.orientation == Doll.TURNWAYS) {
            //print("drawing turnways");
            //fuck is anything ever using this? this seems wrong, should be
            //buffer.context2D.translate(dollCanvas.width, 0);
            buffer.context2D.translate(buffer.width, 0);
            buffer.context2D.scale(-1, 1);
        }else if(doll.orientation == Doll.UPWAYS) {
            //print("drawing up ways");
            buffer.context2D.translate(0, buffer.height);
            //buffer.context2D.rotate(1);
            buffer.context2D.scale(1, -1);
        }else if(doll.orientation == Doll.TURNWAYSBUTUP) {
            //print("drawing turnways but up");
            buffer.context2D.translate(buffer.width, buffer.height);
            buffer.context2D.scale(-1, -1);
        }else {
            buffer.context2D.scale(1, 1);
        }
    }

    static  Future<bool>  drawDollEmbossed(CanvasElement canvas, Doll doll) async {
        //print("Drawing a doll");
        CanvasElement buffer = new CanvasElement(width: doll.width, height: doll.height);
        for(SpriteLayer l in doll.renderingOrderLayers) {
            if(l.preloadedElement != null) {
                print("I must be testing something, it's a preloaded Element");
                bool res = await Renderer.drawExistingElementFuture(buffer, l.preloadedElement);
            }else {
                bool res = await Renderer.drawWhateverFuture(buffer, l.imgLocation);
            }
        }
        //print("done drawing images");

        buffer.context2D.imageSmoothingEnabled = false;

        Renderer.grayscale(buffer);
        Renderer.emboss(buffer);
        scaleCanvasForDoll(canvas, doll);
        canvas.context2D.imageSmoothingEnabled = false;

        if(doll.orientation == Doll.TURNWAYS) {
            canvas.context2D.drawImage(buffer, -buffer.width/2, -buffer.height/2);

        }else {
            Renderer.copyTmpCanvasToRealCanvasAtPos(canvas, buffer, 0, 0);
        }

    }





    //the doll should fit into the canvas. use largest size
    static scaleCanvasForDoll(CanvasElement canvas, Doll doll) {
        double ratio = 1.0;
        if(doll.width > doll.height) {
            ratio = canvas.width/doll.width;
        }else {
            ratio = canvas.height/doll.height;
        }
        canvas.context2D.scale(ratio, ratio);
        //don't let it be all pixelated
        canvas.context2D.imageSmoothingEnabled = false;

    }

}




