Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/
	

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/
	
	jQuery("#NextButton").hide();  
	
	const countries = ["Belgium","France","Netherlands","Italy","Spain","Germany"]; // Edit the name of the outgroups here
	const scores = {};
	
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

		let flag= starBox.closest(".chair").querySelector(".flag");
		scores[flag.alt] = k;

		if (event.target.className.indexOf(starClassUnactive) !== -1) {
			for (k; k >= 0; --k) stars[k].className = starClassActive;
		} else {
			for (k; k < stars.length; ++k) stars[k].className = starClassUnactive;
		}

		if(Object.keys(scores).length===5) {
			jQuery('#NextButton').show();
			Qualtrics.SurveyEngine.setEmbeddedData("scores_q1", scores); // Change i in "scores_qi" to set the scores of diffent questions
		}

	}


});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/
	

});
