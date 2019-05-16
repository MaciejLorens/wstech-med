# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  setTimeout ->
    $(".alert").fadeOut(500)
  , 1500

  $('.datepicker').datepicker({
    format: 'dd-mm-yyyy',
    autoclose: true,
    language: 'pl'
  });

  ready_to_delivery_modal = $("#ready-to-delivery")
  suspend_order_modal = $("#suspend-order")
  production_order_modal = $("#production-order")
  stages_order_modal = $("#stages-order")

  window.onclick = (e) ->
    if e.target == ready_to_delivery_modal[0]
      ready_to_delivery_modal.css('display', 'none')
    if e.target == suspend_order_modal[0]
      suspend_order_modal.css('display', 'none')
    if e.target == production_order_modal[0]
      production_order_modal.css('display', 'none')
    if e.target == stages_order_modal[0]
      stages_order_modal.css('display', 'none')

  $('.close-modal').click (e) ->
    e.preventDefault()
    ready_to_delivery_modal.css('display', 'none')
    suspend_order_modal.css('display', 'none')
    production_order_modal.css('display', 'none')
    stages_order_modal.css('display', 'none')

  $(".ready-to-delivery").click (e) ->
    e.preventDefault()
    ready_to_delivery_modal.css('display', 'block')
    $("#ready-to-delivery-form").prop('action', $(@).prop('href'))

  $(".production-order").click (e) ->
    e.preventDefault()
    production_order_modal.css('display', 'block')
    $("#production-order-form").prop('action', $(@).prop('href'))

  $(".suspend-order").click (e) ->
    e.preventDefault()
    suspend_order_modal.css('display', 'block')
    $("#suspend-order-form").prop('action', $(@).prop('href'))

  $(".stages-order").click (e) ->
    e.preventDefault()
    stages_order_modal.css('display', 'block')
    $("#stages-order-form").prop('action', $(@).prop('href'))

    if $(@).data('welding')
      $("#stages_welding").prop('checked', 'checked')
    else
      $("#stages_welding").prop('checked', false)

    if $(@).data('cleaning')
      $("#stages_cleaning").prop('checked', 'checked')
    else
      $("#stages_cleaning").prop('checked', false)

    if $(@).data('painting')
      $("#stages_painting").prop('checked', 'checked')
    else
      $("#stages_painting").prop('checked', false)

    if $(@).data('upholstery')
      $("#stages_upholstery").prop('checked', 'checked')
    else
      $("#stages_upholstery").prop('checked', false)

    if $(@).data('woodwork')
      $("#stages_woodwork").prop('checked', 'checked')
    else
      $("#stages_woodwork").prop('checked', false)

    if $(@).data('assembly')
      $("#stages_assembly").prop('checked', 'checked')
    else
      $("#stages_assembly").prop('checked', false)


  $(".add-item").click ->
    current_item_index = parseInt($("#current_item_index").val())
    html =
      '<div class="row">' +
        '<div class="form-group col-md-2">' +
          '<textarea class="form-control" rows="2" placeholder="Produkt" name="order[items_attributes][' + current_item_index + '][product]" id="order_items_attributes_' + current_item_index + '_product"></textarea>' +
        '</div>' +
        '<div class="form-group col-md-2">' +
          '<textarea class="form-control" rows="2" placeholder="Model" name="order[items_attributes][' + current_item_index + '][model]" id="order_items_attributes_' + current_item_index + '_model"></textarea>' +
        '</div>' +
        '<div class="form-group col-md-3">' +
          '<textarea class="form-control" rows="2" placeholder="Opcje" name="order[items_attributes][' + current_item_index + '][options]" id="order_items_attributes_' + current_item_index + '_options"></textarea>' +
        '</div>' +
        '<div class="form-group col-md-2">' +
        '<textarea class="form-control" rows="2" placeholder="Kolor" name="order[items_attributes][' + current_item_index + '][color]" id="order_items_attributes_' + current_item_index + '_color"></textarea>' +
        '</div>' +
        '<div class="form-group col-md-1">' +
        '<input class="form-control" placeholder="1" required="required" type="text" name="order[items_attributes][' + current_item_index + '][quantity]" id="order_items_attributes_' + current_item_index + '_quantity">' +
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

  $("body").on 'click', ".sorting-btn", (e) ->
    e.preventDefault()

    $(".sorting-btn").not(@).removeClass('asc')
    $(".sorting-btn").not(@).removeClass('desc')

    $("#s_field").val($(@).data('field'))

    if $(@).hasClass('asc')
      $(@).removeClass('asc')
      $(@).addClass('desc')
      $("#s_order").val('desc')
    else
      $(@).removeClass('desc')
      $(@).addClass('asc')
      $("#s_order").val('asc')

    $(".filter-form").submit()
