functor
import
	Browser
define
    local Last in
        fun {Last Xs N}                 % 1.2 Last
            local LastIn in
                fun {LastIn Xs K}
                    if K=<0 then Xs         % return whole list if N > length of Xs
                    else
                        if Xs==nil then nil
                        else {LastIn Xs.2 K-1}  % else wait till we reach the Nth element from last and return the rest of the list
                        end
                    end
                end
                {LastIn Xs {Length Xs}-N}
            end
        end
        {Browser.browse {Last [1 2 3 4 5 6] 4}}			% all possible test cases
		{Browser.browse {Last [1 2 3 4 5 6] 8}}
		{Browser.browse {Last [1 2 3 4 5 6] ~1}}
		{Browser.browse {Last nil 3}}
    end
end