/*
 * perarea.java
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

//P1 2016 Folha Ex. 1 Ex.1.9
//Objectivo: A partir de 2 valores inseridos, apresentar o perímetro e a área de um rectângulo definido pelos mesmos.


import java.util.*;


public class perarea 
{
	
	public static void main (String args[]) 
	{
		double a,b,area,peri;
		Scanner sca = new Scanner(System.in);
		System.out.print("Insira o comprimento:");
		a = sca.nextDouble();
		System.out.print("Insira a largura:");
		b = sca.nextDouble();
		
		// Calcular c*l e 2(c+l)
		
		area = a*b;
		peri = 2*(a+b);
		
		System.out.printf("Área: %f u.a.\nComprimento: %f u.c.\n", area, peri);
		
		
		
		
	}
}

