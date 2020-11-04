# Projeto de um Compilador

## Parte II: Análise Sintática

Nesta parte do projeto, você irá implementar um analisador sintático para a [linguagem C-](../../language/README.md).
O analisador sintático ou _parser_ deve receber uma sequência de _tokens_ gerados pelo analisador sintático.
Se uma entrada inválida for encontrada, ele deve parar e informar _error_.

Antes de iniciar a sua implementação, 
recomendamos que leia com atenção o [capítulo 6](../../resources/chapter6.pdf) 
do livro "Introduction to Compilers and Language Design" de Douglas Thain. 
Apesar da sintaxe de C- ser um pouco diferente da usada no livro acima, 
os exemplos de código e o material podem ser extremamente úteis.

### Notation for the AST

There are several possible correct parse trees that can be generated for a program input. 
Thus, in our compiler project it is important to have a unique format for 
representing the code in the AST that contains a minimum number of nodes and i
is independent of any specific language implementation. 

In our compiler project, the output of the parser will use a labelled bracketing notation as shown below. 
This notation is written in nested lists of prefix expressions and is equivalent to the representation 
by means of a tree structure.  The prefix expressions correspond to the nodes in the AST.

```
[operator [operand1] ... [operandN]]
```

Recursively, each operand can be defined by another operator; for example,
```
[op1 [op2 [a] [b]] [c]]
```
where op1 has two operands: [op2 [a] [b]] and [c],  and operator op2 has two other operands: [a] and [b]. 

As an example, the expression written ```4 == (2 + 2)``` in the C- language, 
is represented as ```[== 4 [+ 2 2]]``` in the AST notation.

#### List of nodes to be shown in the AST
Below are the AST nodes and corresponding names that need to be produced by the parser:

[program  ... ]

[var-declaration  ... ]

[int]              ---> only int is allowed, variables cannot has void type

[ID]                 ---> variable name

[\[\]]           ---> (optional) symbol to describe a variable as array; IMPORTANT: the backslash \ symbol is used to not interpret [ or ] as bracket nodes, but to be seen as visible symbols in the AST.

[fun-declaration  ... ]

[int] / [void]       ---> either int or void type

[ID]                              ---> function name

[params  ...  ]

[param  ... ]               ---> (optional) parameter info

[int] / [void]       ---> either int or void type

[ID]                 ---> variable name

[compound-stmt  ... ]                       ---> (child options below)

[;]                                                  ---> either null statement

[selection-stmt ... ]             ---> or IF statement

[EXPRESSION                     ---> recursive definition of any valid expression (binary expression, variable reference, function call, etc)

[compound-stmt  ...]       --> "then" (true) branch

. . .

[compound-stmt  ... ]      --> (optional) "else" (false) branch

. . .

[iteration-stmt  ... ]

[EXPRESSION                     ---> recursive definition of any valid expression (binary expression, variable reference, function call, etc)

[compound-stmt ... ]        --> loop block of statements

. . .

[return-stmt ... ]

[EXPRESSION                     ---> recursive definition of any valid expression (binary expression, variable reference, function call, etc)

[OP ... ]                      ---> operators of binary expressions OP = {+, -, *, /, <, <=, >, >=, ==, !=, =}                             (child options below)

[var  ... ]               ---> variable reference

[ID]

[NUM]     ---> (optional) if array index

[NUM]               ---> constant reference

[call  ... ]              ----> function call

[ID]

[args ... ]             ----> function arguments

[var ... ]            . . .

[NUM]                          .. . 

[call ... ]     . . .

[OP ... ]              . . .

[OP ... ]              ---> recursively another binary expression

. . .
