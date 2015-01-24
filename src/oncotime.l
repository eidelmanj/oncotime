%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>

extern int line;
%}

%%

\n { line++;}
"//".*   
[ \t]+

[a-zA-Z_][a-zA-Z0-9_]*".grp" return tExternalFile;

"\"".*"\""                   {
   yylval.stringconst =
      (char *) malloc (strlen(yytext) + 1 );
   sprintf(yylval.stringconst, "%s", yytext);
   return tString;
    
}

"*"       return '*';
"/"       return '/';
"+"       return '+';
"-"       return '-';
"("       return '(';
")"       return ')';
";"       return ';'; 
":"       return ':'; 

"{"       return '{';

"}"       return '}';

"["       return '[';
"]"       return ']';

"\."      return '.';

","       return ',';



"="       return '=';
"->"      return ARROW;
"|"       return '|';

"not"     return NOT;



"if"      return IF; 
"else"    return ELSE; 
"endif"   return ENDIF; 
"then"    return THEN; 



"foreach"    return FOREACH;
"print"      return PRINT;
"patients"   return PATIENTS;
"timeline"   return TIMELINE;
"of"         return OF;
"is"         return IS;
"events"     return EVENTS;
"are"        return ARE;
"use"        return USE;

"group"      return GROUP;
"barchart"   return BARCHART;
"element"    return ELEMENT;

"sequences"  return SEQUENCES;
"like"       return LIKE;
"list"       return LIST;
"native"     return NATIVE;
"script"     return SCRIPT;

"population" return POPULATION;
"period"     return PERIOD;

"to"         return TO;



(0|[1-9][0-9]*)\.[0-9]* { yylval.fval = atof(yytext); return tFloat; }
0|([1-9][0-9]*)            { yylval.ival = atoi(yytext); return tInt; }




[a-zA-Z_][a-zA-Z0-9_]* {
   yylval.stringconst =
      (char *) malloc (strlen(yytext) + 1 );
   sprintf(yylval.stringconst, "%s", yytext);
   return tIdentifier;
}

. {yyerror(); exit(1);}

%%