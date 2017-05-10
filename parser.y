%{
#  include <stdio.h>
#  include <stdlib.h>
#  include "fb3-2.h"
%}

%token ASSIGNOP
%token MULOP
%token ADDOP
%token INCOP
%token RELOP
%token NOT
%token OR
%token AND
%token FLT_LITERAL
%token INT_LITERAL
%token STR_LITERAL
%token STREAMIN
%token STREAMOUT
%token ID  

%%

program: variable_definitions function_definitions

function_definitions: function_head block
                    | function_definitions function_head block

identifier_list: ID
                | ID [ INT_LITERAL ]
                | identifier_list , ID
                | identifier_list , ID
                | identifier_list , ID [ INT_LITERAL ]

variable_definitions: <epsilon>
                    | variable_definitions type identifier_list ;

type: INT
    | FLOAT

function_head: type ID arguments

arguments: ( parameter_list )

parameter_list: <epsilon>
                | parameters

parameters: type ID
            | type ID [ ]                                 
            | parameters , type ID
            | parameters , type ID [ ]

block: { variable_definitions statements }

statements:  | [epsilon] not sure how this is used. 
	     | statements statement

statement:   | expression ;
             | compound_statement
             | RETURN expression ;
             | IF ( bool_expression ) statement ELSE statement
             | WHILE ( bool_expression ) statement
             | input_statement ;
             | output_statement ;

input_statement: | CIN
                 | input_statement STREAMIN variable

output_statement: | COUT
                  | output_statement STREAMOUT expression
                  | output_statement STREAMOUT STR_LITERAL
                  | output_statement STREAMOUT ENDL

compound_statement: | { statements }

variable: | ID
          | ID [ expression ]

expression_list: | [epsilon]
                 | expressions

expressions: | expression
             | expressions , expression

expression ::= variable ASSIGNOP expression
		   ::= variable INCOP expression	
		   ::= simple_expression
		   
simple_expression ::=term
				  ::= ADDOP term
				  ::= simple_expression ADDOP term
				  
term  ::=factor
	  ::=term MULOP factor
	  
factor ::=ID
	   ::=ID (expression_list)
	   ::=literal
	   ::=( expression)
	   ::= ID [expression]
	   
literal ::=INT_LITERAL
		::=FLT_LITERAL
	   
bool_expression ::=boolterm
				::=bool_expression OR boolterm

bool_term ::= bool_factor
		  ::= boolterm AND bool_factor

bool_factor ::=NOT bool_factor
			::=(bool_expression)
			::=simple_expression RELOP simple_expression
%%
