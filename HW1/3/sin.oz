functor
import
	Browser
define
	local Factorial Sin Take in				% 3.1 Sin(x) taylor series
        fun {Take Xs SinVal K}      % Take function as defined in problem 1.1 with a slight modification to actually compute the functions in Xs list with given SinVal value
            if K=<0 then nil
            else {Xs.1 SinVal}|{Take Xs.2 SinVal K-1}
            end
        end
        fun {Factorial N}           % tail recursive Factorial function discussed in class
            local FactorialIn in
                fun {FactorialIn N I Val}
                    if I>N then Val
                    else {FactorialIn N I+1 I*Val}
                    end
                end
                {FactorialIn N 1 1}
            end
        end
        fun {Sin}       % wrapper returns a list of functions corresponding to the taylor series for sin(x)
            local SinIn in
                fun lazy {SinIn N Y}        % this lazy function returns a list of functions i.e. the X value can be substituted later in order to compute
                    fun {$ X} {IntToFloat Y*{Pow X 2*N-1}}/{IntToFloat {Factorial 2*N-1}} end | {SinIn N+1 ~Y}
                end
                {SinIn 1 1}
            end
        end
		{Browser.browse {Take {Sin} 3 6}}			% some test cases
        {Browser.browse {Sin}}              % showing that it is indeed lazy
        /* Note that the value given for the x in sin(x) has to be an integer.
        This block of code is not written for float values.
        More error checks and condition checks are needed for that. */
	end
end