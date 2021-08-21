/* Compiler Theory and Design
Dr. Duane J. Jarc
Edited: Sachin Saigal
Date 6/27/21
file scanner.l
*/
/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws		[ \t\r]+
comment		\-\-.*\n
line		[\n]
id		[A-Za-z][A-Za-z0-9]*
digit		[0-9]
int		{digit}+
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"		{ ECHO; return(RELOP); }
">"		{ ECHO; return(RELOP); }
"="             { ECHO; return(RELOP); }
"/="            { ECHO; return(RELOP); }
">="            { ECHO; return(RELOP); }
"<="            { ECHO; return(RELOP); }
"+"		{ ECHO; return(ADDOP); }
"-"             { ECHO; return(ADDOP); }
"/"             { ECHO; return(MULOP); }
"*"		{ ECHO; return(MULOP); }
"**"            { ECHO; return(EXPOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end		{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is		{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and		{ ECHO; return(ANDOP); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }


case            { ECHO; return(CASE); }
else            { ECHO; return(ELSE); }
endcase         { ECHO; return(ENDCASE); }
endif           { ECHO; return(ENDIF); }
if              { ECHO; return(IF); }
others          { ECHO; return(OTHERS); }
real            { ECHO; return(REAL); }
then            { ECHO; return(THEN); }
when            { ECHO; return(WHEN); }
rem             { ECHO; return(REMOP); }

"=>"            { ECHO; return(ARROW); }

or              { ECHO; return(OROP); }
not             { ECHO; return(NOTOP); }





%%
int main()
{
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token)
	{
		fprintf(file, "%d %s\n", token, yytext);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}
