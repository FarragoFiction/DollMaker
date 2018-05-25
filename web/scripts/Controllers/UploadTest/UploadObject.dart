import '../BaseController.dart';
import 'FileUploadObject.dart';
import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';

class UploadObject {
    DivElement myElement;
    //usually will be one, but sometimes slaves/partners like for hair/horns
    List<SpriteLayer> layers;
    InputElement creatorNameInput;
    InputElement creatorNameWebsite;
    List<FileUploadObject> fileUploadObjects = new List<FileUploadObject>();
    //used for size checking
    BaseController controller;

    UploadObject(BaseController this.controller, List<SpriteLayer> this.layers) {
        initUploadObjects();
    }

    void initUploadObjects() {
        for(SpriteLayer layer in layers) {
            fileUploadObjects.add(new FileUploadObject(controller,layer));
        }
    }

    void draw(Element container) {
        myElement = new DivElement();
        myElement.classes.add("uploadElement");
        myElement.text = "${layers.join(",")}";
        container.append(myElement);
        drawCreatorInput();
        drawFileUploadObjects();
    }

    void drawFileUploadObjects() {
        for(FileUploadObject fio in fileUploadObjects) {
            fio.draw(myElement);
        }
    }
    void drawCreatorInput() {
        DivElement creator = new DivElement();
        myElement.append(creator);
        LabelElement label = new LabelElement()..text = "How You Want To Be Credited:";
        creatorNameInput = new InputElement();
        creatorNameInput.classes.add("uploadInput");

        LabelElement label2 = new LabelElement()..text = "Your Tumblr/Website/Etc:";
        creatorNameWebsite = new InputElement();
        creatorNameWebsite.classes.add("uploadInput");

        creator.append(label);
        creator.append(creatorNameInput);
        creator.append(label2);
        creator.append(creatorNameWebsite);
    }


}

