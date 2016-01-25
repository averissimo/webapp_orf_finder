# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:load ready' , ->

  $(document).on 'click', '.show-hidden', (event) ->
    $(this).hide()
    $(this).siblings('.hidden').toggle "fold", "down", () ->
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
    count = $(this).siblings(".codons").children().length
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
