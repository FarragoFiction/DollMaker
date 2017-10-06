import 'dart:math';

typedef void JROnClick();


class SpriteLayer {
    String imgFormat;
    String imgNameBase;
    int _imgNumber;
    int maxImageNumber;
    String description = "";

    bool changed = true; //generate descriptions when created, that will set it to false

    SpriteLayer(this.imgNameBase, this._imgNumber, this.maxImageNumber, [this.imgFormat = "png"]);

    String get imgLocation {
        return "$imgNameBase${imgNumber}.${imgFormat}";
    }

    int get imgNumber {
        return _imgNumber;
    }

    //so i know to update the description
    void set imgNumber(int i) {
        _imgNumber = i;
        changed = true;
    }

}

class ClickableSpriteLayer extends SpriteLayer {
    //I need to know where i am in the canvas
    double topLeftX;
    double topLeftY;
    double width;
    double height;
    JROnClick jrOnClick;

    ClickableSpriteLayer(String imgNameBase, int imgNumber,int maxImageNumber, this.topLeftX, this.topLeftY, this.width, this.height,  [String format = "png"]): super(imgNameBase, imgNumber,maxImageNumber,format) {
        jrOnClick = incrementNumber;
    }

    bool wasClicked(double x, double y) {
        print("Does ($x,$y) mean $imgNameBase was clicked?");
        Rectangle rect = new Rectangle(topLeftX, topLeftY, width, height);
        print("Rect is $rect");
        return rect.containsPoint(new Point(x,y));
    }

    void incrementNumber() {
        imgNumber ++;
        if(imgNumber > maxImageNumber) imgNumber = 0;
        print("incrementing $imgNameBase to $imgNumber");
    }
}