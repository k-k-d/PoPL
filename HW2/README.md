# HW2 - Declarative Sequential Interpreter written in Oz  

(Note: This has been done as an individual project)  

Overview of the implementation of the interpreter:  
1. The program, when fed into the Interpreter function is wrapped into a semantic stack and the Interpret function recursively operates on this stack till it becomes empty.  
2. The SAS is implemented with a dictionary and is roughly maintained as a union-find datastructure. Also, a cell is used to maintain indexing in the dictionary (SAS).  
3. Only the following portions of the problem statement have been implemented. These are questions 1, 2, 3, 4a, 4b, 5. The two questions related to dealing with procedures i.e. questions 4c, 6 have been skipped.  
4. Basic error handling has been done and the program can roughly notify if anything goes wrong but it is preferable if the input program to the Interpreter function is free of errors.  

Specific notes and instructions:  
1. The unification code given by the instructor as Unify.oz has been used. The required SAS functions RetrieveFromSAS, BindRefToKeyInSAS and BindValueToKeyInSAS have been implemented in the file SingleAssignmentStore.hs along with some other helper functions.  
2. The main interpreter program is present in Interpreter.oz. The AST code needs to be given as an argument to the Interpreter function to begin interpretation. The program finally prints out the state of the SAS. The file Interpreter.oz also has multiple utility functions to help the interpreter.  
3. In summary, any operation described in the problem statement can be handled except for procedure binding and procedure application. That is, this interpreter implements basic control flow (Q1), variable creation (Q2), variable-variable binding (Q3), variable-literal binding (Q4a), variable-record binding (Q4b) and pattern matching (Q5) functionalities.
