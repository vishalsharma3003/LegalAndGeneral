$(function () {
  // select the first tab by default
  $('.nav.side-menu')[0].setAttribute('id','main_tabset')
  $('.side-menu li:eq(0) a').tab('show');

 $('.nav.side-menu li:eq(0)').addClass('active');
 
  // add the class active to the first body element
  
$('.tab-pane:eq(0)').addClass('active');

});
