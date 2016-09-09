def isLeapYear(year)
  if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0) then
	print year
	print "," 
  elsif year % 100 == 0 then
    print "SKIP"
	print ","
  end
end

for num in 0..10000 do
  isLeapYear(num) 
end
