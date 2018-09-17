import '../../JSONObject.dart';
import '../BaseController.dart';
import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';
class FileUploadObject
{

    Element myElement;
    SpriteLayer layer;
    ImageElement upload;
    CanvasElement uploadColorPreview;
    BaseController controller;
    bool valid = true;
    //if you're almost there i'll count it, especially because of rounding errors
    int wiggleRoom = 5;

    FileUploadObject(BaseController this.controller, SpriteLayer this.layer);

    void draw(Element container) {
        myElement = new DivElement();
        myElement.text = "Upload $layer";
        container.append(myElement);
        drawFileChooser();
        drawImagePreview();
    }


    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json["directory"] = layer.imgNameBase;
        json["maxImageNumberKnown"] = "${layer.maxImageNumber}";
        //i know for a fact this src has stuff or this would crash anyways so just do it okay
        CanvasElement canvas = new CanvasElement(width: controller.doll.width, height: controller.doll.height);
        canvas.context2D.drawImage(upload,0,0);
        //json["data"] = "${upload.src}";
        String data = canvas.toDataUrl();
        if(upload.src.length < data.length) {
            data = upload.src;
        }
        json["data"] = data;
        return json;
    }

    void drawImagePreview() {
        TableElement tableElement = new TableElement();
        TableRowElement row1 = new TableRowElement();
        TableRowElement row2 = new TableRowElement();
        TableCellElement header = new TableCellElement()..setInnerHtml("<i>Look at the image to the right to see if recoloration is happening. If pixels aren't being recolored on the edges, you used anti-aliasing (Don't do that). If no pixels are being recolored, your colors are wrong. Check for color profile (pick RGB and not indexed or SRGB) and make sure color values are exact.</i>");
        header.colSpan = 2;
        TableCellElement cell1 = new TableCellElement();
        TableCellElement cell2 = new TableCellElement();
        myElement.append(tableElement);
        tableElement.append(row1);
        tableElement.append(row2);

        row1.append(header);
        row2.append(cell1);
        row2.append(cell2);

        upload = new ImageElement();
        uploadColorPreview= new CanvasElement(width: controller.doll.width, height: controller.doll.height);

        cell1.append(upload);
        cell2.append(uploadColorPreview);
    }

    void drawCanvasColorPreview() {
        Renderer.clearCanvas(uploadColorPreview);
        uploadColorPreview.context2D.drawImage(upload, 0, 0);
        Renderer.swapPalette(uploadColorPreview, controller.doll.paletteSource, controller.doll.palette);
    }

    void drawFileChooser() {
        InputElement fileElement = new InputElement();
        fileElement.type = "file";
        fileElement.classes.add("fileUploadButton");
        myElement.append(fileElement);

        fileElement.onChange.listen((e) {
            List<File> loadFiles = fileElement.files;
            File file = loadFiles.first;
            FileReader reader = new FileReader();
            reader.readAsDataUrl(file);
            reader.onLoadEnd.listen((e) {
                String loadData = reader.result;
                upload.src = loadData;
                layer.preloadedElement = upload;
                upload.onLoad.listen((e)
                {
                    if((upload.width - controller.doll.width).abs() > wiggleRoom) {
                        window.alert("Your uploaded part is width ${upload.width} instead of ${controller.doll.width}. Rejected.");
                        upload.src = "";
                        valid = false;
                        Renderer.clearCanvas(controller.canvas);
                        DollRenderer.drawDoll(controller.canvas, controller.doll);
                        drawCanvasColorPreview();
                    }else if((upload.height - controller.doll.height).abs() > wiggleRoom) {
                        window.alert("Your uploaded part is height ${upload.height} instead of ${controller.doll.height}. Rejected.");
                        upload.src = "";
                        valid = false;
                        Renderer.clearCanvas(controller.canvas);
                        DollRenderer.drawDoll(controller.canvas, controller.doll);
                        drawCanvasColorPreview();
                    }else {
                        valid = true;
                        Renderer.clearCanvas(controller.canvas);
                        DollRenderer.drawDoll(controller.canvas, controller.doll);
                        drawCanvasColorPreview();
                    }
                });
            });
        });
    }
}