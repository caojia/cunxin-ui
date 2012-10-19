module Billing
  module PayPal
    class Helper
      attr_accessor :fields

      def initialize(options={})
        self.fields = query_params(options)
      end

      def query_params(options)
        params = {
          :cmd=> "_xclick",
          :charset => "utf-8",
          :business => options[:account],
          :currency_code => options[:currency_type],
          :item_name => options[:subject],
          :invoice => options[:order_id],
          :amount => options[:amount]
        }
        params = params.each_with_object({}) do |(k,v), h|
          h[k] = CGI.escape(v.to_s)
        end
        params
      end

      def host
        (Rails.env.production? ? "https://www.paypal.com" : "https://www.sandbox.paypal.com") + "/cgi-bin/webscr";
      end

    end
  end
end
