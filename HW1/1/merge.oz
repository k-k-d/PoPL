functor
import
	Browser
define
	local Merge in				% 1.3 Merge
		fun {Merge X Y}
            if X==nil then Y        % if either list becomes empty return the rest of the other
            elseif Y==nil then X
            elseif X.1=<Y.1 then X.1|{Merge X.2 Y}  % whichever current element is less, add it to output list first and call recursively on the remaining list and the other list
            else Y.1|{Merge X Y.2}
            end
        end
		{Browser.browse {Merge [1 3 6 8 9 15] [2 4 5 6 7 10 12]}}			% all possible test cases
		{Browser.browse {Merge [2 4 5 6 7 10 12] [1 3 6 8 9 15]}}
		{Browser.browse {Merge nil [2 4 5 6 7 10 12]}}
		{Browser.browse {Merge [1 3 6 8 9 15] nil}}
        {Browser.browse {Merge nil nil}}
	end
end