$(document).ready(function() {
	var dates;
	var availableUrl = window.location.pathname.replace('/spaces','/available_dates');
	$('#request_date').prop('disabled', true);

	$.ajax({
		type: 'get',
		dataType: 'json',
		url: availableUrl,

		success: function(response) {
			dates = response.availableDates;

			$("#calendar").datepicker({
				dateFormat: 'dd/mm/yy',
		  	beforeShowDay: function(date) {
		    	var string = jQuery.datepicker.formatDate('dd/mm/yy', date);
					return [dates.indexOf(string) >= 0];
		  	},
				onSelect: function(){
					$('#request_date').prop('disabled', false);
				}
			});
		}
	});

	$('#request_date').click(function() {
		$('#hidden_input').attr('value', $('#calendar').val());
	});
});
