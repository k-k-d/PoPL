functor
import
	Browser
define
	local Check IsDiagonal in				% 4 IsDiagonal
        fun {Check L I}                     % Check gets a row and the row number to check if it is zero at all non diagonal positions
            if L==nil then true                 
            elseif I==1 then {Check L.2 I-1}
            else L.1==0 andthen {Check L.2 I-1}     % whenever the element number is not equal to row number check if it is zero
            end
        end
        fun {IsDiagonal M}              % recursively call Check on every row till
            local IsDiagonalIn in
                fun {IsDiagonalIn M I}
	                case M
                    of nil then true
                    [] H|T then {Check H I}andthen{IsDiagonalIn T I+1}
                    end
                end
                {IsDiagonalIn M 1}      % pass an extra parameter to inner function to indicate row number
            end
        end
		{Browser.browse {IsDiagonal [[1 0 0] [0 1 0] [0 0 1]]}}  		% some test cases
        {Browser.browse {IsDiagonal [[1 0 0] [0 1 7] [0 1 1]]}}
        {Browser.browse {IsDiagonal [[3 0 0] [0 9 0] [0 0 8]]}}
	end
end