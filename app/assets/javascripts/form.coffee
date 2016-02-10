$(document).on 'page:load ready' , ()->

  $("#search").on "ajax:success", (e, data, status, xhr)->
    div = $("#results")
    div.prev('h2')
      .removeClass('gray')
      .removeClass('no-bold')
      .effect('highlight')

    div.queue ()->
      div.toggle "fold", "down", ()->
        div.html(new_data)
        minimized_elements = $('div.sequence')
        minimize_character_count = 50

        minimized_elements.each () ->
          len = $(this).find('.codon').length
          if(len < minimize_character_count )
            return
          # index starts at 0, thefore it needs to be adjusted
          $($(this).find('.codon')[minimize_character_count - 1])
            .after('<span>... </span>' +
                   '<a href="#" class="more">more</a>')
          #
          $(this).find('.codon').slice(minimize_character_count)
            .wrapAll('<span style="display:none;"></span>')
      div.delay(100).toggle "fold", "down"
      div.dequeue()



  $("#search").on "ajax:error", (e, xhr, status, error) ->
    $("#results").html "<p>ERROR, sorry.</p>"
