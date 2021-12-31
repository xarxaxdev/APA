#header 
<< #include "charptr.h" >>

<<
#include "charptr.c"

int main() {
   ANTLR(expr(), stdin);
}
>>

#lexclass START
#token NUM "[0-9]+"
#token PLUS "\+"
#token MINUS "\-"
#token MUL "\*"
#token DIV "\/"
#token SPACE "[\ \n]" << zzskip(); >>

expr: NUM (add|subs)*  "@" ;
add: PLUS (NUM|expr2)*;
subs: MINUS (NUM|expr2)*;
expr2: MUL NUM |DIV NUM;