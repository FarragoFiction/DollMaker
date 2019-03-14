import "../../commonImports.dart";
import 'SpriteLayer.dart';

class PositionedLayerPlusUltra extends SpriteLayer {
    //assume doll's upper left is 0,0
    int x;
    int y;
    int width;
    int height;
    PositionedLayerPlusUltra(int this.width, int this.height, int this.x, int this.y, String name, String imgNameBase, int imgNumber, int maxImageNumber, {bool legacy=false}) : super(name, imgNameBase, imgNumber, maxImageNumber, legacy:legacy);

  @override
    void saveToBuilder(ByteBuilder builder) {
      //print("saving positioned  layer $name to builder");
      builder.appendExpGolomb(imgNumber);
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
        builder.appendExpGolomb(width);
        builder.appendExpGolomb(height);
    }


    @override
    Element parseDataForDebugging(ImprovedByteReader reader) {
        TableElement table = new TableElement();
        table.style.border = "3px solid black";

        TableRowElement row1 = new TableRowElement();
        table.append(row1);

        TableCellElement td1 = new TableCellElement()..text = "Image Number:";
        TableCellElement td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row1.append(td1);
        row1.append(td2);

        TableRowElement row2 = new TableRowElement();
        table.append(row2);
        td1 = new TableCellElement()..text = "X:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row2.append(td1);
        row2.append(td2);

        TableRowElement row3 = new TableRowElement();
        table.append(row3);
        td1 = new TableCellElement()..text = "Y:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row3.append(td1);
        row3.append(td2);

        row3 = new TableRowElement();
        table.append(row3);
        td1 = new TableCellElement()..text = "Width:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row3.append(td1);
        row3.append(td2);

        row3 = new TableRowElement();
        table.append(row3);
        td1 = new TableCellElement()..text = "Height:";
        td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row3.append(td1);
        row3.append(td2);

        return table;
    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        imgNumber = reader.readExpGolomb();
        x = reader.readExpGolomb();
        y = reader.readExpGolomb();
        width = reader.readExpGolomb();
        height = reader.readExpGolomb();
    }

    @override
    Future<Null> drawSelf(CanvasElement buffer) async {
        if(preloadedElement != null) {
            //print("I must be testing something, it's a preloaded Element");
            bool res = await Renderer.drawExistingElementFuture(buffer, preloadedElement,x,y);
        }else {
            ImageElement image = await Loader.getResource((imgLocation));
            image.crossOrigin = "";
            //print("got image $image");
            buffer.context2D.imageSmoothingEnabled = false;
            print("image is $image, x is $x, y is $y and width is $width and height is $height");
            buffer.context2D.drawImageScaled(image, x, y , width, height);
        }
    }
}
