$(function(){

  $("input[type='checkbox']").click(function(event){
    event.stopPropagation();
    if ($(this).attr('checked')){
      $(this).removeAttr('checked')
    }
    else {
      $(this).attr('checked', 'checked')
    }
  });


  $("input[value='Submit']").click(function(event){
    event.preventDefault();
    event.stopPropagation();
    var form = $(this).parents('form')[0]
    var form_data = {
      authenticity_token:
      form.querySelectorAll('input')[2].getAttribute('value'),
      id:
      form.action.split('/')[4],
      name:
      $(form.querySelectorAll('fieldset')[0].querySelector("input[type='text']")).val(),
      vegan: form.querySelectorAll('fieldset')[1].querySelector("input[type='checkbox']").hasAttribute('checked'),
      veg: form.querySelectorAll('fieldset')[2].querySelector("input[type='checkbox']").hasAttribute('checked'),
      gluten_free: form.querySelectorAll('fieldset')[3].querySelector("input[type='checkbox']").hasAttribute('checked'),
      dairy_free: form.querySelectorAll('fieldset')[4].querySelector("input[type='checkbox']").hasAttribute('checked'),
      nut_free: form.querySelectorAll('fieldset')[5].querySelector("input[type='checkbox']").hasAttribute('checked'),
      pescatarian: form.querySelectorAll('fieldset')[6].querySelector("input[type='checkbox']").hasAttribute('checked'),
      preferred:
      form.querySelectorAll('fieldset')[7].querySelector("input[type='checkbox']").hasAttribute('checked')
    }
    $.ajax({
      type: 'PUT',
      url: form.action,
      datatype: "JSON",
      data: form_data
    }).done(function(){
      form.querySelectorAll('fieldset')[0].setAttribute('style', 'border-color: green');
    });
  });

  $("input[value='Remove']").click(function(event){
    event.preventDefault();
    event.stopPropagation();
    var form = $(this).parents('form')[0];
    var form_data = {
      authenticity_token:
      form.querySelectorAll('input')[2].getAttribute('value'),
      id:
      form.action.split('/')[4]
    }
    $.ajax({
      type: 'DELETE',
      url: form.action,
      datatype: "JSON",
      data: form_data
    }).done(function(){
      form.parentElement.remove();
    });
  });

});
