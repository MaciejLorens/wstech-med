$ ->
  $('.wz-select').change ->
    year = $('#wz-select-year').val()
    month = $('#wz-select-month').val()
    window.location.href = '/wzs?year=' + year + '&month=' + month
