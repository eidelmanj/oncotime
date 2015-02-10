%{
#include "y.tab.h"
#include <string.h>
#include <stdlib.h>


extern void yyerror(char *error);
extern int line;
%}

%x comment
%%



\n { line++;}
"//".*   
[ \t]+

[a-zA-Z_][a-zA-Z0-9_]*".grp" return tExternalFile;

 "/*"         BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s */
<comment>\n             ++line;
<comment>"*"+"/"        {
    BEGIN(INITIAL);
    return COMMENT;
}

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
"print"      return FUNC;
"patient"    return PATIENT;
"patients"   return PATIENTS;
"doctor"     return DOCTOR;
"diagnosis"  return DIAGNOSIS;
"timeline"   return TIMELINE;
"of"         return OF;
"is"         return IS;
"events"     return EVENTS;
"are"        return ARE;
"use"        return USE;

"group"      return GROUP;
"barchart"   return FUNC;
"element"    return ELEMENT;

"sequences"  return SEQUENCES;
"sequence"   return SEQUENCE;

"like"       return LIKE;
"list"       return LIST;
"native"     return NATIVE;
"script"     return SCRIPT;


"count"      return COUNT;
"by"         return BY;

"table"      return TABLE;

"population" return POPULATION;
"period"     return PERIOD;

"to"         return TO;

"length"     return LENGTH;



(0|[1-9][0-9]*)\.[0-9]* { yylval.fval = atof(yytext); return tFloat; }
0|([1-9][0-9]*)            { yylval.ival = atoi(yytext); return tInt; }




[a-zA-Z_][a-zA-Z0-9_]* {
   yylval.stringconst =
      (char *) malloc (strlen(yytext) + 1 );
   sprintf(yylval.stringconst, "%s", yytext);
   return tIdentifier;
}

. {yyerror("Error parsing!\n"); exit(1);}

%%
