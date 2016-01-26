# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load ready' , ->

  fun = () ->
    if $('#same_as_codon_table').prop('checked')
      # put all as disabled
      $('.codons .codon input').prop('disabled', true)
      $('.codon_table_entries, .remove_prev, #codons-custom').hide()
      $('.add_prev').css('visibility','hidden')
      table_num = $('.codon-table-entry:checked').prop('defaultValue')
      $('.codon_table_' + table_num).show().effect('highlight')
    else
      $('.codons .codon input:visible').removeAttr('disabled')
      $('.codons .codon input:visible')
        .siblings('.remove_prev').show()
      $('.codons').siblings('.add_prev').css('visibility','visible')

  fun()

  $(document).on 'change', '#same_as_codon_table', (event) ->
    fun()

  $(document).on 'change, click', '.codon-table-entry', (event) ->
    fun()

  $(document).on 'click', 'a.show-hidden, div.show-hidden a', (event) ->
    if $(this).parent().is('div.show-hidden')
      t = $(this).parent()
    else
      t = $(this)
    t.hide()
    t.siblings('.hidden').toggle "fold", "down", () ->
      $(this).effect('highlight')
    event.preventDefault()

  $(document).on 'click', 'form .remove_prev', (event) ->
    $(this).parent("div").remove()
    event.preventDefault()


  $(document).on 'click', 'form .add_prev', (event) ->
    # get element
    new_el = $(this).prev(".template").clone()
    # gets the input name (start/stop)
    input_name = new_el.find("input").prop('id')
    # counts the number of codons
    count = $(".codon input").length
    # removes id from div
    new_el.removeAttr('id')
    # enables the input
    new_el.find("input").removeAttr('disabled')
    new_el.removeClass('template')
    # generates the id
    new_el.find("input").prop('id', input_name + "_" + count )
    # generates the name
    new_el.find("input").prop('name', input_name + "[" + count + "]" )
    # append to the codons table
    $(this).siblings(".codons").append(new_el)
    $.validate()
    event.preventDefault()
