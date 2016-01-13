
$(document).on 'page:load ready' , ->
  $.formUtils.addValidator {
    name : 'atcg'
    validatorFunction : (value, $el, config, language, $form) ->
      # characters other than atcg are valid
      !RegExp("([^a^t^c^g])").test(value)
    errorMessage : 'Sequence must only have: \'a\', \'t\', \'c\' or \'g\''
    errorMessageKey: 'badSequence'
  }

  $.formUtils.addValidator {
    name : 'codon'
    validatorFunction : (value, $el, config, language, $form) ->
      # characters other than atcg are valid
      value.length == 3
    errorMessage : 'Codon must have 3 nucleotides (example: \'atg\').'
    errorMessageKey: 'badCodon'
  }

  $.validate()

  $('input, textarea').validate()
