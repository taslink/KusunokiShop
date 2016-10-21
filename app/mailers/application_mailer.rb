class ApplicationMailer < ActionMailer::Base
  default from: "KUSUNOKI SHOP",
          bcc: "info@taslink.jp"
  layout 'mailer'
end
