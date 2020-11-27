\insert 'Unify.oz'

declare CreateVar
fun {CreateVar E X}
    local ENew in
        {Dictionary.put SAS @Count equivalence(@Count)}
        {AdjoinAt E X @Count ENew}
        Count := @Count + 1
        {Browse ENew}
        ENew
    end
end

declare StartExecution
fun {Interpret Stack}
    {Browse Stack}
    case Stack 
        of nil then nil
        [] (pair(stmt: S env: E)) | StackT then
            case S
                of nil then {Interpret StackT}
                [] [nop] | T then {Interpret (pair(stmt: T env: E)) | StackT}       % Question 1
                [] [var ident(X) S] | T then {Interpret (pair(stmt: [S] env: {CreateVar E X})) | (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) ident(Y)] | T then {Unify ident(X) ident(Y) E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] H | nil then {Interpret (pair(stmt: H env: E)) | StackT}
                else {Browse "ElseIdiot"} nil
            end
    end
end

declare Interpreter
fun {Interpreter Program}
    {Interpret [pair(stmt: [Program] env: env())]}
end

declare Res
Res = {Interpreter [[var ident(x) [var ident(y) [bind ident(y) ident(x)]]] [nop]]}
{Browse Res}

{Browse @Count}

declare Rec
{Dictionary.toRecord kkd SAS Rec}
{Browse Rec}

declare Rec1
{Dictionary.toRecord kkd SAS Rec1}
{Browse Rec1}

declare Rec2
{Dictionary.toRecord kkd SAS Rec2}
{Browse Rec2}