 #!/bin/ruby

 class Multier
 	def fizzbuzz(num)
    	if num % 15 == 0 
    		return num
    	end
  	end

  	def fizz(num)
    	if num % 5 == 0 
    		return num
    	end
    end

    def buzz(num)
    	if num % 3 == 0 
    		return num
    	end
    end
end


 #
 # TODO Fifteen, Three , Fiveの初期化
 #
 mult = Multier.new()

 1.step(100) do |count|
 	puts case count 
 		 when mult.fizzbuzz(count)
 		 	"FIzzBuzz"
 		 when mult.fizz(count)
 		 	"Fizz"
 		 when mult.buzz(count)
 		 	"Buzz"
 		 else
 		 	count
 		 end
 	
end