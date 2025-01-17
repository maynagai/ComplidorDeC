grammar GramaticaC;

@header { package compiladorc.parser;}

programa:   includes?
            |globais?
            |functions?
            main
            ;
includes:   (INCLUDE STR)+
            ;
globais:    GLOBAIS OPC vars CLC
            ;
vars:       (type ids EOL)+
            ;
functions:  function+
            ;
function:   FUNCTION ID OPP ((type ID SEP)* type ID)? CLP block
            ;
main:       MAIN ID OPP ((type ID SEP)* type ID)? CLP block
            ;
block:      OPC line CLP
            ;
line:         read          #lineRead
            | write         #lineWrite
            | atr           #lineAtr
            | ifstm         #lineIfStm
            | whileLoop     #lineWhileLoop
            | forLoop       #lineForLoop
            ;
whileLoop:  ;
forLoop:    ;
read:       READ ID
            ;
write:        WRITE STR     #writeStr
            | WRITE expr    #writeExpr
            ;
atr:        ID ATR expr
            ;
ifstm:        IF OPP boolExpr CLP block
            | IF OPP boolExpr CLP block ELSE block
            ;
expr:         term ADD expr
            | term SUB expr
            ;
term:         fact MUL term
            | fact DIV term
            | fact MOD term
            ;
fact:         ID
            | NUM
            | OPP expr CLP
            ;
boolExpr:     fact
            | NOT boolExpr
            | fact relop fact
            | TRUE
            | FALSE
            ;
relop:        GR
            | LS
            | EQ
            | GRT
            | LST
            | NEQ
            ;
type:       INT
            | FLOAT
            | DOUBLE
            | CHAR
            | BOOL;
ids:        ID
            ;

//tokens
INT         :'int';
FLOAT       :'float';
DOUBLE      :'double';
CHAR        :'char';
BOOL        :'bool';
INCLUDE     :'#include';
TRUE        :'true';
FALSE       :'false';
READ        :'read';
WRITE       :'write';
IF          :'if';
ELSE        :'else';
GLOBAIS     :'global';
OPC         :'{';
CLC         :'}';
OPP         :'(';
CLP         :')';
//Tirei var e colocar ID          :[a-zA-Z]\w*;//-->ver
SEP         :',';
FUNCTION    :'function';
MAIN        :'main';
ATR         :'=';
NOT         :'!'|'NOT';
ADD         :'+';
SUB         :'-';
MUL         :'*';
DIV         :'/';
MOD         :'%';
EOL         :';';
GR          :'>';
LS          :'<';
EQ          :'==';
GRT         :'>=';
LST         :'<=';
NEQ         :'!=';
STR         :'"'(~["\\\r\n])*'"';
NUM         :[+-]?[0-9]+('.'[0-9]+)?;
ID          :[a-zA-Z][a-zA-Z0-9_]*;
COMMENT     :'/*' .*? '*/' -> skip;
LINE_COMMENT:'//' ~[\r\n]* -> skip;
WS          :[ \t\r\n]+ -> skip;