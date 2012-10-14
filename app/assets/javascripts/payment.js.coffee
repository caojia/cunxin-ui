# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery

amountRadioSelector = "ul#donate-amount-select input:radio"
paymentRadioSelector = "ul#payment-select input:radio"
formSelector = "#donate-form"

paySubmit = (event) ->
  f = $(event.target)
  if f.find("input[name='donate_amount']:checked").size() == amountRadioSelector0
    alert("请选择捐赠金额")
    return false
  if f.find("input[name='payment_method']:checked").size() == 0
    alert("请选择支付方式")
    return false
  true

checkDonateAmount = (event) ->
  f = $(event.target)
  if f.val() == 'other'
    $("ul#donate-amount-select input[name='input_amount']").prop('disabled', false)
  else
    $("ul#donate-amount-select input[name='input_amount']").prop('disabled', true)
  true

checkPayment = (event) ->
  f = $(event.target)
  $("ul#payment-select>li.select").removeClass("select")
  f.parent("ul#payment-select>li").addClass("select")

$ ->
  $(amountRadioSelector).change(checkDonateAmount)

$ ->
  $(paymentRadioSelector).change(checkPayment)

$ ->
  $(formSelector).submit(paySubmit)
