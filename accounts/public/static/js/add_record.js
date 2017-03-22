$(document).ready(function(){
	$(".record_fields_order_type button").click(function(){
		$(this).siblings().removeClass("active").addClass("nonactive");
		$(this).removeClass("nonactive").addClass("active");
		$("#order_type").val($(this).attr("order_type"));
		swiper2($(this).attr("order_type"));
	})
	$(".record_fields_tid .swiper-wrapper .swiper-slide").click(function(){
		if($(this).html()){
			$(this).addClass("tid-active").siblings().removeClass("tid-active");
			$("#tid").val($(this).attr("tid"));
		}
	})
	$(".record_fields_payment .swiper-wrapper .swiper-slide").click(function(){
		if($(this).html()){
			$(this).addClass("tid-active").siblings().removeClass("tid-active");
			$("#payment_id").val($(this).attr("payment_id"));
		}
	})
	$("input[type='number']").each(function(i, el) {
		el.type = "text";
		el.onfocus = function() { this.type="number" };
		el.onblur = function() { this.type="text" };
	});
})
var swiper = new Swiper('.swiper-container-0', {
	pagination: '.swiper-pagination',
	slidesPerView: 5,
	paginationClickable: true,
	spaceBetween: 5,
	freeMode: true
});
var swiper = new Swiper('.swiper-container-payment', {
	pagination: '.swiper-pagination',
	slidesPerView: 5,
	paginationClickable: true,
	spaceBetween: 5,
	freeMode: true
});
function swiper2(obj){
		
	if(parseInt(obj) == 0){
		$(".swiper-container-1").css("display","none");
	}
	if(parseInt(obj) == 1){
		$(".swiper-container-0").css("display","none");
	}
	$(".swiper-container-"+parseInt(obj)).css("display","block");
	var tid = $(".swiper-container-"+parseInt(obj)+" .tid-active").attr("tid");
	$("#tid").val(tid);

	var swiper = new Swiper('.swiper-container-'+parseInt(obj), {
		pagination: '.swiper-pagination',
		slidesPerView: 5,
		paginationClickable: true,
		spaceBetween: 5,
		freeMode: true
	});
}