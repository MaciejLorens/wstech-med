$ ->
  $(".dashboard-range").change ->
    from = $("#dashboard_search_from").val()
    to = $("#dashboard_search_to").val()
    window.location = '/?from=' + from + '&to=' + to
