import '../../JSONObject.dart';
import '../BaseController.dart';
import 'FileUploadObject.dart';
import "dart:html";

import 'package:DollLibCorrect/DollRenderer.dart';

class UploadObject {
    String serverHost = "http://www.farragofiction.com";
    String serverPort = "4037";
    DivElement myElement;
    //usually will be one, but sometimes slaves/partners like for hair/horns
    List<SpriteLayer> layers;
    InputElement creatorNameInput;
    InputElement creatorNameWebsite;
    List<FileUploadObject> fileUploadObjects = new List<FileUploadObject>();
    //used for size checking
    BaseController controller;

    UploadObject(BaseController this.controller, List<SpriteLayer> this.layers) {
        initUploadObjects();
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json["name"] = creatorNameInput.value;
        json["website"] = creatorNameWebsite.value;

        List<JSONObject> fileUploadObjectsArray = new List<JSONObject>();
        for(FileUploadObject f in fileUploadObjects) {
            fileUploadObjectsArray.add(f.toJSON());
        }
        json["fileUploadObjects"] = fileUploadObjectsArray.toString();
        return json;
    }
    void initUploadObjects() {
        for(SpriteLayer layer in layers) {
            fileUploadObjects.add(new FileUploadObject(controller,layer));
        }
    }

    void draw(Element container) {
        DivElement hiderThingy = new DivElement();
        hiderThingy.classes.add("uploadElement");
        hiderThingy.text = "Upload ${layers.join(" and ")}";
        ButtonElement button = new ButtonElement()..text = "Expand";
        hiderThingy.append(button);
        button.classes.add("fileUploadButton");
        button.onClick.listen((Event e) {
            if( myElement.style.display == "block") {
                myElement.style.display = "none";
                button.text = "Expand";
            }else {
                myElement.style.display = "block";
                button.text = "Collapse";
            }
        });


        container.append(hiderThingy);
        myElement = new DivElement();
        myElement.style.display = "none";
        hiderThingy.append(myElement);
        drawCreatorInput();
        drawFileUploadObjects();
        drawUploadButton();
    }

    void drawUploadButton() {
        ButtonElement uploadButton = new ButtonElement()..text = "Upload To Server To Await Processing";
        myElement.append(uploadButton);
        uploadButton.onClick.listen((Event e) => processUploads());
    }

    void processUploads() {
        DivElement results = new DivElement();
        myElement.append(results);
        String error = checkValidityBeforeUploading();
        if(error == null) {
            //results.text = "TODO: upload this: ${toJSON()}";
            //this way sends a "METHOD"
            /*
            HttpRequest request = new HttpRequest();
            request.open("POST", 'http://192.168.1.65:4046/experiment');
            request.setRequestHeader("Content-Type", "image/png");
            print("about to send post to DM's stuff: $request");
            request.send(toJSON().toString());
            */
            HttpRequest.postFormData("${serverHost}:${serverPort}", toJSON().json).then((HttpRequest request) {

                print("success? $request, ${request.responseText}");
                results.text = "Uploaded Successfully to Server!";
                request.onReadyStateChange.listen((ProgressEvent response) => print("response is ${response.type}"));


            }).catchError((error) {
                results.text = "Server Error uploading doll part.";
                window.alert("Server Error uploading doll part.");
                print("error: $error ${error.target.responseText}");

            });
        }else {
            results.text = "ERROR: $error";
        }
    }

    String checkValidityBeforeUploading() {
        for(FileUploadObject f in fileUploadObjects) {
            print("data is ${f.upload.src}");
            if(f.upload.src == null || f.upload.src.isEmpty || !f.valid) {
                return "Mising Data for ${f.layer}"; //not valid
            }
        }
        return null;
    }

    void drawFileUploadObjects() {
        for(FileUploadObject fio in fileUploadObjects) {
            fio.draw(myElement);
        }
    }
    void drawCreatorInput() {
        DivElement creator = new DivElement();
        myElement.append(creator);
        LabelElement label = new LabelElement()..text = "How You Want To Be Credited:";
        creatorNameInput = new InputElement();
        creatorNameInput.classes.add("uploadInput");

        LabelElement label2 = new LabelElement()..text = "Your Tumblr/Website/Etc:";
        creatorNameWebsite = new InputElement();
        creatorNameWebsite.classes.add("uploadInput");

        creator.append(label);
        creator.append(creatorNameInput);
        creator.append(label2);
        creator.append(creatorNameWebsite);
    }


}

