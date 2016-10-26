# coding: utf-8

require "csv"

CSV.foreach('db/fixtures/prefecture_utf8.csv') do |row|
  Prefecture.create(name: row[0])
end

CSV.foreach('db/fixtures/product_utf8.csv') do |row|
  Product.create(
    product_code: row[0],
    name: row[1],
    description: row[2],
    price: row[3],
    product_type: row[4],
    jan_code: row[5]
    )
end

User.create(
  name: "Hiroyuki Ota",
  email: "ikuyorihato@gmail.com",
  password: "hiroyuki21",
  password_confirmation: "hiroyuki21",
  payment_type: nil,
  shipping_type: nil,
  shipping_prefecture: nil,
  admin: true
  )