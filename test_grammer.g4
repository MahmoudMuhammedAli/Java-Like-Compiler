grammar test_grammer;
options
    {
         language = Java;
    }
Whitespaces : [ \t\r\n]+ -> skip ;

//start: Type WS CHAR WS SIGN WS (NUM|DecNum) Simi;
//Type: ('int'|'double'|'float');
//CHAR : 'a'..'z'+ |'A'..'Z'+ | 'a'..'z'+NUM |'A'..'Z'+NUM;
//SIGN : '=';
//NUM : '0'..'9'+;
//DecNum: '0'..'9'+ '.' '0'..'9' + |'.' '0'..'9'+;
//Simi: ';';
//WS: (' '| '\n' |'\r')+ {skip();};

stat: if_stat| declaration | assignment | while_stat ;
while_stat: WHILE expr stat_block;
declaration : Type assignment;
assignment:  ID ASSIGN expr SCOL;
if_stat: IF condition_block (ELSE IF condition_block)* (ELSE stat_block)?;
condition_block: expr stat_block;
block:stat*;
stat_block: OBRACE block CBRACE |stat;

expr: expr POW<assoc=right> expr
|MINUS expr| NOT expr
|expr op=(MULT | DIV| MOD) expr
|expr op=(PLUS| MINUS) expr
| expr op=(LTEQ| GTEQ| LT| GT)expr
|expr op=(EQ| NEQ)expr
| expr AND expr
|expr OR expr |atom;

atom:CPAR expr OPAR
|(INT |FLOAT)
|(TRUE| FALSE)
|ID
|STRING
|NIL;

Type : 'int'
| 'double'
| 'float'
| 'short'
| 'long'
| 'char';

OR:'||';
AND:'&&';
EQ:'==';
NEQ:'!=';
GT:'>';
LT:'<';
GTEQ:'>=';
LTEQ:'<=';
PLUS:'+';
MINUS:'-';
MULT:'*';
DIV:'/';
MOD:'%';
POW:'^';
NOT:'!';
SCOL:';';
ASSIGN:'=';
OPAR:')';
CPAR:'(';
OBRACE:'{';
CBRACE:'}';

TRUE: 'true';
FALSE:'false';
NIL:'nil';
IF:'if';
ELSE:'else';
WHILE:'while';
ID: [a-zA-Z_] [a-zA-Z_0-9]*;
INT:[0-9]+;




FLOAT:[0-9]+ '.'[0-9]* | '.'[0-9]+;

STRING: '"' (~["\r\n] | '""')* '"';