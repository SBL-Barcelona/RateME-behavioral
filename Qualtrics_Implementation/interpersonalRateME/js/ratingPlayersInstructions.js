Qualtrics.SurveyEngine.addOnload(function()
{
	/*Place your JavaScript here to run when the page loads*/

});

Qualtrics.SurveyEngine.addOnReady(function()
{
	//Place your JavaScript here to run when the page is fully displayed
	
	if(Math.random()>0.5) {
        var group = "inclusion";
	} else {
		var group = "exclusion";
	}
	
	Qualtrics.SurveyEngine.setEmbeddedData("group", group);
	
	let list  = {};
	for (let i=1; i<7; ++i) {
		Qualtrics.SurveyEngine.setEmbeddedData("scores_q"+i, list);
	}

});

Qualtrics.SurveyEngine.addOnUnload(function()
{
	/*Place your JavaScript here to run when the page is unloaded*/

});