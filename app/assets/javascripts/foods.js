$(function() {
  $('.pantry-tab').click(function(event){
    event.preventDefault();
    $('#pantry-list').css('display', 'block');
    $('#main-list').css('display', 'none');
    $('.empty-list').css('display', 'none');
    $('.pantry-tab').css('border-top', '2px solid #26bb7f');
    $('.pantry-tab').css('border-bottom', '2px solid #26bb7f');
    $('.pantry-tab').css('border-right', '2px solid #26bb7f');
    $('.pantry-tab').css('border-radius', '0px 5px 5px 0px');
    $('.food-list-tab').css('border', 'none');
  });

  $('.food-list-tab').click(function(event){
    event.preventDefault();
    $('#main-list').css('display', 'block');
    $('#pantry-list').css('display', 'none');
    $('.empty-list').css('display', 'block');
    $('.food-list-tab').css('border-top', '2px solid #26bb7f');
    $('.food-list-tab').css('border-bottom', '2px solid #26bb7f');
    $('.food-list-tab').css('border-right', '2px solid #26bb7f');
    $('.food-list-tab').css('border-radius', '0px 5px 5px 0px');
    $('.pantry-tab').css('border', 'none');
  });
});
