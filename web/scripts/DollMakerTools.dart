import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "Controllers/BaseController.dart";


import "HomestuckDollLib.dart";

abstract class DollMakerTools {
    //used for generic palette handling. store what the dolls actual palette is when initing the drop downs.
    static List<String> paletteDropDownNames = new List<String>();

    static void syncDropDownToSprite(SpriteLayer layer) {
        SelectElement drawnDropDown = querySelector("#${layer.name}");
        drawnDropDown.value = "${layer.imgNumber}";
    }

    static void syncColorPickersToSprite(Palette palette) {
        int i = 0; //for if the palette doesn't match perfectly
        for(String name in palette.names) {
            if(paletteDropDownNames.contains(name)) {
                syncColorPickerToColor(name, palette[name]);
            }else {
                //won't look as good but this way can apply homestuck kid palette to pigeons, denizens, whatever
                if(i < paletteDropDownNames.length) syncColorPickerToColor(paletteDropDownNames[i], palette[name]);
            }
            i ++;
        }
    }

    static void syncColorPickerToColor(String name, Colour color){
        InputElement drawnDropDown = querySelector("#${name}");
        drawnDropDown.value = "${color.toStyleString()}";
    }

    //takes in a controller so doll is always accurate, even if i swap it
    static void drawDropDownForSpriteLayer(BaseController controller, Element div, SpriteLayer layer, dynamic callback) {
        if(layer is NamedSpriteLayer) {
            drawDropDownForNamedSpriteLayer(controller, div, layer, callback);
            return;
        }

        print("drawing drop down for ${layer.name}, is it a slave? ${layer.slave}");
        if(layer.slave) return; //this will be set by owner.
        //drop down should be set to whatever the layer's img number is,
        //and on change it should change the layers img number
        String html = "<span class = 'dollDropDownDiv'><select class = 'dollDropDown' id = '${layer.name}' name='${layer.name}'>";
        for (int i = 0; i <= layer.maxImageNumber; i++) {
            if (layer.imgNumber == i) {
                html += '<option  selected = "selected" value="$i">$i</option>';
            } else {
                html += '<option value="$i">$i</option>';
            }
        }
        html += "</select><span class = 'dropDownLabel'>${layer.name}</span></span><br>";

        ButtonElement randomizer = new ButtonElement();
        randomizer.style.display = "inline-block";
        randomizer.setInnerHtml("?");
        div.append(randomizer);
        appendHtml(div, html);

        randomizer.onClick.listen((E) {
            layer.randomize();
            callback();
        });

        SelectElement drawnDropDown = querySelector("#${layer.name}");

        drawnDropDown.onChange.listen((Event e) {
            print("layer changed");
            //InputElement classDropDown = querySelector('[name="className${player.id}""] option:selected'); //need to get what is selected inside the .change, otheriise is always the same;
            OptionElement option = drawnDropDown.selectedOptions[0];
            layer.imgNumber = int.parse(option.value);
            callback();
        });

    }

    static void drawDropDownForNamedSpriteLayer(BaseController controller, Element div, NamedSpriteLayer layer, dynamic callback) {
        print("drawing drop down for ${layer.name}, is it a slave? ${layer.slave}");
        SpanElement wrapper = new SpanElement();
        if(layer.slave) return; //this will be set by owner.
        //drop down should be set to whatever the layer's img number is,
        //and on change it should change the layers img number
        String html = "<span class = 'dollDropDownDiv'><select class = 'dollDropDown' id = '${layer.name}' name='${layer.name}'>";
        for (String s in layer.possibleNames) {
            if (layer.name == s) {
                html += '<option  selected = "selected" value="$s">$s</option>';
            } else {
                html += '<option value="$s">$s</option>';
            }
        }
        html += "</select><span class = 'dropDownLabel'>Layer</span></span>";

        if(layer.possibleNames.isNotEmpty) {
            ButtonElement b = new ButtonElement();
            b.setInnerHtml("[X]");
            wrapper.append(b);
            appendHtml(wrapper, html);
            div.append(wrapper);

            SelectElement drawnDropDown = querySelector("#${layer.name}");

            b.onClick.listen((Event e) {
                NamedLayerDoll d = controller.doll as NamedLayerDoll;
                d.layers.remove(layer);
                wrapper.remove();
                callback();
            });

            drawnDropDown.onChange.listen((Event e) {
                print("layer changed");
                //InputElement classDropDown = querySelector('[name="className${player.id}""] option:selected'); //need to get what is selected inside the .change, otheriise is always the same;
                OptionElement option = drawnDropDown.selectedOptions[0];
                layer.name = option.value ;
                callback();
            });
        }

    }



    static void addNewNamedLayerButton(BaseController controller, Element div, dynamic callback) {
        print("What am i even doing here?");
        Element layerControls = querySelector("#layerControls");
        NamedLayerDoll d = controller.doll as NamedLayerDoll;
        NamedSpriteLayer newLayer = new NamedSpriteLayer(d.possibleParts, "New Layer", "", 0, 0);
        DivElement wrapper = new DivElement();
        wrapper.classes.add("dollDropDownDiv");
        SelectElement selectElement = new SelectElement();
        selectElement.classes.add("dollDropDown");
        for(String s in newLayer.possibleNames) {
            OptionElement o = new OptionElement();
            o.value = s;
            o.setInnerHtml(s);
            selectElement.append(o);
        }
        wrapper.append(selectElement);
        layerControls.append(wrapper);

        ButtonElement b = new ButtonElement();
        b.setInnerHtml("Add Prototyping");
        wrapper.append(b);

        b.onClick.listen((Event e) {
            OptionElement option = selectElement.selectedOptions[0];
            NamedLayerDoll d = controller.doll as NamedLayerDoll;

            d.addLayerNamed(option.value);
            DollMakerTools.drawDropDownForSpriteLayer(controller, layerControls, d.layers.last, callback);
            wrapper.remove();
            addNewNamedLayerButton( controller,  div,  callback);
            callback();
        });


    }



    static void drawSamplePalettes(Element div, BaseController controller, dynamic callback) {

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
            //TODO if i can't find the name in the palette change SOMETHING
            int i = 0;
            List<String> names = new List<String>.from(controller.doll.palette.names);
            for(String name in chosen.names) {
                if(names.contains(name)) {
                    controller.doll.palette.add(name, chosen[name], true);
                }else {
                    if(i < names.length)controller.doll.palette.add(names[i], chosen[name], true);
                }
                i++;
            }
            syncColorPickersToSprite(chosen);
            callback();
        });
    }

    static void drawColorPickersForPallete(Element div, Palette palette, dynamic callback) {
        List<String> names = new List<String>.from(palette.names);
        names.sort();
        for(String name in names) {
            paletteDropDownNames.add(name);
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