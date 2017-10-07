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

	if (getParameterByName("eyes")  == "true"){
    		renderAllEyes();
    		$("#header").html("Eyes");
    	}

    if (getParameterByName("mouths")  == "true"){
            renderAllMouths();
            $("#header").html("Mouths");
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
	var maxHair = 74;
	//don't use canvas, but still layer?  bg, like for KR.
	for(var i = minHair; i<= maxHair; i++){
		renderLayeredSprites([new SpritePart("images/Homestuck/HairBack/"+i+".png", "Hair " +i),new SpritePart("images/Homestuck/Body/head.png", ""), new SpritePart("images/Homestuck/HairTop/"+i+".png", "")]);
	}
}

function renderAllHorns(){
	var minHorn = 0
	var maxHorn = 73;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/LeftHorn/"+i+".png","leftHorn "+i),new SpritePart("images/Homestuck/RightHorn/"+i+".png", "rightHorn" +i)]);
	}
}

function renderAllEyes(){
	var minHorn = 1
	var maxHorn = 73;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/LeftEye/"+i+".png","leftEye "+i),new SpritePart("images/Homestuck/RightEye/"+i+".png", "rightEye" +i)]);
	}
}

function renderAllMouths(){
	var minHorn = 1
	var maxHorn = 73;
	for(var i = minHorn; i<= maxHorn; i++){
			renderLayeredSprites([new SpritePart("images/Homestuck/Body/head.png", ""),new SpritePart("images/Homestuck/Mouth/"+i+".png","mouth "+i)]);
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
