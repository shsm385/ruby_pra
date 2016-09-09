# -*- coding: utf-8-*-
require 'pstore'

juice = "orange juice"
fruits = ["apple","banana","cherry","fig","grape"]

db = PStore.new('fruitdb')

db.transaction do 
	db["drink"] = juice
	db["fruits"] = fruits
end

db.transaction(true) do
	puts "drink: #{db["drink"]}"
	puts "fruits: #{db["fruits"].join(", ")}"
end