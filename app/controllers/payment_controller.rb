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

    @account = find_account(@project, @payment_method)
    @payment = generate_payment(@project, @account, @donate_amount)

    @pay = generate_payment_params(@payment)
  end

  def success

  end

  def notify
    parse_notification(params)
  end


  protected

  def parse_notification params

  end

  def find_account project, payment_method
    return Account.find(
      :first, :conditions => { :charity_id => project.charity_id, :payment_method => payment_method })
  end

  def generate_payment project, account, donate_amount, options = {}
    payment = Payment.new()

    payment.user_id = getUserId
    payment.project = project
    payment.account = account
    payment.amount = donate_amount
    payment.currency_type = 'RMB'
    payment.order_id = 1313123123 # Random
    payment.status = 'new'

    payment.save
    payment
  end

  def getUserId
    1
  end

  def generate_payment_params payment
    options = {
      :account => payment.account.target_account,
      :amount => payment.amount,
      :email => payment.account.email,
      :currency_type => payment.currency_type,
      :order_id => payment.order_id,
      :subject => payment.project.headline,
      :body => payment.project.headline,
      :return_url => "http://cunxin.org/payment/return/" + payment.account.payment_method,
      :notify_url => "http://cunxin.org/payment/notify" + payment.account.payment_method,
      :verify_type => payment.account.verify_type,
      :key => payment.account.key,
    }

    case payment.account.payment_method
    when 'Alipay'
      get_alipay_helper(options)
    when 'Paypal'
      get_paypal_helper(options)
    end
  end

  def get_alipay_helper(options={})
    Billing::AliPay::Helper.new(options)
  end

  def get_paypal_helper(options={})
    Billing::PayPal::Helper.new(options)
  end

end
