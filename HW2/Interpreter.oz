\insert 'Unify.oz'

% Variable Creation
declare CreateVar
fun {CreateVar E X}
    local ENew in
        {Dictionary.put SAS @Count equivalence(@Count)}
        {AdjoinAt E X @Count ENew}
        Count := @Count + 1
        ENew
    end
end

% Pattern Matching
declare CheckList
proc {CheckList L1 L2 MatchBool E EOrig ENew}
    local ENext in
    if L1 == nil andthen L2 == nil then MatchBool = true ENew = E
    else
        if {Length L1} \= {Length L2} then MatchBool = false ENew = EOrig
        else 
            case L1.1.1
            of equivalence(Y) then
                case {FindHead Y}
                of equivalence(_) then MatchBool = false ENew = EOrig {Browse 'Record feature unbound. Error in pattern matching. Considered as pattern match fail instead of suspension.'}
                else
                    case L2.1.1
                    of ident(K) then
                        case {FindHead E.K}
                        of equivalence(_) then MatchBool = false ENew = EOrig {Browse 'Record feature unbound. Error in pattern matching. Considered as pattern match fail instead of suspension.'}
                        else 
                            if {FindHead E.Y} == {FindHead E.K} then 
                                case L2.1.2.1
                                of ident(P) then
                                    case L1.1.2.1 of equivalence(Q) then {AdjoinAt E P Q ENext}
                                    else {Browse 'Some SAS error'}
                                    end
                                else {Browse 'Some SAS error'}
                                end
                                {CheckList L1.2 L2.2 MatchBool ENext EOrig ENew}
                            else MatchBool = false ENew = EOrig
                            end
                        end
                    else
                        if {FindHead E.Y} == L2.1.1 then
                            case L2.1.2.1
                            of ident(P) then
                                case L1.1.2.1 of equivalence(Q) then {AdjoinAt E P Q ENext}
                                else {Browse 'Some SAS error'}
                                end
                            else {Browse 'Some SAS error'}
                            end
                            {CheckList L1.2 L2.2 MatchBool ENext EOrig ENew}
                        else MatchBool = false ENew = EOrig
                        end
                    end
                end
            else
                case L2.1.1
                of ident(K) then
                    case {FindHead E.K}
                    of equivalence(_) then MatchBool = false ENew = EOrig {Browse 'Record feature unbound. Error in pattern matching. Considered as pattern match fail instead of suspension.'}
                    else 
                        if L1.1.1 == {FindHead E.K} then 
                            case L2.1.2.1
                            of ident(P) then
                                case L1.1.2.1 of equivalence(Q) then {AdjoinAt E P Q ENext}
                                else {Browse 'Some SAS error'}
                                end
                            else {Browse 'Some SAS error'}
                            end
                            {CheckList L1.2 L2.2 MatchBool ENext EOrig ENew}
                        else MatchBool = false ENew = EOrig
                        end
                    end
                else
                    if L1.1.1 == L2.1.1 then
                        case L2.1.2.1
                        of ident(P) then
                            case L1.1.2.1 of equivalence(Q) then {AdjoinAt E P Q ENext}
                            else {Browse 'Some SAS error'}
                            end
                        else {Browse 'Some SAS error'}
                        end
                        {CheckList L1.2 L2.2 MatchBool ENext EOrig ENew}
                    else MatchBool = false ENew = EOrig
                    end
                end
            end
        end
    end
    end
end

% Pattern Matching
declare MatchSucceeds
proc {MatchSucceeds X P E ENew MatchBool}
    local MatchBool2 ENew2 in
    case {FindHead E.X}
    of [record literal(A) L1] then
        case P
        of [record literal(B) L2] then
            if A==B then
                {CheckList L1 L2 MatchBool2 E E ENew2}
                if MatchBool2 then MatchBool = true ENew = ENew2
                else MatchBool = false ENew = E
                end
            else MatchBool = false ENew = E
            end
        end
    else MatchBool = false ENew = E
    end
    end
end

% declare UpdateCE
% proc {UpdateCE X LX CE CEInit}
%     if {Member X LX} then skip
%     else {AdjoinAt CEInit X  CE}
%     end
% end

% declare FindContext
% proc {FindContext S LX CE CEInit}
%     loc CELoc in
%     case S
%     of nil then skip
%     [] H | T then
%         case H
%         of nil then {FindContext T LX CE CEInit}
%         [] ident(X) | T then {UpdateCE X LX CE CEInit} CELoc = CE {FindContext T LX CE CELoc}
%         [] [H] | T then {FindContext T LX CE} {FindContext T LX CE}
%         [] H | nil then {FindContext H LX CE}
%         else
%         end
    

    

% Recursive function to process the Semantic Stack
declare Interpret
fun {Interpret Stack}
    local ENew MatchBool CE in
    case Stack 
        of nil then local Ans in {Dictionary.toRecord kkd SAS Ans} {Browse Ans} end nil
        [] (pair(stmt: S env: E)) | StackT then
            case S
                of nil then {Interpret StackT}
                [] [nop] | T then {Interpret (pair(stmt: T env: E)) | StackT}
                [] [var ident(X) S] | T then {Interpret (pair(stmt: [S] env: {CreateVar E X})) | (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) ident(Y)] | T then {Unify ident(X) ident(Y) E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) literal(N)] | T then {Unify ident(X) literal(N) E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] [bind ident(X) [record literal(A) L]] | T then {Unify ident(X) [record literal(A) L] E} {Interpret (pair(stmt: T env: E)) | StackT}
                % [] [bind ident(X) [proce LX S]] | T then {Unify ident(X) [record literal(procedure) [[literal(args) LX] [literal(st) S] [literal(context) E]]] E} {Interpret (pair(stmt: T env: E)) | StackT}
                [] [match ident(X) P S1 S2] | T then
                    {MatchSucceeds X P E ENew MatchBool}
                    if MatchBool then {Interpret (pair(stmt: [S1] env: ENew)) | (pair(stmt: T env: E)) | StackT}
                    else {Interpret (pair(stmt: [S2] env: E)) | (pair(stmt: T env: E)) | StackT}
                    end
                [] H | nil then {Interpret (pair(stmt: H env: E)) | StackT}
                else {Browse 'Error in structure of input program.'} nil
            end
    end
    end
end

% The Interpreter function to be called
declare Interpreter
fun {Interpreter Program}
    {Interpret [pair(stmt: [Program] env: env())]}
end

% Test cases
declare Res
Res = {Interpreter 
[[var ident(y) [[nop] [var ident(x) 
    [[var ident(x1) 
        [[var ident(x2) 
            [
                [bind ident(y) literal(n)]
                [bind ident(x) [record literal(recLabel) [[ident(y) ident(x1)] [literal(f2) ident(x2)]]]]
                [bind ident(x1) literal(m)]
                [match ident(x) [record literal(recLabel) [[literal(n) ident(x10)] [literal(f2) ident(x20)]]] [var ident(pass) [bind ident(x2) ident(pass)]] [bind ident(x2) literal(o)]]
            ]
        ]]
    ]]
]]]]}
{Browse Res}
% declare Res2
% Res2 = {Interpreter [[var ident(z) [bind ident(z) [record literal(rec) [[literal(f1) literal(v1)] [literal(f2) literal(v2)]]]]]]}
% {Browse Res2}