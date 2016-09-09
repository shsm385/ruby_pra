# -*- coding: utf-8 -*-
require 'date'

class BookInfo
	def initialize(title, author, page, publish_date)
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date
	end
	
	attr_accessor :title, :author, :page, :publish_date

	def to_csv(key)
		"#{key},#{@title},#{@author},#{@page},#{@publish_date}\n"
	end

	def to_s
		"#{@title},#{@author},#{@page},#{@publish_date}"
	end

	def toFormattedString( sep = "\n")
		"title: #{@title}#{sep}author: #{@author}#{sep}page: #{@page}#{sep}publish_date: #{publish_date}#{sep}"
	end
end

class BookInfoManager
	def initialize(filename)
		@csv_fname = filename
		@book_infos = {}
	end

	def setUp
		open(@csv_fname, "r:UTF-8"){|file|
			file.each{|line|
				key, title, author, page, pdate = line.chomp.split(',')
				@book_infos[key] = BookInfo.new(title, author, page.to_i,Date.etriptime(pdate))
			}
		}

	end

	def addBookInfo
		book_info = BookInfo.new("","",0,Date.new)
		print "\n"
		print "key: "
		key = gets.chomp
		print "title: "
		book_info.title = gets.chomp
		print "author: "
		book_info.author = gets.chomp
		print "pages"
		book_info.page = gets.chomp.to_i
		print "year"
		year = gets.chomp.to_i
		print "month"
		month = gets.chomp.to_i
		print "day"
		day = gets.chomp.to_i
		book_info.publish_date = Date.new(year, month, day)

		@book_infos[key]  = book_info
	end

	def listAllBookInfos
		puts "\n----------------"
		@book_infos.each{|key,info|
			print info.toFormattedString
		puts "\n----------------"
		}
	end

	def saveAllBookInfos
		open(@csv_fname, "w:UTF-8"){|file|
			@book_infos.each{|key,info|
				file.print(info.to_csv(key))
			}
			puts "\n save file"
		}
	end
	
	def run
		while true
			print "
			1.dete add
			2.dete display
			8.dete save
			9.end
			choose num {1,2,8,9}: "
			
			num = gets.chomp
			case
			when '1' == num
				addBookInfo
			when '2' == num
				listAllBookInfos
			when '8' == num
				saveAllBookInfos
			when '9' == num
				break;
			else

			end
		end
	end

end


book_info_maneger = BookInfoManager.new("book_info.csv")

book_info_maneger.setUp

book_info_maneger.run
