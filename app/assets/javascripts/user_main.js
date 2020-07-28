$(function() {
  $(".SideBar__List").on("mouseover", function(){
    $(this).css({"background-color": "#eee"});
  }).on("mouseout", function(){
    $(this).css({"background-color": ""});
  })
})