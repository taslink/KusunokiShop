# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# coding: utf-8

Product.create(:product_code => 'HGA01C' , :name => 'ピンク×ゼブラ×クロコ' , :description => 'ピンクの中からゼブラが飛び出すガーリーな封筒' , :price => 260 , :product_type => 'envelope')
Product.create(:product_code => 'HGB01C' , :name => 'ホワイト×花×クロコ' , :description => 'ホワイトの中から花が飛び出すガーリーな封筒' , :price => 260 , :product_type => 'envelope')
Product.create(:product_code => 'HGC01C' , :name => 'ブラック×花×クロコ' , :description => 'ブラックの中から花が飛び出すガーリーな封筒' , :price => 260 , :product_type => 'envelope')
Product.create(:product_code => 'HGD01C' , :name => 'オレンジ×レオパード×クロコ' , :description => 'オレンジの中からレオパードが飛び出すガーリーな封筒' , :price => 260 , :product_type => 'envelope')
Product.create(:product_code => 'HGE01C' , :name => 'ペールオレンジ×ダルメシアン×クロコ' , :description => 'ペールオレンジの中からダルメシアンが飛び出すガーリーな封筒' , :price => 260 , :product_type => 'envelope')