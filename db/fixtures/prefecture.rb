require 'csv'

csv = CSV.read('db/fixtures/prefecture_utf8.csv')

csv.each do |row|
    
  id = row[0]
  name = row[1]

  Prefecture.seed(:id) do |s|
    s.id = id
    s.name = name
  end
  
end