% Dictionary to implement SAS
declare SAS
SAS = {Dictionary.new}

% Cell used to index stuff in the SAS
declare Count
{NewCell 0 ?Count}

declare RetrieveFromSAS BindRefToKeyInSAS BindValueToKeyInSAS

% Find Head of a Union-Find Datastucture
declare FindHead
fun {FindHead X}
    local XVal in
        XVal = {RetrieveFromSAS X}
        case XVal
        of equivalence(Val) then
            if X == Val then XVal
            else {FindHead Val}
            end
        else XVal
        end
    end
end

% Retrieve Value from SAS given Identifier name
fun {RetrieveFromSAS X}
    local Val in
        {Dictionary.get SAS X Val}
        Val
    end
end

% Union of different Keys to club them into a single Equivalence Class
proc {BindRefToKeyInSAS X Y}
    local XH YH in
        XH = {FindHead X}
        YH = {FindHead Y}
        case XH
        of equivalence(XVal) then
            case YH
            of equivalence(YVal) then {Dictionary.put SAS YVal XH}
            else {Dictionary.put SAS XVal YH}
            end
        else
            case YH
            of equivalence(YVal) then {Dictionary.put SAS YVal XH}
            else
                if XH \= YH then {Browse 'Error binding var-to-var.'}
                end
            end
        end
    end
end

% Assign a Value to the Head of an Equivalence Class
proc {BindValueToKeyInSAS X Val}
    local XH in
        XH = {FindHead X}
        case XH
        of equivalence(XVal) then {Dictionary.put SAS XVal Val}
        else
            if Val \= XH then {Browse 'Failure binding var-to-val.'}
            end
        end
    end
end