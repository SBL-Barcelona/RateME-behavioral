Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/
	
	jQuery("#NextButton").hide(); 
	
	var i = 0;
	move();
	
	function move() {
		if (i == 0) {
			i = 1;
			var elem = document.getElementsByClassName("bar");
			var width = 1;
			var id = setInterval(frame, 50);
			function frame() {
				if (width >= 100) {
					clearInterval(id);
					i = 0;
					jQuery('#NextButton').click();
				} else {
					width++;
					elem[0].style.width = width + "%";
				}
			}
		}
	}
	
	

});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/

});