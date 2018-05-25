import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';

class UploadObject {
    DivElement myElement;
    //usually will be one, but sometimes slaves/partners like for hair/horns
    List<SpriteLayer> layers;

    UploadObject(List<SpriteLayer> this.layers);

    void draw(Element container) {
        myElement = new DivElement();
        myElement.classes.add("uploadElement");
        myElement.text = "${layers.join(",")}";
        container.append(myElement);
    }
}