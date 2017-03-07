%option noyywrap
%{
#include <stdio.h>
int possiblewords = 0;
int validwords = 0;
int invalidwords = 0;
%}

DIGIT0  [0-9]  
DIGIT   [1-9] 
RULE1   (0)|(-?[1-9][0-9]*)  
RULE2   (-?0\.[0-9]+)|(-?[1-9][0-9]*\.[0-9]+)

%% 
0 {possiblewords++; validwords++; printf("%s is a number(rule1)\n", yytext);}

-?{DIGIT}{DIGIT0}*  {possiblewords++; validwords++; printf("%s is a number (rule1)\n", yytext);} 

-?0\.{DIGIT0}+ {possiblewords++; validwords++; printf("%s is a number (rule2)\n", yytext);}

-?{DIGIT}{DIGIT0}*\.{DIGIT0}+ {possiblewords++; validwords++; printf("%s is a number (rule2)\n", yytext);}

({RULE1}|{RULE2})["e"|"E"]{RULE1} {possiblewords++; validwords++; printf("%s is a number (rule3)\n", yytext);}

-?0[1-7][0-7]* {possiblewords++; validwords++; printf("%s is a number (rule4)\n", yytext);}

00 {possiblewords++; validwords++; printf("%s is a number(rule4)\n", yytext);}

-?0["x"|"X"][A-F0-9]+ {possiblewords++; validwords++; printf("%s is a number (rule5)\n", yytext);}

[[:space:]]+ /* skips whitespace */

.       {  
            int c;
             
            while( (c = input()) != ' ')
                {
                    yymore();
                }
            possiblewords++; 
            printf("%s is not a number (rule8)\n", yytext);
        } 
            

%%

main(argc, argv)
int argc;
char **argv;
{
    if(argc > 1) {
        if(!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return (1);
        }
    }

    yylex();
}
