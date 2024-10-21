Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/
	
	let avatars =  document.getElementsByClassName('avatar');
	let avatarList = Qualtrics.SurveyEngine.getEmbeddedData("botsAvatar");
	
	let names = document.getElementsByClassName('name');
	let nameList = Qualtrics.SurveyEngine.getEmbeddedData("botsName");
	
	for (let i=0; i<avatars.length; ++i) {
		if (avatars[i].alt==="player") {
			let playerAvatar = Qualtrics.SurveyEngine.getEmbeddedData("playerAvatar");
			avatars[i].src = playerAvatar;

			let playerName = "${q://QID58/ChoiceTextEntryValue}"; // Edit here with the ID of Player Name
			names[i].innerHTML = playerName;
		} else {
			avatars[i].src = avatarList[i];
			names[i].innerHTML = nameList[i];
		}
	}
	
	
});


Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/

	jQuery("#NextButton").hide(); 
	
	const scores = Qualtrics.SurveyEngine.getEmbeddedData('scores_q1'); // Change i in 'scores_qi' to get the scores in the different questions
	const group = Qualtrics.SurveyEngine.getEmbeddedData('group');
	
	const ratingStars =  document.getElementsByClassName('rateContainer');
	const starClassActive = "rating__star fas fa-star";
    const starClassUnactive = "rating__star far fa-star";
	
	var clickedPlayers = [];
	
	const playersRates = {};
	const names = document.getElementsByClassName('name');
	
	
	for(var i = 0; i < 6; i++) {
		
		let rates = [];
		for(var j = 0; j < ratingStars.length; j++) {

			if(i!==j) {
				if(names[i].id!=="playerName") {
					if(names[j].id==="playerName" && group==="exclusion") {
						rates[j] = Math.round(2 * Math.random());
					} else {
						rates[j] = Math.round(2 * Math.random() + 2);
					}
				} else {
					rates[j] = scores[names[j].innerHTML];
				}
			} else {
				rates[j] = -2;
			}
		}	
		playersRates[names[i].innerHTML] = rates;

	}

	
	const subtext = document.getElementsByClassName("subtext")[0];	
	const flags = document.getElementsByClassName("avatar");
	
	for(var i = 0; i < flags.length; i++) {
		flags[i].addEventListener("click", clickStyle)
		flags[i].addEventListener("mouseout",mouseoutStyle)
		flags[i].addEventListener("mouseover",mouseoverStyle)
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
            e.target.style.transform = "scale(0.95)";
        }
    }

	function clickStyle(e) {
		evaluateButtons();
		e.target.style.transform = "scale(1.05)";
		e.target.style.cursor = "default";
		e.target.style.boxShadow = "0px 0px 7px 7px #a9a9a9";
		e.target.clicked = true;
		let chair = e.target.parentElement.parentElement;
		let namePlayer =  chair.querySelector('.name');
		namePlayer = namePlayer.innerHTML;
		
		let ratingPlayer =  playersRates[namePlayer];		
		dispButton(namePlayer);
		
		for(var j = 0; j < ratingPlayer.length; j++) {
			resetStars(ratingStars[j]);
			if(ratingPlayer[j]>-1) {
				changeStars(ratingStars[j],ratingPlayer[j]);
			} else if(ratingPlayer[j]<-1) {
				ratingStars[j].style.visibility = "hidden";
			}
		}
		
		changeSubtext(chair);
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
	
	function changeSubtext(chair) {
		let namePlayer =  chair.querySelector('.name');
		if (namePlayer.innerHTML!="Yo"){
			subtext.innerHTML = "You are seeing "+namePlayer.innerHTML+"'s ratings";
		} else {
			subtext.innerHTML = "You are seeing your ratings";
		}
	}
	
	function changeStars(starBox,rate) {
		
		let stars = starBox.querySelectorAll(".rating__star");
		let star = stars[rate];
		let starsLength = stars.length;
		
		if (star.className.indexOf(starClassUnactive) !== -1) {
			for (rate; rate>= 0; --rate) stars[rate].className = starClassActive;
		} else {
			for (rate; rate < starsLength; ++rate) stars[rate].className = starClassUnactive;
		}
			
	}
	
	function resetStars(starBox) {
		if(starBox.style.visibility === "hidden"){
			starBox.style.visibility = "visible";
		}
		let stars = starBox.querySelectorAll(".rating__star");
		let starsLength = stars.length;
		for (i = 0; i < starsLength; ++i) stars[i].className = starClassUnactive;
	}
	
	function dispButton(namePlayer) {
		
		if(!clickedPlayers.includes(namePlayer)) {
			clickedPlayers[clickedPlayers.length] = namePlayer;
		}
		
		if (clickedPlayers.length === 6) {
			jQuery("#NextButton").show(); 
		}
		
	}

	
});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/

});