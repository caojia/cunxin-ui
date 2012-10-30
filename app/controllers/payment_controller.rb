class PaymentController < ApplicationController
  @@payment_bank = [
      {:name => 'icbc', :img_url => "/payment/icbc.png"},
      {:name => 'ccb', :img_url => "/payment/ccb.png"},
      {:name => 'cmb', :img_url => "/payment/cmb.png"},
      {:name => 'bcom', :img_url => "/payment/bcom.png"},
      {:name => 'abc', :img_url => "/payment/abc.png"},
      {:name => 'gdb', :img_url => "/payment/gdb.png"},
      {:name => 'cib', :img_url => "/payment/cib.png"},
      {:name => 'ceb', :img_url => "/payment/ceb.png"},
      {:name => 'post', :img_url => "/payment/post.png"},
      {:name => 'citic', :img_url => "/payment/citic.png"},
      {:name => 'spdb', :img_url => "/payment/spdb.png"},
      {:name => 'boc', :img_url => "/payment/boc.png"},
      {:name => 'sdb', :img_url => "/payment/sdb.png"},
      {:name => 'cmbc', :img_url => "/payment/cmbc.png"},
      {:name => 'bob', :img_url => "/payment/bob.png"},
      {:name => 'pab', :img_url => "/payment/pab.png"},
      {:name => 'hzb', :img_url => "/payment/hzb.png"}
    ]

  @@payment_target = [
    {:name => "alipay", :img_url => "/payment/alipay.gif"}
  ]

  def donate
    @payment_bank = @@payment_bank
    @payment_target = @@payment_target
    @project = Project.find(params[:project_id], :include => [:charity] )
  end

  def pay
    @project = Project.find(params[:project_id])
    @donate_amount = (params[:donate_amount] != 'other') ? params[:donate_amount] : params[:input_amount]
    @payment_method = params[:payment_method]

    @account = find_account(@project, @payment_method)
    @payment = generate_payment(@project, @account, @donate_amount)

    @pay = generate_payment_params(@payment, @payment_method)
  end

  def success

  end

  def fail

  end

  def notify
    case params[:payment_type].downcase
    when 'alipay'
      alipay_notify
    end
  end

  protected

  def alipay_notify
    Notification.create(:payment_method => 'alipay', :detail => request.raw_post)

    ali_notify = Billing::Alipay::Notify.new(request.raw_post)
    payment = Payment.find(:first, :conditions=>{:order_id => ali_notify.out_trade_no} )

    if payment
      case ali_notify.trade_status
      when 'TRADE_FINISHED'
        payment.status = 'finish'
      when 'WAIT_BUYER_PAY'
        payment.status = 'pending'
      end
      payment.save
    end

    render :text => 'success'
  end

  def find_account project, payment_method
    # Bank
    if @@payment_bank.find { |h| h[:name] == payment_method }
      return Account.find(
        :first, :conditions => { :charity_id => project.charity_id, :payment_method => "alipay" })
    else
      return Account.find(
        :first, :conditions => { :charity_id => project.charity_id, :payment_method => payment_method })
    end
  end

  def generate_payment project, account, donate_amount, options = {}
    payment = Payment.new()

    payment.user = current_user
    payment.project = project
    payment.account = account
    payment.amount = donate_amount
    payment.currency_type = 'RMB'
    payment.order_id = "%s%07d" % [ Time.now.strftime("%y%m%d%H%M%S"), SecureRandom.random_number(10000000) ]
    payment.status = 'new'

    payment.save
    payment
  end

  def getUserId
    1
  end

  def generate_payment_params payment, payment_method
    options = {
      :account => payment.account.target_account,
      :amount => payment.amount,
      :email => payment.account.email,
      :currency_type => payment.currency_type,
      :order_id => payment.order_id,
      :subject => payment.project.headline,
      :body => payment.project.headline,
      :return_url => "http://cunxin.org/payment/return/" + payment.account.payment_method,
      :notify_url => "http://cunxin.org/payment/notify/" + payment.account.payment_method,
      :verify_type => payment.account.verify_type,
      :key => payment.account.key,
    }

    #Bank
    options[:bank] = payment_method if @@payment_bank.find{|h| h[:name] == payment_method }

    case payment.account.payment_method
    when 'alipay'
      get_alipay_helper(options)
    when 'paypal'
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
