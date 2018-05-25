import '../BaseController.dart';
import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';
class FileUploadObject
{
    Element myElement;
    SpriteLayer layer;
    ImageElement upload;
    BaseController controller;
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

    void drawImagePreview() {
        upload = new ImageElement();
        myElement.append(upload);
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
                    if((upload.width - controller.doll.width).abs() < wiggleRoom) {
                        window.alert("Your uploaded part is width ${upload.width} instead of ${controller.doll.width}. Rejected.");
                        upload.src = null;
                    }else if((upload.height - controller.doll.height).abs() < wiggleRoom) {
                        window.alert("Your uploaded part is height ${upload.height} instead of ${controller.doll.height}. Rejected.");
                        upload.src = null;
                    }else {
                        DollRenderer.drawDoll(controller.canvas, controller.doll);
                    }
                });
            });
        });
    }
}