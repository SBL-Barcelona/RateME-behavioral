Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/
	
	let avatar =  document.getElementsByClassName('profileAvatar');
	let avatarList = Qualtrics.SurveyEngine.getEmbeddedData("botsAvatar");
	
	avatar[0].src = avatarList[0]; // Change i in avatarList[i] to get the different bot avatars
	
	let name = document.getElementsByClassName('botName');
	let nameList = Qualtrics.SurveyEngine.getEmbeddedData("botsName");
	
	name[0].innerHTML = nameList[0]; // Change i in nameList[i] to get the different bot names

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/

	jQuery("#NextButton").hide();  

	let nameObj = document.getElementsByClassName('botName');
	const name = nameObj[0].innerHTML;

	var scores = {};

	const ratingStars =  document.getElementsByClassName('rateContainer');
	const starClassActive = "rating__star fas fa-star";
    const starClassUnactive = "rating__star far fa-star";

	for (let i=0; i<ratingStars.length; ++i) {
		let starBox = ratingStars[i]
		let stars = starBox.querySelectorAll(".rating__star");
		let starsLength = stars.length;

		stars.forEach(star => {
			star.addEventListener("click", changeStars);
		})
	}


	function changeStars(event) {

		let starBox = event.target.closest(".rating");
		let stars = [...starBox.querySelectorAll(".rating__star")];
		k = stars.indexOf(event.target);

		let question= starBox.closest(".questionContainer");
		let score = Qualtrics.SurveyEngine.getEmbeddedData(question.id);
		score[name] = k;
		scores[question.id] = score;

		if (event.target.className.indexOf(starClassUnactive) !== -1) {
			for (k; k >= 0; --k) stars[k].className = starClassActive;
		} else {
			for (k; k < stars.length; ++k) stars[k].className = starClassUnactive;
		}

		if(Object.keys(scores).length === 6) {
			jQuery('#NextButton').show();
		}

	}
	
	
	this.questionclick = function(event,element) {
        if (element.id == 'NextButton') {
			scores.forEach(([key, value]) => {
                Qualtrics.SurveyEngine.setEmbeddedData(key, value);
			});
		}
	}
	

});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/
	

});