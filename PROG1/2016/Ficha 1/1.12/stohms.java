/*
 * stohms.java
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

//P1 2016 Folha Ex. 1 Ex.1.12
//Objectivo: A partir de 1 valor inserido em segundos, converter para o formato h:m:s


import java.util.*;


public class stohms
{
	
	public static void main (String args[]) 
	{
		int rems,ins,h,m,s;
		Scanner sca = new Scanner(System.in);
		System.out.print("Insira o tempo (s):");
		ins = sca.nextInt();
		// Calcular 
		h = ins/3600;
		m = (ins%3600)/60;
		s = (ins%3600)%60;
		System.out.printf("%ds -->  %dh:%dm:%ds\n", ins, h, m, s);
		
	}
}

