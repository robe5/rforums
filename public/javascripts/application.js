$(document).ready(function(){
	// Category's actions
	$('.category').hover(function(){
		$(this).find('.actions').show();
	}, function(){
		$(this).find('.actions').hide();
	});
	
});