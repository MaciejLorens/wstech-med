$ ->
  $(".dashboard-range").change ->
    from = $("#dashboard_search_from").val()
    to = $("#dashboard_search_to").val()
    window.location = '/?from=' + from + '&to=' + to

  $('.search-tag').keyup ->
    query = $(@).val()
    if query.length > 0
      $(".main-body").hide()
      $.get('/search', {query: query}, () ->
      ).success (result) ->
        $(".search-results").html(result)
        $(".search-results").show()
    else if query.length == 0
      $(".search-results").hide()
      $(".main-body").show()
