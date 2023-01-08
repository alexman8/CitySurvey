/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@rails/ujs").start()

require("@nathanvda/cocoon")

$(document).ready(function() {
  $("#form-inputs-container a.add_fields").
    data("association-insertion-method", "append").
    data("association-insertion-node", "#form-fields-container");

  $("#form-field-options-container a.add_fields").
    data("association-insertion-method", "append").
    data("association-insertion-node", function(link) {
      return link.parent().siblings(".form-field-options-list")
    });

  $('#form-fields-container').on('cocoon:after-insert', function(e, insertedItem, _originalEvent) {
    insertedItem.find("[id^=form_form_fields_attributes_][id$=_type]").change(function() {
      bindShowHideBehavior($(this));
    }).change(); // Call change immediately to show/hide the form field option container
  });

  $("[id^=form_form_fields_attributes_][id$=_type]").change(function() {
    bindShowHideBehavior($(this));
  }).change();

  $('.form-field-options-list').on('cocoon:after-insert', function(e, insertedItem, _originalEvent) {
    insertedItem.find("input").focus();
  });
})

function bindShowHideBehavior(selectElement) {
  let optionValue = selectElement.val();
  let formFieldOptionContainer = selectElement.parent().siblings("#form-field-options-container");
  switch(optionValue) {
    case 'text':
    case 'textarea':
      formFieldOptionContainer.hide();
      break;
    case 'radio':
    case 'checkbox':
    case 'drop_down':
      formFieldOptionContainer.show();
      break;
  }
}