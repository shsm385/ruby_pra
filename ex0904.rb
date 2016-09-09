#-*- coding: utf-8 -*-
# Studentクラスを作る
class Student
	# Student クラスのインスタンスの初期化
	def initialize(name,age)
		@name = name
		@age = age
	end

	# name属性, age属性のアクセサ
	attr_accessor :name, :age

	# Student クラスのインスタンスの文字列表現を返す
	def to_s
		"#@name #@age"
	end
end



# Student クラスのインスタンスを作成する
shin = Student.new('久保秋 真',45)

#getterを使ってインスタンスの名前と年齢を表示する
puts "氏名:#{shin.name}, 年齢:#{shin.age}歳"

#Setterを使ってshinの名前と年齢を変更する
shin.name = 'Shingh , Tiger Jeet'
shin.age = 445

#インスタンスの名前と年齢を表示する
puts shin.name
puts shin.age

puts "氏名:#{shin.name},年齢:#{shin.age}"

