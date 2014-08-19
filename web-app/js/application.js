$(".presentations").on("click", function(e){
	$(this).parent().next().toggle()
})

$("#invoicePopover").popover({html:true});