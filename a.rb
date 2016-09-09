def fizzbuzz(n)
  fizz = (1..(n.to_s.size + 1))
    .map {|i| [i * 3, i * 6, i * 9]}.flatten
    .include?(n.to_s.split("").map(&:to_i).inject(&:+)) ? "Fizz" : ""
  buzz = ["0", "5"].include?(n.to_s[-1]) ? "Buzz" : ""
  puts (fizz + buzz).empty? ? n : fizz + buzz
end

(1..100).each {|n| fizzbuzz(n)}