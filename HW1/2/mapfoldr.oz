functor
import
	Browser
define
	local MapFoldR AddTen in				% 2.2 Map using FoldR
        fun {MapFoldR Xs F}
            {FoldR Xs fun {$ X Y} {F X}|Y end nil}      % define the binary operation for FoldR to be BinaryOp(x, y) = [UnaryOp(x) y] with empty list as identity
        end
        fun {AddTen X}      % just a model unary function
            X+10
        end
		{Browser.browse {MapFoldR [0 1 2 3 4 5 6 7 8 9] AddTen}}			% all possible test cases
        {Browser.browse {MapFoldR nil AddTen}}
	end
end