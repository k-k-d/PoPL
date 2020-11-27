declare SAS
SAS = {Dictionary.new}

declare Count
{NewCell 0 ?Count}

declare RetrieveFromSAS BindRefToKeyInSAS BindValueToKeyInSAS

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

fun {RetrieveFromSAS X}
    local Val in
        {Dictionary.get SAS X Val}
        Val
    end
end

proc {BindRefToKeyInSAS X Y}
    local XH YH in
        {Browse XH}
        {Browse YH}
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
                if XH \= YH then {Browse 'Error binding var-to-var'}
                end
            end
        end
    end
end

proc {BindValueToKeyInSAS X Val}
    local XH in
        XH = {FindHead X}
        case XH
        of equivalence(XVal) then {Dictionary.put SAS XVal Val}
        else
            if Val \= XH then {Browse 'Error binding var-to-val'}
            end
        end
    end
end