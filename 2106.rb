# -*- coding: utf-8 -*-
require 'rubygems'
require 'dbi'

dbh = DBI.connect('DBI:SQLite3:students01.db')

dbh.select_all( 'select * from students' ) do |row|
  print "----\n"
  print "name = #{row[0]}\n"
  print "age = #{row[1]}\n"
end

dbh.disconnect