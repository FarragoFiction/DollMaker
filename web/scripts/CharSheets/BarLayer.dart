import 'dart:html';
class BarLayer {

    Element element;
    int maxValue = 10;
    String folder = "images/CharSheets";
    String value = "0";
    String barName = "bar";
    String name;
    double topLeftX;
    double topLeftY;

    String get imgLoc => "$folder/$barName${value}.png";
    BarLayer(this.name, this.value, this.topLeftX, this.topLeftY, [this.maxValue]) {
        element = new DivElement();
        Element formWrapper = new DivElement();
        formWrapper.className = "textAreaElement";
        formWrapper.setInnerHtml("$name:");


        NumberInputElement formElement = new NumberInputElement();
        formElement.value = value;
        formElement.max = "$maxValue";
        formElement.min = "0";
        formElement.onChange.listen((Event e) {
            print("I felt a change in ${formElement.value}");
            value = formElement.value;
        });

        element.append(formWrapper);

        element.append(formElement);
    }
}

class CheckLayer extends BarLayer {
    @override
    int maxValue = 1;
    String barName = "check";
  CheckLayer(String name, String value, double topLeftX, double topLeftY) : super(name, value, topLeftX, topLeftY);



}