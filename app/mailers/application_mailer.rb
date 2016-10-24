class ApplicationMailer < ActionMailer::Base
  default from: "KUSUNOKI SHOP",
          bcc: "kusu.ikuyorihato@gmail.com"
  layout 'mailer'
end
