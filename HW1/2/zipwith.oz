functor
import
	Browser
define
	local ZipWith Sum in				% 2.1 ZipWith
        fun {ZipWith BinOp Xs Ys}
            if Xs==nil then Ys      % if either list becomes empty return the rest of the other (assumed that if a corresponding element doesn't exist in another list, identity is used for binary operation)
            elseif Ys==nil then Xs
            else {BinOp Xs.1 Ys.1}|{ZipWith BinOp Xs.2 Ys.2}    % for every element pair, perform binary operation and recurse
            end
        end
        fun {Sum A B}       % just a model binary operation
            A+B
        end
		{Browser.browse {ZipWith Sum [0 1 2 3 4 5 6 7 8 9] [0 2 4 6 8]}}			% all possible test cases
        {Browser.browse {ZipWith Sum [0 2 4 6 8] [0 1 2 3 4 5 6 7 8 9]}}
        {Browser.browse {ZipWith Sum [0 1 2 3 4 5 6 7 8 9] [0 2 4 6 8 10 12 14 16 18]}}
        {Browser.browse {ZipWith Sum nil [1]}}
	end
end