import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';

class UploadObject {
    DivElement myElement;
    //usually will be one, but sometimes slaves/partners like for hair/horns
    List<SpriteLayer> layers;
    InputElement creatorNameInput;
    InputElement creatorNameWebsite;

    UploadObject(List<SpriteLayer> this.layers);

    void draw(Element container) {
        myElement = new DivElement();
        myElement.classes.add("uploadElement");
        myElement.text = "${layers.join(",")}";
        container.append(myElement);
        drawCreatorInput();
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