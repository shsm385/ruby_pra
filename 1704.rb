#-*- coding: utf-8 -*-
fruits = ["apple","banana","cherry","fig", "grape"]

file = File.open("sample4.txt","w:UTF-8")
fruits.each{|fruits|
	file.puts fruits
}

file.close

file = File.open("sample4.txt","r:UTF-8")

print file.read

file.close
