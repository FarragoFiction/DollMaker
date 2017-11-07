import "dart:html";
import "DollLib/DollRenderer.dart";
import 'DollLib/src/includes/path_utils.dart';

import "HomestuckDollLib.dart";

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
        if(layer is NamedSpriteLayer) {
            drawDropDownForNamedSpriteLayer(div, layer, callback);
            return;
        }
        print("drawing drop down for ${layer.name}, is it a slave? ${layer.slave}");
        if(layer.slave) return; //this will be set by owner.
        //drop down should be set to whatever the layer's img number is,
        //and on change it should change the layers img number
        String html = "<div class = 'dollDropDownDiv'><select class = 'dollDropDown' id = '${layer.name}' name='${layer.name}'>";
        for (int i = 0; i <= layer.maxImageNumber; i++) {
            if (layer.imgNumber == i) {
                html += '<option  selected = "selected" value="$i">$i</option>';
            } else {
                html += '<option value="$i">$i</option>';
            }
        }
        html += "</select><span class = 'dropDownLabel'>${layer.name}</span></div>";
        appendHtml(div, html);

        SelectElement drawnDropDown = querySelector("#${layer.name}");

        drawnDropDown.onChange.listen((Event e) {
            print("layer changed");
            //InputElement classDropDown = querySelector('[name="className${player.id}""] option:selected'); //need to get what is selected inside the .change, otheriise is always the same;
            OptionElement option = drawnDropDown.selectedOptions[0];
            layer.imgNumber = int.parse(option.value);
            callback();
        });

    }

    static void drawDropDownForNamedSpriteLayer(Element div, NamedSpriteLayer layer, dynamic callback) {
        print("drawing drop down for ${layer.name}, is it a slave? ${layer.slave}");
        if(layer.slave) return; //this will be set by owner.
        //drop down should be set to whatever the layer's img number is,
        //and on change it should change the layers img number
        String html = "<div class = 'dollDropDownDiv'><select class = 'dollDropDown' id = '${layer.name}' name='${layer.name}'>";
        for (String s in layer.possibleNames) {
            if (layer.name == s) {
                html += '<option  selected = "selected" value="$s">$s</option>';
            } else {
                html += '<option value="$s">$s</option>';
            }
        }
        html += "</select><span class = 'dropDownLabel'>Layer</span></div>";

        if(layer.possibleNames.isNotEmpty) {
            appendHtml(div, html);

            SelectElement drawnDropDown = querySelector("#${layer.name}");

            drawnDropDown.onChange.listen((Event e) {
                print("layer changed");
                //InputElement classDropDown = querySelector('[name="className${player.id}""] option:selected'); //need to get what is selected inside the .change, otheriise is always the same;
                OptionElement option = drawnDropDown.selectedOptions[0];
                layer.imgNumber = int.parse(option.value);
                callback();
            });
        }

    }

    static void drawSamplePalettes(Element div, Doll doll, dynamic callback) {

        String html = "<div class = 'dollDropDownDiv'><select class = 'dollDropDown' id = 'samplePalettes' name='samplePalettes'>";
        html += "<option value = 'None'>None</option>";
        Map<String, Palette> samples = ReferenceColours.paletteList;
        for (String name in samples.keys) {
            html += '<option value="$name">$name</option>';
        }
        html += "</select><span class = 'dropDownLabel'>Premade Palettes</span></div>";
        appendHtml(div, html);

        SelectElement drawnDropDown = querySelector("#samplePalettes");

        drawnDropDown.onChange.listen((Event e) {
            print("sample palette changed");
            OptionElement option = drawnDropDown.selectedOptions[0];
            Palette chosen  = samples[option.value];
            for(String name in chosen.names) {
                doll.palette.add(name, chosen[name],true);
            }
            syncColorPickersToSprite(chosen);
            callback();
        });
    }

    static void drawColorPickersForPallete(Element div, Palette palette, dynamic callback) {
        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            drawColorPicker(name, div, palette[name], palette, callback);
        }
    }

    //TODO is it enough to modify this color, or do I need to pass it back?
    static void drawColorPicker(String name, Element div, Colour color, Palette source, dynamic callback) {

        String html = "<div class = 'colorPickerClass'><input alt = '$name' id = '${name}' type='color' name='${name}' value='${color.toStyleString()}'><span class = 'dropDownLabel'>$name</span></div>";
        appendHtml(div, html);

        InputElement colorDiv = querySelector("#${name}");
        colorDiv.onChange.listen((Event e) {
            print("color changed");
            String colorString = (querySelector("#${name}") as InputElement).value;
            Colour newColor = new Colour.fromStyleString(colorString);
            source.add(name, newColor, true); //overright that shit.
            callback();
        });
    }

    static void appendHtml(Element element, String html) {
        element.appendHtml(html, treeSanitizer: NodeTreeSanitizer.trusted);
    }




}