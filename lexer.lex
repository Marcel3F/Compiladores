package br.unit.compiler.simple;
import java_cup.runtime.Symbol;
import br.unit.compiler.simple.*;

%%

%class Lexer
%cup
%public
%line
%column


READ       = [rR][eE][aA][dD]
WRITE	   = [wW][rR][iI][tT][eE]
IF		   = [iI][fF]
ELSE       = [eE][lL][sS][eE]
ELIF       = [eE][lL][iI][fF]
WHILE      = [wW][hH][iI][lL][eE]
INT        = [iI][nN][tT]
BOOL       = [bB][oO][oO][lL]
VOID       = [vV][oO][iI][dD]
AND        = [aA][nN][dD]
OR         = [oO][rR]
NOT        = [nN][oO][tT]
PASS       = [pP][aA][sS][sS]
TRUE       = [tT][rR][uU][eE]
FALSE	   = [fF][aA][lL][sS][eE]
ESPACOBRANCO = [ \n\t\r\f]+
ALPHA      = [A-Za-z] 
DIGIT      = [0-9] 
NUMBER     = {DIGIT}+ (("."|",") {DIGIT}+)? (("e"|"E") ("+"|"-")? {DIGIT}+ )?  
IDENTIFIER = {ALPHA}({ALPHA}|{DIGIT}|_)* 
COMENTARIO = ("{"){ALPHA}{DIGIT}{NUMBER}+("}") 


%%

{ESPACOBRANCO} {}

{COMENTARIO}   { return new Symbol(sym.COMENTARIO,new String(yytext())); }

//PALAVRAS RESERVADAS

{READ}	     { return new Symbol(sym.READ,new String(yytext())); }
{WRITE}	     { return new Symbol(sym.WRITE,new String(yytext()));}
{IF}         { return new Symbol(sym.IF,new String(yytext()));   }
{ELSE}       { return new Symbol(sym.ELSE,new String(yytext())); }
{ELIF}       { return new Symbol(sym.ELIF,new String(yytext())); }
{WHILE}      { return new Symbol(sym.WHILE,new String(yytext()));}
{INT}        { return new Symbol(sym.INT,new String(yytext()));  }
{BOOL}       { return new Symbol(sym.BOOL,new String(yytext())); }
{VOID}       { return new Symbol(sym.VOID,new String(yytext())); }
{AND}        { return new Symbol(sym.AND,new String(yytext()));  }
{OR}         { return new Symbol(sym.OR,new String(yytext()));   }
{NOT}        { return new Symbol(sym.NOT,new String(yytext()));  }
{PASS}       { return new Symbol(sym.PASS,new String(yytext())); }
{TRUE}       { return new Symbol(sym.TRUE,new String(yytext())); }
{FALSE}      { return new Symbol(sym.FALSE,new String(yytext()));}


{NUMBER}     { return new Symbol(sym.NUMBER,new String(yytext())); }

{IDENTIFIER} { return new Symbol(sym.ID,new String(yytext())); }

"+"          { return new Symbol(sym.PLUS); }

"*"          { return new Symbol(sym.TIMES); }



.            { System.out.println("Illegal character: <" + yytext() + ">"); }


