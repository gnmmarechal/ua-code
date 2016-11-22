/*
 * tabuada.java
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
import java.util.*;

public class tabuada 
{
	static boolean checkValid(int n)
	{
		return (n>0 && n<100);
	}
	static void printTab(int n)
	{
		String bar = "--------------------";
		
		//Head
		System.out.printf(bar + "\n|  Tabuada dos %02d  |\n" + bar, n);
		
		//Body
		int count = 1;
		do
		{
			System.out.printf("\n| %02d x  %d  |  %03d  |", n, count, n*count);
			count++;
		} while(count<10);
		System.out.printf("\n| %02d x %d  |  %03d  |\n", n, count, n*count);
		//Footer
		System.out.println(bar);
	}
	
	public static void main (String args[]) 
	{
		Scanner sca = new Scanner(System.in);

		
		System.out.printf("Insira um número inteiro maior que 0 e menor que 100:\n>");
		int input = sca.nextInt();
		if(checkValid(input))
		{
			printTab(input);
			return;
		}
		else
		{
			System.out.println("Erro. Input inválido.");
			return;
		}
	}
}

