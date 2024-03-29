# encoding:utf-8
module Billing
  module AliPay
    class Helper
      attr_accessor :fields
      @@bank_name_match = {
      'icbc' => 'ICBCBTC',
      'ccb' => 'CCB',
      'cmb' => 'CMB',
      'bcom' => 'BOCB2C',
      'abc' => 'ABC',
      'gdb' => 'GDB',
      'cib' => 'CIB',
      'post' => 'POSTGC',
      'citic' => 'CITIC',
      'spdb' => 'SPDB',
      'boc' => 'BOCB2C',
      'sdb' => 'SDB',
      'cmbc' => 'CMBC',
      'bob' => 'BJBANK',
      'pab' => 'SPABANK',
      'hzb' => 'HZCBB2C'
      }

      def initialize(options={})
        self.fields = sign_params( query_params(options), options[:key] )
      end

      def host
        "https://mapi.alipay.com/gateway.do"
      end

      protected
      def query_params(options)
        params = {
          :partner => options[:account],
          :out_trade_no => options[:order_id],
          :total_fee => options[:amount],
          :seller_id => options[:account],
          #:seller_email => options[:email],
          :notify_url => options[:notify_url],
          :"_input_charset" => 'utf-8',
          :service => "create_direct_pay_by_user",
          :payment_type => "4",
          :subject => options[:subject]
        }
        params[:body] = options[:body] if options[:body]
        params[:return_url] = options[:return_url] if options[:return_url]
        if options[:bank]
          params[:paymethod] = 'bankPay'
          params[:defaultbank] = @@bank_name_match[options[:bank]]
        end
        params = params.each_with_object({}) do |p, h|
          h[p[0]] = p[1].to_s
        end
        params
      end

      def sign_params(params, key)
        raw_query_string = params.map {|key, value| "#{key}=#{value}" }.sort.join("&")
        p raw_query_string
        p CGI.unescape(raw_query_string+key)
        sign = Digest::MD5.hexdigest(CGI.unescape(raw_query_string) + key)
        p sign
        params[:sign] = sign
        params[:sign_type] = 'MD5'
        params
      end
    end
  end
end
