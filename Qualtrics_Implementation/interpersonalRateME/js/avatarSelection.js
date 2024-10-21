Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/
	
	jQuery("#NextButton").hide(); 

	const avatars = document.getElementsByClassName("avatar");
	
	for(var i = 0; i < avatars.length; i++) {
		avatars[i].addEventListener("click", clickStyle)
		avatars[i].addEventListener("mouseout",mouseoutStyle)
		avatars[i].addEventListener("mouseover",mouseoverStyle)
	}	
	
	function mouseoverStyle(e) {
		if (!e.target.clicked) {
			e.target.style.cursor = "pointer";
			e.target.style.transform = "scale(1.05)";
		}  
	}

	function mouseoutStyle(e) {
		if (!e.target.clicked) {
			e.target.style.cursor = "default";
			e.target.style.transform = "scale(1)";
        }
	}

	function clickStyle(e) {
		evaluateButtons();
		e.target.style.transform = "scale(1.05)";
		e.target.style.cursor = "default";
		e.target.style.boxShadow = "0px 0px 7px 7px #a9a9a9";
		e.target.clicked = true;
		
		Qualtrics.SurveyEngine.setEmbeddedData("playerAvatar",e.target.src);
		saveAvatarList();
		jQuery("#NextButton").show();
	}
	
	
	function evaluateButtons() {
		var elements = document.getElementsByClassName("avatar");
		var clicked = false;
		for (var i = 0; i < elements.length; i++) {
			if (elements[i].clicked) {
				elements[i].style.transform = "scale(0.95)";
				elements[i].style.boxShadow= "0 5px #2c2c2c";
				elements[i].clicked = false;
			}
		}
	}
	
	
	function saveAvatarList() {
		var avatarList = Array(0);
		var botsName = Array(0);
		var elements = document.getElementsByClassName("avatar");
		for (var i = 0; i < elements.length; i++) {
			if (!elements[i].clicked) {
				avatarList.push(elements[i].src);
				botsName.push(elements[i].alt);
			}
		}
		
		Qualtrics.SurveyEngine.setEmbeddedData("botsAvatar",avatarList);
		Qualtrics.SurveyEngine.setEmbeddedData("botsName",botsName);
	}
	

});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/

});