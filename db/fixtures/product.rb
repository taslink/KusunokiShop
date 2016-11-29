require 'csv'

csv = CSV.read('db/fixtures/product_utf8.csv')

csv.each do |row|
  
  id = row[0]
  product_code = row[1]
  name = row[2]
  description = row[3]
  price = row[4]
  product_type = row[5]
  jan_code = row[6]
  sort_no = row[7]

  Product.seed(:id) do |s|
    s.id = id
    s.product_code = product_code
    s.name = name
    s.description = description
    s.price = price
    s.product_type = product_type
    s.jan_code = jan_code
    s.sort_no = sort_no
  end
  
end