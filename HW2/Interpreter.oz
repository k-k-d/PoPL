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

declare CreateRec
fun {CreateRec E L}
    {Browse L}
    case L
    of nil then E
    [] [literal(_) ident(Xn)] | T then {CreateRec {CreateVar E Xn} T}
    end
end

declare StartExecution
fun {Interpret Stack}
    {Browse Stack}
    local ENew in
    case Stack 
        of nil then local Ans in {Dictionary.toRecord kkd SAS Ans} {Browse Ans} end nil
        [] (pair(stmt: S env: E)) | StackT then
            {Browse S}
            case S
                of nil then {Interpret StackT}
                [] [nop] | T then {Interpret (pair(stmt: T env: E)) | StackT}       % Question 1
                [] [var ident(X) S] | T then {Interpret (pair(stmt: [S] env: {CreateVar E X})) | (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) ident(Y)] | T then {Unify ident(X) ident(Y) E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) literal(N)] | T then {Unify ident(X) literal(N) E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) [record literal(A) L]] | T then ENew = {CreateRec E L} {Unify ident(X) [record literal(A) L] ENew} {Interpret (pair(stmt: T env: ENew)) | StackT}
                [] H | nil then {Interpret (pair(stmt: H env: E)) | StackT}
                else {Browse "ElseIdiot"} nil
            end
    end
    end
end

declare Interpreter
fun {Interpreter Program}
    {Interpret [pair(stmt: [Program] env: env())]}
end

declare Res
Res = {Interpreter [[var ident(x) [[bind ident(x) [record literal(a) [[literal(f1) ident(x1)] [literal(f2) ident(x2)]]]] [bind ident(x1) ident(x2)] [bind ident(x1) literal(kd)] [nop]]]]}
{Browse Res}

% {Browse @Count}

% declare Rec
% {Dictionary.toRecord kkd SAS Rec}
% {Browse Rec}

% declare Rec1
% {Dictionary.toRecord kkd SAS Rec1}
% {Browse Rec1}

% declare Rec2
% {Dictionary.toRecord kkd SAS Rec2}
% {Browse Rec2}