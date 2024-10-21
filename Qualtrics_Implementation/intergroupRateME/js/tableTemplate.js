Qualtrics.SurveyEngine.addOnload(function()
{
        /*Place your JavaScript here to run when the page loads*/

        let playerName = "${q://QID57/ChoiceTextEntryValue}"; //Edit QID57 here with the ID of the player name question
        let nameField = document.getElementById("playerName");
        nameField.innerHTML = playerName;

});


Qualtrics.SurveyEngine.addOnReady(function()
{
        /*Place your JavaScript here to run when the page is fully displayed*/

        jQuery("#NextButton").hide();

        const scores = Qualtrics.SurveyEngine.getEmbeddedData('scores_q1'); // Change i in "scores_qi" to show the scores of diffent questions
        const group = Qualtrics.SurveyEngine.getEmbeddedData('group');

        const ratingStars =  document.getElementsByClassName('rateContainer');
        const starClassActive = "rating__star fas fa-star";
    	const starClassUnactive = "rating__star far fa-star";

        var clickedGroups = [];

        const playersRates = {};
        const groups = ["Belgium","France","Netherlands","Italy","Spain","Germany"]; // Change here the name of the groups

        for(var i = 0; i < 6; i++) {


                let rates = [];
                for(var j = 0; j < ratingStars.length; j++) {

                        if(i!==j) {
                                if(groups[i]!=="Spain") {
                                        if(groups[j]==="Spain" && group==="exclusion") {
                                                rates[j] = Math.round(Math.random());
                                        } else {
                                                rates[j] = Math.round(2 * Math.random() + 2);
                                        }
                                } else {
                                        rates[j] = scores[groups[j]];
                                }
                        } else {
                                rates[j] = -2;
                        }
                }
                playersRates[groups[i]] = rates;

        }
	
	const subtext = document.getElementsByClassName("subtext")[0];
        const flags = document.getElementsByClassName("flag");

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
                let nameGroup =  chair.querySelector('.flag');
                nameGroup = nameGroup.alt;

                let ratingPlayer =  playersRates[nameGroup];
                dispButton(nameGroup);

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
                var elements = document.getElementsByClassName("flag");
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
                if(starBox.style.visibility==="hidden"){
                        starBox.style.visibility = "visible";
                }
                let stars = starBox.querySelectorAll(".rating__star");
                let starsLength = stars.length;
                for (i = 0; i < starsLength; ++i) stars[i].className = starClassUnactive;
        }

        function dispButton(nameGroup) {

                if(!clickedGroups.includes(nameGroup)) {
                        clickedGroups[clickedGroups.length] = nameGroup;
                }

                if (clickedGroups.length===6) {
                        jQuery("#NextButton").show();
                }

        }


});


Qualtrics.SurveyEngine.addOnUnload(function()
{
        /*Place your JavaScript here to run when the page is unloaded*/

});
