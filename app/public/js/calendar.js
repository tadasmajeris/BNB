$(function() {
	var dates;

	$.ajax({
		type: 'get',
		dataType: 'json',
		url: '/requests/disabled_dates',
		success: function(response) {

			dates = response.disabledDates;

			$("#calendar").datepicker({
		  	beforeShowDay: function(date) {
		    	var string = jQuery.datepicker.formatDate('dd-mm-yy', date);
					return [dates.indexOf(string) == -1];
		  	} 
			});
		}
	});


	$('#request_date').click(function() {
		$.ajax({
			type: 'post',
			url: '/requests/create',
			data: {date: $('#calendar').val()},
			success: function() {console.log("success")}
		});
	});
});