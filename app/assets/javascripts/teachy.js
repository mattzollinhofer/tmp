$(document).ready(function(){
  $('.chosen-select').chosen();
  $('.datepicker').datepicker({
    onSelect: function(){
      $(":input:eq(" + ($(":input").index(this) + 1) + ")").focus();
    }
  });
});
