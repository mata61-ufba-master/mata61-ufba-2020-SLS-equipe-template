%token FALSE
%token TRUE
%token OR
%token AND
%token NOT

%%

bexpr: 
bexpr OR btermo
| btermo
;

btermo:
btermo AND bfator
| bfator
;

bfator:
NOT bfator 
| "(" bexpr ")" 
| TRUE 
| FALSE
;

%%


