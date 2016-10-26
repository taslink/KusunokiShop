class ApplicationMailer < ActionMailer::Base
  default from: "KUSUNOKI SHOP",
          bcc: "masuda_yuji@kusunoki210.jp,kusu.ikuyorihato@gmail.com"
  layout 'mailer'
end
