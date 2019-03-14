import "../../commonImports.dart";
import '../Doll.dart';
import 'DynamicLayer.dart';
//it's a layer which is an entire doll (like fruit or flower or whatever, or evne a kid)
class PositionedDollLayer extends DynamicLayer{
    Doll doll;
    int width;
    int height;

    @override
    int renderingType = 2;
  PositionedDollLayer(Doll this.doll, int this.width, int this.height, int x, int y, String name) : super(x, y, name, "n/a", 0, 1);


    @override
    void saveToBuilder(ByteBuilder builder) {
        //print("saving positioned doll layer $name of type $renderingType to builder");
        builder.appendExpGolomb(renderingType);
        builder = doll.appendDataBytesToBuilder(builder);
       // print("doll done, time for everything else");
        builder.appendExpGolomb(x);
        builder.appendExpGolomb(y);
        builder.appendExpGolomb(width);
        builder.appendExpGolomb(height);

    }

    bool pointInsideMe(Point point) {
        Rectangle rect = getSelfRect();
        return rect.containsPoint(point);
    }

    Rectangle getSelfRect() {
        return new Rectangle(x, y, width, height);
    }



    @override
    void loadFromReader(ImprovedByteReader reader, [bool readType = true]) {
        //print("loading positioned doll layer from reader");
        //if read normally, will need to read and discard type, but if read as an extra layer will read the type ahead of time
        if(readType) {
           // print("i have to read (and discard) the type");
            reader.readExpGolomb();
        }
        doll = Doll.loadSpecificDollFromReader(reader);
        x = reader.readExpGolomb();
        y = reader.readExpGolomb();
        width = reader.readExpGolomb();
        height = reader.readExpGolomb();
        name = "${doll.name}DynamicLayer";
    }

    @override
    Element parseDataForDebugging(ImprovedByteReader reader) {
        //print("debugging positioned doll layer from reader");
        TableElement table = new TableElement();
        table.style.border = "3px solid black";

        TableRowElement row13 = new TableRowElement();
        table.append(row13);
        TableCellElement td1 = new TableCellElement()..text = "Type:";
        TableCellElement td2 = new TableCellElement()..text = "${reader.readExpGolomb()}";
        row13.append(td1);
        row13.append(td2);

        TableRowElement row0 = new TableRowElement();
        table.append(row0);
         td1 = new TableCellElement()..text = "Doll:";
        doll = Doll.loadSpecificDollFromReader(reader);
         td2 = new TableCellElement()..text = "TODO, but it's a ${doll.name}";
        row0.append(td1);
        row0.append(td2);


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
    Future<Null> drawSelf(CanvasElement buffer) async {
        //print("drawing a positioned doll layer named $name");
        CanvasElement dollCanvas = doll.blankCanvas;
        await DollRenderer.drawDoll(dollCanvas, doll);
        buffer.context2D.drawImageScaled(dollCanvas, x, y, width, height);
    }

}

