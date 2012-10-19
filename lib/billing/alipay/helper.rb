module Billing
  module AliPay
    class Helper
      attr_accessor :fields

      def initialize(options={})
        self.fields = sign_params( query_params(options), options[:key] )
      end

      def host
        "http://www.alipay.com/cooperate/gateway.do"
      end

      protected
      def query_params(options)
        params = {
          :partner => options[:account],
          :out_trade_no => options[:order_id],
          :total_fee => options[:amount],
          :seller_email => options[:email],
          :notify_url => options[:notify_url],
          :"_input_charset" => 'utf-8',
          :service => "create_direct_pay_by_user",
          :payment_type => "1",
          :subject => options[:subject]
        }
        params[:body] = options[:body] if options[:body]
        params[:return_url] = options[:return_url] if options[:return_url]
        params = params.each_with_object({}) do |p, h|
          h[p[0]] = CGI.escape(p[1].to_s)
        end
        params
      end

      def sign_params(params, key)
        sorted_params = Hash[params.sort]
        raw_query_string = params.map {|key, value| "#{key}=#{value}" }.join("&")
        sign = Digest::MD5.hexdigest(raw_query_string + key)
        params[:sign] = sign
        params[:sign_type] = 'MD5'
        params
      end
    end
  end
end
