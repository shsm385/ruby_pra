# -*- coding: utf-8 -*-
#データベース要素の追加
require 'rubygems'
require 'dbi'

dbh = DBI.connect('DBI:SQLite3:fruits01.db')

dbh.do("insert into products values(
	1,
	'りんご',
	'「國光」',
	'/img/kokkou.jpg',
	'300',
	'2009-02-01 09:15:00'
	);")

puts "1 records inserted"

dbh.disconnect