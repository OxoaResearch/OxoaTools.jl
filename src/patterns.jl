# Running value divided by average i.e. x/mean(x) 
using JuliaDB
t = table([1,2,3,4,5], [1,1,1,2,2], names=[:t,:x])

@time t2 = pushcol(t, :z, 
		map(mr->mr.x/mean(select(filter(row->row.t <= mrg.t, t), :x) ), 
		    t) 
	);

