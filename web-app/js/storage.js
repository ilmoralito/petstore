var Component = (function(){
	var init = function() {
		if (localStorage.length) {
			$("#fullName").val(localStorage.fullName);
			$("#storeName").val(localStorage.storeName);
			$("#address").val(localStorage.address);
			$("#city").val(localStorage.city);
		}
	}

	clearClientStorage = function() {
		localStorage.clear()
	}

	return {
		init:init,
		clearClientStorage:clearClientStorage
	}
})();

$(document).ready(function(){
	Component.init();

	$("#fullName").change(function(){
		localStorage.setItem("fullName", $(this).val())
	})

	$("#storeName").change(function(){
		localStorage.setItem("storeName", $(this).val())
	})

	$("#address").change(function(){
		localStorage.setItem("address", $(this).val())
	})

	$("#city").change(function(){
		localStorage.setItem("city", $(this).val())
	})

	$("#addNewClientForm").on("submit", function(e){
		Component.clearClientStorage();
	})
});
