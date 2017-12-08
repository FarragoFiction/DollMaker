//simple code that allows you to browser hair/horns or fanart.
window.onload = function() {
    console.log ("hellow world");
	if (getParameterByName("hair")  == "true"){
		$("#header").html("Hair");
		renderAllHair();
	}
	if (getParameterByName("horns")  == "true"){
		renderAllHorns();
		$("#header").html("Horns");
	}

	if (getParameterByName("paint")  == "true"){
    		renderAllPaint();
    		$("#header").html("FacePaint");
    }



	if (getParameterByName("fins")  == "true"){
    		renderAllFins();
    		$("#header").html("Fins");
    	}

	if (getParameterByName("eyes")  == "true"){
    		renderAllEyes();
    		$("#header").html("Eyes");
    	}

    if (getParameterByName("mouths")  == "true"){
            renderAllMouths();
            $("#header").html("Mouths");
    }

     if (getParameterByName("consorts")  == "true"){
                renderAllConsorts();
                $("#header").html("consorts");
        }

    if (getParameterByName("bodies")  == "true"){
                renderAllBodies();
                $("#header").html("Bodies");
    }

    if (getParameterByName("symbols")  == "true"){
        renderAllSymbols();
        $("#header").html("Symbols");
    }

     if (getParameterByName("canonsymbols")  == "true"){
            renderAllCanonSymbols();
            $("#header").html("Canon Troll Symbols");
        }

    if (getParameterByName("glasses")  == "true"){
        renderAllGlasses();
        $("#header").html("Glasses");
    }

    if (getParameterByName("glasses2")  == "true"){
            renderAllGlasses2();
            $("#header").html("Glasses2");
        }



}

function getParameterByName(name, url) {
    if (!url) {
      url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function getRawParameterByName(name, url) {
    if (!url) {
      url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return results[2];
}




//use ajax to get index file, then do yo thang.
//https://stackoverflow.com/questions/22061073/how-do-i-get-images-file-name-from-a-given-folder
function renderAllImagesInFolder(folder){
	console.log("tring to get folder: " + folder)
	var fileExt = {};
    fileExt[0]=".png";
    fileExt[1]=".jpg";
    fileExt[2]=".gif";
		fileExt[3]=".jpeg";
		$.ajax({
			//This will retrieve the contents of the folder if the folder is configured as 'browsable'
			url: folder,
			success: function (data) {
			   //List all png or jpg or gif file names in the page
			   $(data).find("a:contains(" + fileExt[0] + "),a:contains(" + fileExt[1] + "),a:contains(" + fileExt[2] + ")").each(function () {
				  var split = this.href.split("/")
					var filename =  split[split.length-1];
					console.log("found: " + filename);
					//var filename = this.href;
				   renderRegularSprite(new SpritePart(folder+filename, filename));
			   });
			 }

		  });
}

function renderRegularSprite(spritePart){
	$("#images").append("<div class = 'spriteParentNoSize'><img class = 'spriteImgNoLayers' src = '" + spritePart.location + "'></img><br>"+spritePart.name+"</div>");
}


function renderAllHair(){
	var minHair = 0;
	var maxHair = 120;
	//don't use canvas, but still layer?  bg, like for KR.
	for(var i = minHair; i<= maxHair; i++){
		renderLayeredSprites([new SpritePart("images/Homestuck/HairBack/"+i+".png", "Hair " +i),new SpritePart("images/Homestuck/Body/head.png", ""), new SpritePart("images/Homestuck/HairTop/"+i+".png", "")]);
	}
}

function renderAllHorns(){
	var minHorn = 0
	var maxHorn = 102;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/LeftHorn/"+i+".png","leftHorn "+i),new SpritePart("images/Homestuck/RightHorn/"+i+".png", "rightHorn" +i)]);
	}
}

function renderAllEyes(){
	var minHorn = 1
	var maxHorn = 100;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/LeftEye/"+i+".png","leftEye "+i),new SpritePart("images/Homestuck/RightEye/"+i+".png", "rightEye" +i)]);
	}
}


function renderAllFins(){
	var minHorn = 1
	var maxHorn = 100;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/RightFin/"+i+".png","fin "+i),new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/LeftFin/"+i+".png", "fin" +i)]);
	}
}

function renderAllPaint(){
	var minHorn = 1
	var maxHorn = 49;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/FacePaint/"+i+".png","paint "+i)]);
	}
}


function renderAllMouths(){
	var minHorn = 1
	var maxHorn = 49;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/Mouth/"+i+".png","mouth "+i)]);
	}
}

function renderAllConsorts(){
	var minHorn = 0
	var maxHorn = 18;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Consort/"+i+".png","consort "+i)]);
	}
}

function renderAllGlasses(){
	var minHorn = 1
	var maxHorn = 100;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/Glasses/"+i+".png","accessory "+i)]);
	}
}

function renderAllGlasses2(){
	var minHorn = 1
	var maxHorn = 100;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/Glasses2/"+i+".png","accessory "+i)]);
	}
}

function renderAllBodies(){
	var minHorn = 0
	var maxHorn = 130;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/"+i+".png","body "+i)]);
	}
}

function bloodcolor(imgNumber){
     var bloodColors = ["burgundy", "bronze", "gold", "lime", "olive", "jade", "teal", "cerulean", "indigo", "purple", "violet", "fuchsia"];
        varchosenBlood = "";
        if(imgNumber <= 24) {
            chosenBlood = bloodColors[0];
        }else if(imgNumber <= 24*2) {
            chosenBlood = bloodColors[1];
        }else if(imgNumber <= 24*3) {
            chosenBlood = bloodColors[2];
        }else if(imgNumber <= 24*4) {
            chosenBlood = bloodColors[3];
        }else if(imgNumber <= 24*5) {
            chosenBlood = bloodColors[4];
        }else if(imgNumber <= 24*6) {
            chosenBlood = bloodColors[5];
        }else if(imgNumber <= 24*7) {
            chosenBlood = bloodColors[6];
        }else if(imgNumber <= 24*8) {
            chosenBlood = bloodColors[7];
        }else if(imgNumber <= 24*9) {
            chosenBlood = bloodColors[8];
        }else if(imgNumber <= 24*10) {
            chosenBlood = bloodColors[9];
        }else if(imgNumber <= 24*11) {
            chosenBlood = bloodColors[10];
        }else if(imgNumber <= 24*12) {
            chosenBlood = bloodColors[11];
        }
        //it's just random if it somehow doesn't fit
        return chosenBlood;
}

function renderAllSymbols(){
	var minHorn = 0
	var maxHorn = 255;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Symbol/bg.png", ""),new SpritePart("images/Homestuck/Symbol/"+i+".png", "symbol "+i)]);
	}
}

function renderAllCanonSymbols(){
	var minHorn = 0
	var maxHorn = 288;
	for(var i = minHorn; i<= maxHorn; i++){
		        var chosenBlood = bloodcolor(i);
			renderLayeredSprites([new SpritePart("images/Homestuck/Symbol/bg.png", ""),new SpritePart("images/Homestuck/CanonSymbol/"+i+".png",chosenBlood+" canon symbol "+i)]);
	}
}

//first thing on bottom, last thing on top
function renderLayeredSprites(spriteArray){
	var html = "<div class = 'spriteParent'>"; //all images should be rendered at same position in sprite parent
	for(var i = 0; i<spriteArray.length; i++){
		html += "<img class = 'spriteImg' src = '" + spriteArray[i].location + "'></img><br>"+spriteArray[i].name;
	}
	html += "</div>"
	$("#images").append(html);
}


function SpritePart(location, name){
	this.location = location;
	this.name = name;
}
