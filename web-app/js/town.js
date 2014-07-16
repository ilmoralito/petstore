var Town = (function() {
	var init = function(city) {
		$.ajax({
			type:"GET",
			url:"townsByCity/" + city,
			data:{city:city},
			dataType:"JSON",
			success:function(res) {
				var town = $("#town");
				var clientTown = localStorage.town || $("#clientTown").val();

				town.find("option").remove();

				for (var i = res.length - 1; i >= 0; i--) {
					var opt = $("<option>", {value:res[i], text:res[i], selected:res[i] === clientTown});

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
