import "SpriteLayer.dart";
import "dart:html";
import "includes/colour.dart";
import "includes/palette.dart";

abstract class DollMakerTools {

    static void syncDropDownToSprite(SpriteLayer layer) {
        SelectElement drawnDropDown = querySelector("#${layer.name}");
        drawnDropDown.value = "${layer.imgNumber}";
    }

    static void syncColorPickersToSprite(Palette palette) {
        for(String name in palette.names) {
            syncColorPickerToColor(name, palette[name]);
        }
    }

    static void syncColorPickerToColor(String name, Colour color){
        InputElement drawnDropDown = querySelector("#${name}");
        drawnDropDown.value = "${color.toStyleString()}";
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

    static void drawColorPickersForPallete(Element div, Palette palette, dynamic callback) {
        for(String name in palette.names) {
            drawColorPicker(name, div, palette[name]);
        }
        callback();
    }

    //TODO is it enough to modify this color, or do I need to pass it back?
    static void drawColorPicker(String name, Element div, Colour color) {
        String html = "<input id = '${name}' type='color' name='${name}' value='${color.toStyleString()}'>";
        appendHtml(div, html);

        InputElement colorDiv = querySelector("#${name}");
        colorDiv.onChange.listen((Event e) {
            String colorString = (querySelector("#customColor") as InputElement).value;
            Colour newColor = new Colour.fromStyleString(colorString);
            color.setRGB(newColor.red, newColor.green, newColor.blue);
        });
    }

    static void appendHtml(Element element, String html) {
        element.appendHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
    }


}