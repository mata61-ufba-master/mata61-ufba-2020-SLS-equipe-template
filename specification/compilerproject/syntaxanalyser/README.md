# Projeto de um Compilador

## Parte II: Análise Sintática

Nesta parte do projeto, você irá implementar um analisador sintático para a [linguagem C-](../../language/README.md).
O analisador sintático ou _parser_ deve receber uma sequência de _tokens_ gerados pelo analisador léxico.
Se uma entrada inválida for encontrada, ele deve parar e informar _error_.

Antes de iniciar a sua implementação, 
recomendamos que leia com atenção o [capítulo 6](../../resources/chapter6.pdf) 
do livro "Introduction to Compilers and Language Design" de Douglas Thain. 
Apesar da sintaxe de C- ser um pouco diferente da usada no livro acima, 
os exemplos de código e o material podem ser extremamente úteis.

### Notação para a Árvore Sintática Abstrata (Abstract Syntax Tree - AST)

Há diversas formas para representar árvores sintáticas corretas geradas para um programa em C-. 
Assim, em nosso projeto de compilador, é importante definir e usar um formato único para representar
o código na AST, que contenha um número mínimo de nós e que seja independente de qualquer implementação de linguagem específica.

Em nosso projeto de compilador, a saída do analisador sintático (_parser_) usará uma notação _labelled bracketing_. 
Tal notação define listas aninhadas de prefix expressions e é equivalente à representação
por meio uma estrutura de árvore. As prefix expressions correspondem aos nós da AST.

```
[operator [operand1] ... [operandN]]
```

Recursivamente, cada operando pode ser definido por outro operador; por exemplo,
```
[op1 [op2 [a] [b]] [c]]
```
onde o operador ```op1``` possui dois operandos: ```[op2 [a] [b]]``` e ```[c]```,  e o operator ```op2``` tem dois operandos: ```[a]``` e ```[b]```. 

Assim, a expressão ```4 == (2 + 2)``` em C-, 
é representada como ```[== 4 [+ 2 2]]``` na notação da AST.

#### Listas de nós que podem ser mostrados na AST
A seguir, apresentamos os tipos de nós que podem aparecem em uma AST e seus nomes correspondentes, e que deverão ser produzidos pelo seu analisador sintático:  

```

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

```
. . .
