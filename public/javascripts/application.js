$(document).ready(function(){
	// New Category
	$('#new-category, #cancel-new-category').live('click', function(evt){
		evt.preventDefault();
		$('#category-new-form')
			.toggle()
			.find('input[type=text]')
			.attr('value', '')
			.first().focus();
		$('.actions').toggle();
	});
	
	// Edit Category
	$('.action-edit, .action-cancel').live('click', function(evt){
		evt.preventDefault();
		var category_id = $(this).attr('data-category');
		$('#category-'+category_id+' .category-name').toggle();
		$('#category-'+category_id+' .category-update-form')
			.toggle()
			.find('input[type=text]').first.focus();
	});
	
$(this).parents('.category-update-form').hide();
	
	// Category's actions
	$('.category').hover(function(){
		$(this).find('.actions').show();
	}, function(){
		$(this).find('.actions').hide();
	});
	
});