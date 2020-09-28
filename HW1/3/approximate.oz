functor
import
	Browser
define
	local Factorial Sin Approximate Abs in				% 3.2 Approximate
        fun {Abs X}             % Abs function to get the absolute value of a given X
            if X=<0.0 then ~X
            else X
            end
        end
        fun {Approximate S Epsilon}     % wrapper that returns the required approximate sum
            local ApproximateIn in
                fun {ApproximateIn S X Epsilon Sum}
                    if {Abs S.1-X}=<Epsilon then Sum+S.1            % at the point when difference goes below epsilon, return the running sum
                    else {ApproximateIn S.2 S.1 Epsilon Sum+S.1}    % till then recursively add up terms in the series while keeping track of previous term to find difference each time
                    end
                end
                {ApproximateIn S.2 S.1 Epsilon S.1}
            end
        end
        fun {Factorial N}               % tail recursive Factorial function
            local FactorialIn in
                fun {FactorialIn N I Val}
                    if I>N then Val
                    else {FactorialIn N I+1 I*Val}
                    end
                end
                {FactorialIn N 1 1}
            end
        end
        fun {Sin X}         % model sin taylor series wrapper, this time applies X value and computes term values directly instead of returning functions
            local SinIn in
                fun lazy {SinIn X N Y}      % lazy function to recursively calculate the taylor series expansion of sin of value X
                    {IntToFloat Y*{Pow X 2*N-1}}/{IntToFloat {Factorial 2*N-1}} | {SinIn X N+1 ~Y}
                end
                {SinIn X 1 1}
            end
        end
		{Browser.browse {Approximate {Sin 3} 2.0}-0.0}			% some test cases
        /* Note that the value given for the x in sin(x) has to be an integer.
        This block of code is not written for float values.
        More error checks and condition checks are needed for that.
        Also, the epsilon value has to be of float type only.
        Type checking for every variable has not been implemented in this code yet.
        So, this will be a limitation. Logic, however, is solid. */
	end
end