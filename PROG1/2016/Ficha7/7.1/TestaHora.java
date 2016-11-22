/*
 * TestaHora.java
 * 
 * Copyright 2016 Mário Alexandre Lopes Liberato <mliberato@ua.pt>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */


import java.util.Scanner;

public class TestaHora 
{
  static final Scanner sca = new Scanner(System.in);
  
  public static void main(String[] args) 
  {
    Hora inicio;  // tem de definir o novo tipo Hora!
    Hora fim;
    
    inicio = new Hora();
    inicio.h = 9;
    inicio.m = 23;
    inicio.s = 5;
    fim = new Hora();
    
    System.out.print("Começou às ");
    printHora(inicio);  // crie esta função!
    System.out.println(".");
    System.out.println("Quando termina?");
    fim = lerHora();  // crie esta função!
    System.out.print("Início: ");
    printHora(inicio);
    System.out.print(" Fim: ");
    printHora(fim);
  }
  
  static void printHora(Hora time)
  {
	  System.out.printf("%02d:%02d:%02d", time.h, time.m, time.s);
	  return;
  }
  
  static Hora lerHora()
  {
	  Hora tmp = new Hora();
	  String pChar[] = { "h", "m", "s" };
	  int curInput[] = new int[3];
	  int inpLimit[][] = { {0, 23}, {0, 59}, {0, 59} };
	  boolean finishedInput = false;
	  int curChar = 0;
	  
	  while(!finishedInput)
	  {
		  System.out.printf("%s >", pChar[curChar]);
		  curInput[curChar] = sca.nextInt();
		  
		  if (curInput[curChar] >= inpLimit[curChar][0] && curInput[curChar] <= inpLimit[curChar][1])
		  {
			  curChar++;
			  if (curChar == 3) finishedInput = true;
		  }
	  }
	  tmp.h = curInput[0];
	  tmp.m = curInput[1];
	  tmp.s = curInput[2];
	  
	  return tmp;
  }

}

class Hora
  {
	  int h, m, s;
  }

