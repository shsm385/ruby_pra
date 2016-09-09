# -*- coding: utf-8 -*-
require 'rubygems'
require 'dbi'

#dbhを作成して、データベースに接続
dbh = DBI.connect('DBI:SQLite3:fruits01.db')

# もしすでにこのデータベースにテーブルがあれば削除
dbh.do("drop table if exists products")
puts "table 'products' has dropped"

#テーブルを新しく作成
dbh.do("create table products 
	(id int not null,
	 title varchar(100) not null,
	 description text not null,
	 image_url varchar(100) not null,
	 price int not null,
	 date_available datetime not null,
	 primary key(id));")
puts "table 'products' has crated"

dbh.disconnect