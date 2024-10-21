Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	/*Place your JavaScript here to run when the page is fully displayed*/

	let i = Math.random();

	if(i>0.5) {
		Qualtrics.SurveyEngine.setEmbeddedData("group", "inclusion");
	} else {
		Qualtrics.SurveyEngine.setEmbeddedData("group", "exclusion");
	}


});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/

});