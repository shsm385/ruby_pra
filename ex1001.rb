#-*- coding: utf-8 -*-
require 'date'

#蔵書1冊のデータ
class BookInfo

	#初期化
	def initialize(title, author, page, publish_date)
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date 
	end

	#アクセサの提供
	attr_accessor :title, :author, :page, :publish_date
	
	#BookInfoのインスタンスの文字列を返す
	def to_s
		'#@title, #@author, #@page, #@publish_date'
	end
end

#BookInfoのインスタンスを作成
book_info = BookInfo.new(
	"実践アジャイル ソフトウェア開発法とプロジェクト管理",
	"山田 正樹",
	248,
	Date.new(2005,1,25)
	)

#BookInfoのインスタンスの文字列表現を返す
puts book_info.to_s

#book_infoのアクセサを使う
puts "書籍名: " + book_info.title
puts "著者名: " + book_info.author
