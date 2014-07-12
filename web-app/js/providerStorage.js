var Component = (function() {
	var init = function() {
		if (localStorage.length) {
			$("#name").val(localStorage.getItem("name"));
			$("#contactName").val(localStorage.getItem("contactName"));
		}
	}

	return {
		init:init
	}
})();

$(document).ready(function() {
	Component.init();

	$("#name").on("change", function() {
		localStorage.setItem("name", $(this).val());
	});

	$("#contactName").on("change", function() {
		localStorage.setItem("contactName", $(this).val());
	});

	$("form#addProvider").on("submit", function() {
		localStorage.clear()
	});
})