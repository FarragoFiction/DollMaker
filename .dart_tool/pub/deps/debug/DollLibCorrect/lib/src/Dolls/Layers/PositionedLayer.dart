import "../../commonImports.dart";
import 'SpriteLayer.dart';

class PositionedLayer extends SpriteLayer {
    //assume doll's upper left is 0,0
    int x;
    int y;
  PositionedLayer(int this.x, int this.y, String name, String imgNameBase, int imgNumber, int maxImageNumber, {bool legacy = false}) : super(name, imgNameBase, imgNumber, maxImageNumber, legacy:legacy);

  @override
    void saveToBuilder(ByteBuilder builder) {
      //print("saving positioned  layer $name to builder");
      builder.appendExpGolomb(imgNumber);
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
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

        return table;
    }

    @override
    void loadFromReader(ImprovedByteReader reader) {
        imgNumber = reader.readExpGolomb();
        x = reader.readExpGolomb();
        y = reader.readExpGolomb();
    }

    @override
    Future<Null> drawSelf(CanvasElement buffer) async {
        if(preloadedElement != null) {
            //print("I must be testing something, it's a preloaded Element");
            bool res = await Renderer.drawExistingElementFuture(buffer, preloadedElement,x,y);
        }else {
            bool res = await Renderer.drawWhateverFuture(buffer, imgLocation,x,y);
        }
    }
}
