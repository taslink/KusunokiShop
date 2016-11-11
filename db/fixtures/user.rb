User.seed do |s|
  s.id = 1
  s.name = "Hiroyuki Ota"
  s.email = "kusu.ikuyorihato@gmail.com"
  s.password = "hiroyuki21"
  s.password_confirmation = "hiroyuki21"
  s.admin = true
end

User.seed do |s|
  s.id = 2
  s.name = "Yuji Masuda"
  s.email = "masuda_yuji@kusunoki210.jp"
  s.password = "kusunokikusunokikusunoki"
  s.password_confirmation = "kusunokikusunokikusunoki"
  s.admin = true
end

User.seed do |s|
  s.id = 3
  s.name = "Guest"
  s.email = "guest.kusunoki@gmail.com"
  s.password = "guestkusunoki"
  s.password_confirmation = "guestkusunoki"
  s.admin = false
end

User.seed do |s|
  s.id = 5
  s.name = "Sample User5"
  s.email = "sample5@gmail.com"
  s.password = "hiroyuki21"
  s.password_confirmation = "hiroyuki21"
  s.admin = false
end
