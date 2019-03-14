import "../../commonImports.dart";

/*

A text layer is like a sprite layer, but with text instead of images.

It ALSO always has a x/y start location.
 */

class TextLayer {

    Element element;
    String justification;
    String name;
    String text;
    double topLeftX;
    double topLeftY;
    int maxWidth;
    int maxHeight;
    int fontSize;
    String emphasis = "";
    //ctx.fillStyle = "#000000";
    Colour fontColor;
    //ctx.font = "42px Times New Roman";
    String fontName;

    TextLayer(String this.name, String this.text, double this.topLeftX, double this.topLeftY, {this.emphasis: "", this.maxWidth: 100, this.maxHeight: 75,this.fontSize: 12, this.fontColor: null, this.justification: "left", this.fontName: "Times New Roman"}) {
        if(fontColor == null) {
            fontColor = new Colour(0,0,0);
        }

        element = new DivElement();
        Element formWrapper = new DivElement();
        formWrapper.setInnerHtml("$name:");

        formWrapper.className = "textAreaElement";

        TextAreaElement formElement = new TextAreaElement();
        formElement.value = text;
        formElement.onChange.listen((Event e) {
            print("I felt a change in ${formElement.value}");
            text = formElement.value;
        });


        element.append(formWrapper);
        element.append(formElement);

    }

    String get font => "$emphasis ${fontSize}px $fontName";
    String get fillStyle => fontColor.toStyleString();




}