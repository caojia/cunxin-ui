class PaymentController < ApplicationController
  def donate
    @project = Project.find(params[:project_id] || 1)
    @payment_target = [
      {:name => "Alipay", :img_url => "/payment/alipay.gif" },
      {:name => "Paypal", :img_url => "/payment/paypalcn.gif"}
    ]
  end

  def pay
    @project = Project.find(params[:project_id])
    @donate_amount = (params[:donate_amount] != 'other') ? params[:donate_amount] : params[:input_amount]
    @payment_method = params[:payment_method]
  end

  def success

  end
end
