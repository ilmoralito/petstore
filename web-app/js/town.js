var Town = (function() {
	var init = function(city) {
		$.ajax({
			type:"GET",
			url:"/provetnicsa/client/townsByCity/" + city,
			data:{city:city},
			dataType:"JSON",
			success:function(res) {
				var town = $("#town");

				town.find("option").remove();
				for (var i = res.length - 1; i >= 0; i--) {
					var opt = $("<option>", {value:res[i], text:res[i], selected:res[i] === localStorage.town});
					town.append(opt)
				};
			}
		});
	}

	return {
		init:init
	}
})();

$(document).ready(function() {
	Town.init($("#city").val())

	$("#city").on("change", function(){
		Town.init($(this).val())
	});
});
