var disableddates = ["21-11-2016", "22-11-2016", "23-11-2016", "24-11-2016"];


function DisableSpecificDates(date) {
	var string = jQuery.datepicker.formatDate('dd-mm-yy', date);
		return [disableddates.indexOf(string) == -1];
}

function getDisabledDates() {
	$.ajax({
		type: 'get',
		dataType: 'json',
		url: '/requests/example',
		success: function(response) {
			console.log(response.disabledDates)
		}
	});
}

$(function() {

	$("#calendar").datepicker({
  	beforeShowDay: DisableSpecificDates,
	});

	$('#request_date').click(function() {
		$.ajax({
			type: 'post',
			url: '/requests/example',
			data: {date: $('#calendar').val()},
			success: function() {console.log("success")}
		});
	});
});