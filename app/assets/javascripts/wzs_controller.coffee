$ ->
  $('.wz-select').change ->
    year = $('#wz-select-year').val()
    month = $('#wz-select-month').val()
    window.location.href = '/wzs?year=' + year + '&month=' + month

  $("tbody.clickable tr").click ->
    $(@).toggleClass('clicked')
    if $("tbody.clickable tr.clicked").length > 0
      $(".wz-create").text('Stwórz WZ z dzisiaj z zaznaczonych zamówień')
      $(".wz-create").removeAttr('disabled')
    else
      $(".wz-create").text('Zaznacz zamówienia aby stworzyć WZ')
      $(".wz-create").attr('disabled', 'disabled')

  $(".wz-create").click ->
    path = '/wzs'
    orders = []
    $.map $("tbody.clickable tr.clicked"), ( el, i ) ->
      orders.push([$(el).attr('id'), $(el).find('td').last().find('select').val()])

    $.post(path, {orders: orders}, () ->)
      .success ->
        window.location = '/wzs'
