functor
import
	Browser
define
	local Take in				% 1.1 Take
		fun {Take Xs N}
			if N=<0 then nil		% return nil to terminate output list if either Xs ends or N goes to 0
			else
				if Xs==nil then nil
				else Xs.1|{Take Xs.2 N-1}		% else keep attaching elements recursively
				end
			end
		end
		{Browser.browse {Take [1 2 3 4 5 6] 4}}			% all possible test cases
		{Browser.browse {Take [1 2 3 4 5 6] 8}}
		{Browser.browse {Take [1 2 3 4 5 6] ~1}}
		{Browser.browse {Take nil 3}}
	end
end