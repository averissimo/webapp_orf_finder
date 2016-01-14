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
      div.delay(100).toggle "fold", "down"
      div.dequeue()



  $("#search").on "ajax:error", (e, xhr, status, error) ->
    $("#results").html "<p>ERROR, sorry.</p>"
