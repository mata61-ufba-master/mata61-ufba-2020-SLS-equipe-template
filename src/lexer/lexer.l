%{
#include "parser.tab.h"
%}

%%
[0-9]+          { return NUM; }
("if"|"else"|"int"|"return"|"void"|"while")    { return KEY; }
[A-Za-z][A-Za-z0-9]*                    { return ID; }
"//".*          { /* comment */ }
"!="            { return SYM; }
"="             { return SYM; }
"=="            { return SYM; }
"<="            { return SYM; }
">="            { return SYM; }
"<"             { return SYM; }
">"             { return SYM; }
","             { return SYM; }
";"             { return SYM; }
"("             { return SYM; }
")"             { return SYM; }
"{"             { return SYM; }
"}"             { return SYM; }
"["             { return SYM; }
"]"             { return SYM; }
"+"             { return SYM; }
"-"             { return SYM; }
"*"             { return SYM; }
"/"             { return SYM; }
[ \t]           { /* skip white space */ }
[\n]            { /* skip newline */ }
.               { return ERROR; }
%%
