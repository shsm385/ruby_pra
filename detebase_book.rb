#-*- coding: utf-8 -*-
require 'rubygems'
require 'dbi'
require 'date'



class BookInfo
  def initialize( title, author, page, publish_date )
    @title = title
    @author = author
    @page = page
    @publish_date = publish_date
  end

  # 最初に、検討する属性に対するアクセサを提供する
  attr_accessor :title, :author, :page, :publish_date

  # BookInfoクラスのインスタンスの文字列表現を返すようにする。
  def to_s
    "#{@title}, #{@author}, #{@page}, #{@publish_date}"
  end

  # 出力フォーマットの定義
  def toFormattedString( sep = "\n" )
    "書籍名：#{@title}#{sep}著者名：#{@author}#{sep}ページ数：#{@page}ページ#{sep}発刊日：#{@publish_date}#{sep}"
  end
end

class BookInfoManager
	def initialize( sqlite_name )
		@db_name = sqlite_name
		@dbh = DBI.connect( "DBI:SQLite3:#{@db_name}" )
	end

	def initBookInfos
		puts "\n0. 蔵書データベースの初期化"
		print "初期化しますか？ (Y/y): "
		yesno = gets.chomp.upcase
		if /^Y$/ =~ yesno
			@dbh.do("drop table if exists bookinfos")
			@dbh.do("create table bookinfos(
				id varchar(50) not null,
				title varchar(50) not null,
				author varchar(50) not null,
				page int not null,
				publish_date datetime not null,
				primary key(id)
				);")
			puts "\nデータベースを初期化しました."
		end
	end

	def addBookInfo
		puts "\n1. 蔵書データの登録"
		print "蔵書データを登録します"

		book_info = BookInfo.new("","",0,Date.new)
		print "\n"
		print "key: "
		key = gets.chomp
		print "title: "
		book_info.title = gets.chomp
		print "author: "
		book_info.author = gets.chomp
		print "page: "
		book_info.page = gets.chomp.to_i
		print "year: "
		year = gets.chomp.to_i
		print "month: "
		month = gets.chomp.to_i
		print "day: "
		day = gets.chomp.to_i
		
		book_info.publish_date = Date.new( year, month, day )

		@dbh.do("insert into bookinfos values(
			\'#{key}\',
			\'#{book_info.title}\',
			\'#{book_info.author}\',
			\'#{book_info.page}\',
			\'#{book_info.publish_date}\'
			);")
		puts "\n登録しました"
	end

	def listAllBookInfos
		item_name = {'id' => "key", 'title' => "書籍名", 'author' => "著者名", 'page' => "ページ数", 'publish_date' => "発刊日"}
		puts "\n2.蔵書データの表示"
		print "蔵書データを表示します"

		puts "\n---------------------"

		sth = @dbh.execute("select * from bookinfos")

		counts = 0
		sth.each do |row|
			row.each_with_name do |val, name|
				puts "#{item_name[name]}: #{val.to_s}"
			end
			puts "------------------------"
			counts = counts + 1
		end

	sth.finish

	puts "\n#{counts}件表示しました"
	end

	def run 
		while true
			print "
			0.蔵書データベースの初期化
			1.蔵書データの登録
			2.蔵書データの表示
			9.終了
			番号を選んでください(0,1,2,9) : "

			num = gets.chomp
			case 
			when '0' == num
				initBookInfos
			when '1' == num
				addBookInfo
			when '2' == num
				listAllBookInfos
			when '9' == num
				@dbh.disconnect
				puts "\n終了しました"
				break;
			else
				#return
			end
		end
	end

end

book_info_maneger = BookInfoManager.new("bookinfo_sqlite.db")

book_info_maneger.run
















