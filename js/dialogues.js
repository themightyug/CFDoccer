/*
	Sets dialogues to 'working...' when submitted
	
	ross, 27/04/2013, creation
*/


$(document).ready(function() {
	$(".dialogue").each(function() {
		var button = $(this).find("[type='submit']");
		button.click(function(e) {
			$(this).parent().parent().children(":not(.working)").each(function() {
				$(this).hide();
			});
			$(this).parent().parent().children(".working").each(function() {
				$(this).show();
			});
			return true;
		});
	});
});