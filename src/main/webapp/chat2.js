/**
 * 
 */
function autoClosingAlert(selector, delay){
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {alert.hide() }, delay);
	}
	function submitFunction(){
		var fromID = '<%= userID %>';
		var toID = '<%= toID %>';
		var chatContent = $('#chatContent').val();
		$.ajax({
			type: "POST",
			url: "./chatSubmitServlet",
			data: {
				fromID: encodeURIComponent(fromID),
				toID: encodeURIComponent(toID),
				chatContent: encodeURIComponent(chatContent),
			},
			success: function(result){
				if(result == 1) {
					autoClosingAlert('#successMessage', 2000);
				}else if(result == 0){
					autoClosingAlert('#dangerMessage', 2000);
				}else{
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		});
		$('#chatContent').val("");
	}