# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

amountRadioSelector = "ul#donate-amount-select input:radio"
amountTextSelector = "ul#donate-amount-select label.amount-text"
paymentRadioSelector = "ul#payment-select input:radio"
paymentLogoSelector = "ul#payment-select div.payment-logo img"
formSelector = "#donate-form"

paySubmit = (event) ->
  f = $(event.target)
  if f.find("input[name='donate_amount']:checked").size() == 0
    alert("请选择捐赠金额")
    return false
  if f.find("input[name='payment_method']:checked").size() == 0
    alert("请选择支付方式")
    return false
  true

checkDonateAmount = (event) ->
  f = $(event.target)
  if f.attr("checked") == "checked" || f.attr("checked") == true
    if f.val() == 'other'
      $("ul#donate-amount-select input[name='input_amount']").val("").prop('disabled', false).focus()
    else
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

$ ->
  $(amountRadioSelector).change(checkDonateAmount)

$ ->
  $(paymentRadioSelector).change(checkPayment)

$ ->
  $(paymentLogoSelector).click(paymentLogoClick)

$ ->
  $(amountTextSelector).click(amountTextClick)

$ ->
  $(formSelector).submit(paySubmit)

