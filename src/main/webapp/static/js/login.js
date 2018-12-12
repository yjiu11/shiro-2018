$("#btn_sign").click(function() {
	var formDate = $("form").serializeArray();
	$.ajax({
		url : $.getAppPath()+'/login',
		type : 'POST',
		data : formDate,
		success : function(result) {
			alert(result.msg);
		}
	});
})