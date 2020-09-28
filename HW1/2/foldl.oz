functor
import
	Browser
define
	local FoldL Prod in				% 2.3 FoldL
        fun {FoldL L BinOp Id}
            local FoldLIn in
                fun {FoldLIn X Y BinOp}
                    case X
                    of nil then Y       % when list is traversed fully, return the final Y
                    [] H|T then {FoldLIn T {BinOp Y H} BinOp}       % update Y in every tail recursion with BinaryOp(y, current_list_element) and recurse with rest of list
                    end
                end
            {FoldLIn L Id BinOp}        % initially, Y is the identity
            end
        end
        fun {Prod A B}       % just a model binary operation
            A*B
        end
		{Browser.browse {FoldL [1 2 3 4 5 6] Prod 1}}			% all possible test cases
        {Browser.browse {FoldL nil Prod 1}}
	end
end