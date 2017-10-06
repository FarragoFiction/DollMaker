import "SpriteLayer.dart";
import "dart:html";
import "includes/colour.dart";
import "includes/palette.dart";

abstract class DollMakerTolls {

    static void syncDropDownToSprite(SpriteLayer layer) {
        SelectElement drawnDropDown = querySelector("#${layer.name}");
        drawnDropDown.value = "${layer.imgNumber}";
    }

    static void drawDropDownForSpriteLayer(Element div, SpriteLayer layer, dynamic callback) {
        if(layer.slave) return; //this will be set by owner.
        //drop down should be set to whatever the layer's img number is,
        //and on change it should change the layers img number
        String html = "<div class = 'dollDropDownDiv'><span class = 'dropDownLabel'>${layer.name}:</span><select class = 'dollDropDown' id = '${layer.name}' name='${layer.name}'>";
        for (int i = 0; i <= layer.maxImageNumber; i++) {
            if (layer.imgNumber == i) {
                html += '<option  selected = "selected" value="$i">$i</option>';
            } else {
                html += '<option value="$i">$i</option>';
            }
        }
        html += '</select></div>';
        appendHtml(div, html);

        SelectElement drawnDropDown = querySelector("#${layer.name}");

        drawnDropDown.onChange.listen((Event e) {
            //InputElement classDropDown = querySelector('[name="className${player.id}""] option:selected'); //need to get what is selected inside the .change, otheriise is always the same;
            OptionElement option = drawnDropDown.selectedOptions[0];
            layer.imgNumber = int.parse(option.value);
            callback();
        });

    }

    static void drawColorPickersForPallete(Element div, Palette palette) {
        /*for(Colour c in palette.iterator) {
            //TODO why isn't an iterator an iterable? how do i get the list of colors in a palette?
        }*/
    }

    //TODO is it enough to modify this color, or do I need to pass it back?
    static void drawColorPicker(Element div, Colour color) {

    }

    static void appendHtml(Element element, String html) {
        element.appendHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
    }


}