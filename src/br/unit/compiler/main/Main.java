package br.unit.compiler.main;

import java.io.FileReader;

import java_cup.runtime.Symbol;
import br.unit.compiler.simple.Lexer;
import br.unit.compiler.simple.sym;


public class Main{
	  public static void main(String args[]){
	    try{
	      String filename = "teste/programtest";
	      Lexer scanner = new Lexer( new FileReader(filename));
	      
	      Symbol simbolo = new Symbol(100);
	      
	      while(simbolo.sym != sym.EOF) {
	    	  simbolo = scanner.next_token(); 
	    	  System.out.println(simbolo.toString() + " " + simbolo.value);
	    	  
	      }
	      
	    }
	    catch(Exception e){
	      e.printStackTrace();
	    }
	  }
	}
