$(function() {
	var dates;

	$.ajax({
		type: 'get',
		dataType: 'json',
		url: '/requests/disabled_dates',
		success: function(response) {

			dates = response.disabledDates;

			$("#calendar").datepicker({
				dateFormat: 'dd/mm/yy',
		  	beforeShowDay: function(date) {
		    	var string = jQuery.datepicker.formatDate('dd/mm/yy', date);
					return [dates.indexOf(string) >= 0];
		  	}
			});
		}
	});

	$('#request_date').click(function() {
		$('#hidden_input').attr('value', $('#calendar').val());
	});
});
