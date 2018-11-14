# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  setTimeout ->
    $(".alert").fadeOut(500)
  , 1200

  $('.datepicker').datepicker({
    format: 'dd-mm-yyyy',
    autoclose: true,
    language: 'pl'
  });

  $('.order-select').change ->
    year = $('#order-select-year').val()
    month = $('#order-select-month').val()
    window.location.href = '/orders/delivered?year=' + year + '&month=' + month

  $('.search_tag').keyup ->
    query = $(@).val()
    if query.length > 2
      $(".main-body").hide()
      $.get('/search', {query: query}, () ->
      ).success (result) ->
        $(".search-results").html(result['content'])
        $(".search-results").show()
    else if query.length == 0
      $(".search-results").hide()
      $(".main-body").show()

  $(".add-item").click ->
    current_item_index = parseInt($("#current_item_index").val())
    html =
      '<div class="row">' +
        '<div class="form-group col-md-8">' +
          '<textarea class="form-control" rows="1" placeholder="Opis zlecenia" name="order[items_attributes][' + current_item_index + '][description]" id="order_items_attributes_' + current_item_index + '_description"></textarea>' +
        '</div>' +
        '<div class="form-group col-md-1">' +
          '<input class="form-control" placeholder="1" required="required" type="text" name="order[items_attributes][' + current_item_index + '][quantity]" id="order_items_attributes_' + current_item_index + '_quantity">' +
        '</div>' +
        '<div class="form-group col-md-2">' +
          '<input class="form-control" placeholder="100.00" required="required" type="text" name="order[items_attributes][' + current_item_index + '][price]" id="order_items_attributes_' + current_item_index + '_price">' +
        '</div>' +
        '<div class="form-group col-md-1">' +
          '<div class="btn btn-default remove-item form-control">' +
            'Usuń' +
          '</div>' +
        '</div>' +
      '</div>'

    $(".items").append(html);
    $("#current_item_index").val(current_item_index + 1);

  $("body").on 'click', '.remove-item', ->
    $(@).closest(".row").remove();

  # show purchaser list
  $("#order_purchaser").click ->
    $(".purchasers_list").show()

  $("#order_purchaser").keyup ->
    if $(@).val() == ''
      $(".purchasers_list").show()
    else
      $(".purchasers_list").hide()

  $(".purchaser_name").click ->
    purchaser = $(@).html().trim()
    $("#order_purchaser").val(purchaser)
    $(".purchasers_list").hide()

  # hide purchaser list
  $(document).mouseup (e)->
    container = $(".purchasers_list")
    if (!container.is(e.target) && container.has(e.target).length == 0)
      container.hide()
