mon_all = [0,1,2]
num_itr = 100000
[true,false].each do |do_change|
    num_seikai = 0
    num_itr.times do
        mon = mon_all.sample
        seikai = mon_all.sample
        if do_change
            ans = mon_all - [mon,seikai].uniq
            num_seikai += 1 if ans.size == 1
        else
            num_seikai += 1 if seikai == mon
        end
    end
    puts (do_change ? "change" : "no change")
    puts "seikai ritsu: " + (num_seikai.to_f / num_itr * 100) .to_s
end