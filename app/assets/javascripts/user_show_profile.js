$(document).ready(function(){
  $(".hide-btn").click(function(){
    $(this).siblings("h3").hide();
  });
  $(".show-btn").click(function(){
    $(this).siblings("h3").show();
  });
});
