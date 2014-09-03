# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
	providers = $('#bill_provider_id').html()
	setProviderCategory = -> 
		category = $('#categories :selected').text()
		options = $(providers).filter("optgroup[label='#{category}']").html()
		if options 
			$('#bill_provider_id').html(options)
			$('#bill_provider_id').parent().show()
		else
			$('#bill_provider_id').empty()
			$('#bill_provider_id').parent().hide()
	$('#categories').change setProviderCategory
	setProviderCategory()
	
	$('#bill_duedate').datepicker
		dateFormat: 'yy-mm-dd'