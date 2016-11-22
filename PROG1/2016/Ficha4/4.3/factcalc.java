/*
 * factcalc.java
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

public class factcalc 
{
	static int fact(int n)
	{
		int factorial = 1;
		int count = 1;
		do
		{
			factorial *= count;
			count++;
		} while (count<=n);
		
		return factorial;
	}
	
	static boolean checkValid(int n)
	{
		return (n>0 && n<=10); //n não pode ser 0 no contexto deste problema (?), apesar de 0! = 1
	}
	public static void main (String args[]) 
	{
		Scanner sca = new Scanner(System.in);
		System.out.printf("Insira um número inteiro entre 0 e 10:\n>");
		int input = sca.nextInt();
		
		if (checkValid(input))
		{
			int counter = 1;
			System.out.printf("\n");
			do
			{
				System.out.printf(counter + "! = " + fact(counter) + "\n");
				counter++;
			} while(counter<=input);
		}
		else
		{
			System.out.println("Erro. Input inválido.");
			return;
		}
	}
}

