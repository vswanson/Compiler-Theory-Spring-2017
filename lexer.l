%{
/* includes and global vars go here */
%}

/* flex definitions go here */

%%

/* rules go here */
"COUT <<" {return STREAMOUT}
\"(\\.|[^"])*\" {return STR_LITERAL}
"(" |
")" |
"[" |
"]" |
"{" |
"}" |
";" |
"," {return yytext[0]}

%%

/* c code goes here */

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
