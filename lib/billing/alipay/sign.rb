require 'digest/md5'
require 'cgi'

module Billing
  module Alipay
    module Sign

      def verify_sign
        sign_type = @params.delete("sign_type")
        sign = @params.delete("sign")
        md5_string = @params.sort.collect do |s|
          s[0]+"="+CGI.unescape(s[1])
        end
        Digest::MD5.hexdigest(md5_string.join("&")+KEY) == sign.downcase
      end

    end
  end
end

