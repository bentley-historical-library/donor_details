$(function() {

  var init_donor_form = function(subform) {
    var $subform = $(subform);
    var $checkbox = $(":checkbox[name$=\"[donor_number_auto_generate]\"]", $subform);
    var $donorNumberField = $(":input[name$=\"[donor_number]\"]", $subform);


    var disableDonorNumber = function() {
      $donorNumberField.attr("readonly","readonly");
      $donorNumberField.prop('disabled', true);
      $userEnteredDonorNumberField = $donorNumberField[0].value;
      $donorNumberField[0].value = $checkbox.attr("display_text_when_checked");
    }


    if ($checkbox.is(":checked")) {
      disableDonorNumber();
    }

    $checkbox.change(function() {
      if ($checkbox.is(":checked")) {
        disableDonorNumber();
      } else {
        $donorNumberField.prop('disabled', false);
        $donorNumberField.removeAttr("readonly");
        $donorNumberField[0].value = $userEnteredDonorNumberField;
      }
    });

};


  $(document).bind("subrecordcreated.aspace", function(event, object_name, subform) {
    if (object_name === "donor_detail") {
      init_donor_form($(subform));
    }
  });

});
