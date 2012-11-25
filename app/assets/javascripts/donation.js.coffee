# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

amountRadioSelector = "ul.donate-amount-select input:radio"
amountTextSelector = "ul.donate-amount-select label.amount-text"
paymentRadioSelector = "ul.payment-select input:radio"
paymentLogoSelector = "ul.payment-select div.payment-logo img"
anonymouseLabelSelector = "ul.donate-anonymous-check label"
formSelector = "#donate-form"
chooseOtherMethodSelector = "a#choose-other-method"
payFailedSelector = "a#pay-failed"
donateAmountInputSelector = "input[name='input_amount']"

generateOrderId = () ->
  date = new Date()
  return sprintf("%04d%02d%02d%02d%02d%02d%07d",
    date.getUTCFullYear(), date.getUTCMonth()+1, date.getUTCDate(),
    date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds(), Math.random()*10000000 )

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
    if $(f.find("input[name='donate_amount']:checked")[0]).val() == 'other'
      amount = $(f.find("input[name='input_amount']")[0]).val()
      if Number(amount) == 0 || Number(amount) == NaN
        alert("请输入捐助金额")
        return false
      if Number(amount) > 10000
        alert("单次捐助金额最多10,000元")
        return false
    $('#order_id').val(orderId=generateOrderId())
    $('#pay-succeed').attr('href', '/donation/success?order_id='+orderId)
    $('#pay-confirm-modal').modal('show')
    true
  else
    false

checkDonateAmount = (event) ->
  f = $(event.target)
  if f.attr("checked") == "checked" || f.attr("checked") == true
    if f.val() == 'other'
      $("ul.donate-amount-select span.other-amount-input").show()
      $("ul.donate-amount-select input[name='input_amount']").val("").prop('disabled', false).focus()
    else
      $("ul.donate-amount-select span.other-amount-input").hide()
      $("ul.donate-amount-select input[name='input_amount']").prop('disabled', true)
  true

checkPayment = (event) ->
  f = $(event.target)
  if f.attr("checked") == "checked" || f.attr("checked") == true
    $("ul.payment-select>li.select").removeClass("select")
    f.parents("ul.payment-select>li").addClass("select")

paymentLogoClick = (event) ->
  f = $(event.target)
  f.parents("ul.payment-select>li").find("input:radio").attr("checked", "checked").change()

amountTextClick = (event) ->
  f = $(event.target)
  f.parents("ul.donate-amount-select>li").find("input:radio").attr("checked", "checked").change()

anonymousTextClick = (event) ->
  f = $(event.target)
  cb = f.parents("ul.donate-anonymous-check>li").find("input:checkbox")
  if cb.attr("checked")
    cb.removeAttr("checked")
  else
    cb.attr("checked", "checked")

chooseOtherMethodClick = (event) ->
  f = $(event.target)
  $("div#all-donate-method").removeClass("hide")
  f.hide()

payFailedClick = (event) ->
  $('#pay-confirm-modal').modal('hide')
  false

donateAmountInputKeyUp = (event) ->
  f = $(event.target)
  f.val(f.val().replace(/[^0-9]/g,''))

$ ->
  $(amountRadioSelector).change(checkDonateAmount)
  $(paymentRadioSelector).change(checkPayment)
  $(paymentLogoSelector).click(paymentLogoClick)
  $(amountTextSelector).click(amountTextClick)
  $(anonymouseLabelSelector).click(anonymousTextClick)
  $(formSelector).submit(paySubmit)
  $(chooseOtherMethodSelector).click(chooseOtherMethodClick)
  $(payFailedSelector).click(payFailedClick)
  $(donateAmountInputSelector).keyup(donateAmountInputKeyUp)

