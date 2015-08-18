package br.unit.compiler.simple;
import java_cup.runtime.Symbol;
import br.unit.compiler.simple.*;

%%

%class Lexer
%cup
%public
%line
%column

ALPHA      = [A-Za-z] 
DIGIT      = [0-9] 
NUMBER     = {DIGIT}+ (("."|",") {DIGIT}+)? (("e"|"E") ("+"|"-")? {DIGIT}+ )?  
IDENTIFIER = {ALPHA}({ALPHA}|{DIGIT}|_)* 

%%

{NUMBER}     { return new Symbol(sym.NUMBER,new String(yytext())); }

{IDENTIFIER} { return new Symbol(sym.ID,new String(yytext())); }

"+"          { return new Symbol(sym.PLUS); }

"*"          { return new Symbol(sym.TIMES); }

\ |\n        {}

.            { System.out.println("Illegal character: <" + yytext() + ">"); }