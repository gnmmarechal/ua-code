/*
 * usdtoeur.java
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

//P1 2016 Folha Ex. 1 Ex.1.11
//Objectivo: A partir de 2 valores inseridos (valor em dólares e taxa de conversão), calcular o valor em euros e apresentar


import java.util.*;


public class usdtoeur
{
	
	public static void main (String args[]) 
	{
		double USD, fac, EUR;
		Scanner sca = new Scanner(System.in);
		System.out.print("Insira a quantia (USD):");
		USD = sca.nextDouble();
		System.out.print("Insira a taxa de conversão:");
		fac = sca.nextDouble();
		// Calcular 
		EUR = USD*fac;
		
		System.out.printf("%.2f dólares equivalem a %.2f euros\n", USD, EUR);
		
		
		
		
	}
}

