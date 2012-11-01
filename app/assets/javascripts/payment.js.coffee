# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

amountRadioSelector = "ul#donate-amount-select input:radio"
amountTextSelector = "ul#donate-amount-select label.amount-text"
paymentRadioSelector = "ul#payment-select input:radio"
paymentLogoSelector = "ul#payment-select div.payment-logo img"
anonymouseLabelSelector = "ul#donate-anonymous-check label"
formSelector = "#donate-form"

zeroize = (number, length) ->
  s = String(number)
  length = 1 if length == null
  zeros = ''
  if length > s.length
    for x in [0...(length-s.length)]
      zeros += '0'
  zeros + s

generateOrderId = () ->
  date = new Date()
  zeroize(date.getUTCFullYear(), 4) +
    zeroize(date.getUTCMonth()+1, 2) +
    zeroize(date.getUTCDate(), 2) +
    zeroize(date.getUTCHours(), 2) +
    zeroize(date.getUTCMinutes(), 2) +
    zeroize(date.getUTCSeconds(), 2) +
    zeroize(Math.floor(Math.random()*10000000), 7)

paySubmit = (event) ->
  _loggedIn = false
  $.requireLogin(() ->
    _loggedIn = true
  )
  if _loggedIn
    f = $(event.target)
    if f.find("input[name='donate_amount']:checked").size() == 0
      alert("请选择捐赠金额")
      return false
    if f.find("input[name='payment_method']:checked").size() == 0
      alert("请选择支付方式")
      return false
    $('#order_id').val(orderId=generateOrderId())
    $('#pay-succeed').attr('href', '/payment/success?order_id='+orderId)
    $('#pay-confirm-modal').modal('show')
    true
  else
    false

checkDonateAmount = (event) ->
  f = $(event.target)
  if f.attr("checked") == "checked" || f.attr("checked") == true
    if f.val() == 'other'
      $("ul#donate-amount-select span.other-amount-input").show()
      $("ul#donate-amount-select input[name='input_amount']").val("").prop('disabled', false).focus()
    else
      $("ul#donate-amount-select span.other-amount-input").hide()
      $("ul#donate-amount-select input[name='input_amount']").prop('disabled', true)
  true

checkPayment = (event) ->
  f = $(event.target)
  if f.attr("checked") == "checked" || f.attr("checked") == true
    $("ul#payment-select>li.select").removeClass("select")
    f.parents("ul#payment-select>li").addClass("select")

paymentLogoClick = (event) ->
  f = $(event.target)
  f.parents("ul#payment-select>li").find("input:radio").attr("checked", "checked").change()

amountTextClick = (event) ->
  f = $(event.target)
  f.parents("ul#donate-amount-select>li").find("input:radio").attr("checked", "checked").change()

anonymousTextClick = (event) ->
  f = $(event.target)
  cb = f.parents("ul#donate-anonymous-check>li").find("input:checkbox")
  if cb.attr("checked")
    cb.removeAttr("checked")
  else
    cb.attr("checked", "checked")


$ ->
  $(amountRadioSelector).change(checkDonateAmount)

$ ->
  $(paymentRadioSelector).change(checkPayment)

$ ->
  $(paymentLogoSelector).click(paymentLogoClick)

$ ->
  $(amountTextSelector).click(amountTextClick)

$ ->
  $(anonymouseLabelSelector).click(anonymousTextClick)

$ ->
  $(formSelector).submit(paySubmit)

