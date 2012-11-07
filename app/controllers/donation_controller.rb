class DonationController < ApplicationController
  @@payment_target = [
      {:name => 'icbc', :img_url => "/payment/icbc.png", :category => :bank},
      {:name => 'ccb', :img_url => "/payment/ccb.png", :category => :bank},
      {:name => 'cmb', :img_url => "/payment/cmb.png", :category => :bank},
      {:name => 'bcom', :img_url => "/payment/bcom.png", :category => :bank},
      {:name => 'abc', :img_url => "/payment/abc.png", :category => :bank},
      {:name => 'gdb', :img_url => "/payment/gdb.png", :category => :bank},
      {:name => 'cib', :img_url => "/payment/cib.png", :category => :bank},
      {:name => 'ceb', :img_url => "/payment/ceb.png", :category => :bank},
      {:name => 'post', :img_url => "/payment/post.png", :category => :bank},
      {:name => 'citic', :img_url => "/payment/citic.png", :category => :bank},
      {:name => 'spdb', :img_url => "/payment/spdb.png", :category => :bank},
      {:name => 'boc', :img_url => "/payment/boc.png", :category => :bank},
      {:name => 'sdb', :img_url => "/payment/sdb.png", :category => :bank},
      {:name => 'cmbc', :img_url => "/payment/cmbc.png", :category => :bank},
      {:name => 'bob', :img_url => "/payment/bob.png", :category => :bank},
      {:name => 'pab', :img_url => "/payment/pab.png", :category => :bank},
      {:name => 'hzb', :img_url => "/payment/hzb.png", :category => :bank},
      {:name => "alipay", :img_url => "/payment/alipay.gif", :category => :platform}
    ]

  def donate
    @project = Project.find(params[:project_id], :include => [:charity] )
    @default_amount = 10
    @payment_target = @@payment_target.dup

    last_payment = Payment.find(
      :first,
      :include => [:account],
      :conditions => {:user_id => current_user.id},
      :order => 'created_at DESC' ) unless current_user.blank?

    unless last_payment.blank?
      @default_payment = @payment_target.find {|h| h[:name] == last_payment.select_payment_method }
      @payment_target.delete_if {|h| h[:name] == @default_payment[:name] } unless @default_payment.blank?
    end
  end

  def pay
    @order_id = params[:order_id]
    @project = Project.find(params[:project_id])
    @donate_amount = (params[:donate_amount] != 'other') ? params[:donate_amount] : params[:input_amount]
    @payment_method = params[:payment_method]

    @account = find_account(@project, @payment_method)
    @payment = generate_payment(@order_id, @project, @account, @donate_amount, @payment_method)

    @pay = generate_payment_params(@payment, @payment_method)
  end

  def success
    @payment = Payment.find(:first, :conditions => {:order_id => params[:order_id]}, :include => [:project] )
    @project = @payment.project
    @projects = Project.find(:all).reject {|proj| proj == @project}
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
    if @@payment_target.find { |h| h[:name] == payment_method && h[:category] == :bank }
      return Account.find(
        :first, :conditions => { :charity_id => project.charity_id, :payment_method => "alipay" })
    else
      return Account.find(
        :first, :conditions => { :charity_id => project.charity_id, :payment_method => payment_method })
    end
  end

  def generate_payment order_id, project, account, donate_amount, select_payment_method, options = {}
    throw 'Duplicated order_id' unless Payment.find(:first, :conditions => {:order_id => order_id}).blank?

    payment = Payment.new()

    payment.user = current_user
    payment.project = project
    payment.select_payment_method = select_payment_method
    payment.account = account
    payment.amount = donate_amount
    payment.currency_type = 'RMB'
    #payment.order_id = "%s%07d" % [ Time.now.strftime("%y%m%d%H%M%S"), SecureRandom.random_number(10000000) ]
    payment.order_id = order_id
    payment.status = 'new'

    payment.save
    payment
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
    options[:bank] = payment_method if @@payment_target.find{|h| h[:name] == payment_method && h[:category] == :bank }

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
