import "dart:html";
import "../navbar.dart";
import "dart:async";
import 'package:CommonLib/Utility.dart';
import 'package:DollLibCorrect/DollRenderer.dart';



Future<Null> slurpDolls(List<Doll> players, String chosenCategory) async{
    //yes, i know it' sspelled wrong. no, i don't care.
    print("chosen category is $chosenCategory");
    await Doll.loadFileData();

    await HttpRequest.getString(PathUtils.adjusted("DollHoarde/${chosenCategory}.txt")).then((String data) {
        List<String> parts = data.split(new RegExp("\n|\r"));
        for(String line in parts) {
            if(line.isNotEmpty) {
                try {
                    players.add(Doll.loadSpecificDoll(line));
                }catch(e) {
                    DivElement error = new DivElement();
                    error.text = "Error loading $line, $e";
                    error.style.color = "red";
                    print(e);
                }
            }
        }
    });
}