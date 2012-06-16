$(document).ready =>
	# dynamically expands text areas
	$('textarea').each ->
		$(this).autogrow({animate : false})
