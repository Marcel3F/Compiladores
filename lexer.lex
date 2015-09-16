package br.unit.compiler.simple;
import java_cup.runtime.Symbol;
import br.unit.compiler.simple.*;
import java.util.Stack;
import java.io.StringReader;


%%

%class Lexer
%cup 
%public
%line
%column


%{	

	Stack<Integer> levels;
	
	private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
    
    private void initStack(){
	  levels = new Stack<Integer>();
	  levels.push(0);
	}
%}

%init{
  initStack();
%init}


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

ESPACOBRANCO = [ \n]

ALPHA      = [A-Za-z] 
DIGIT      = [0-9] 
NUMBER     = {DIGIT}+ (("."|",") {DIGIT}+)? (("e"|"E") ("+"|"-")? {DIGIT}+ )?  
IDENTIFIER = {ALPHA}({ALPHA}|{DIGIT}|_)* 
COMENTARIO = ("{"){ALPHA}{DIGIT}{NUMBER}+("}") 


%%

\n[ ]*[^ ]              {
                        yypushback(1); 
 						int level = yytext().length()-1;
 						int curr = levels.peek();
 						
 						if(level > curr) {
 						  levels.push(level);
 						  return new Symbol(sym.BEGIN, yyline);
 						} else if(level < curr) {
						  levels.pop();
						  yypushback(level+1);
						  return new Symbol(sym.END, yyline);
 						} else {
 						  // não faz nada!
 						}
                      } 

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

"-"          { return new Symbol(sym.SUB); }

"*"          { return new Symbol(sym.TIMES); }

"("          { return new Symbol(sym.ABREPARENTESE); }

")"          { return new Symbol(sym.FECHAPARENTESE); }

":"          { return new Symbol(sym.DOISPONTOS); }

":="          { return new Symbol(sym.ATRIBUICAO); }

"<"          { return new Symbol(sym.MENORQUE); }

">"          { return new Symbol(sym.MAIORQUE); }

"="          { return new Symbol(sym.IGUAL); }

.            { System.out.println("Illegal character: <" + yytext() + ">"); }

