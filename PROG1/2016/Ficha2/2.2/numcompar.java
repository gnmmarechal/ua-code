/*
 * numcompar.java
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

public class numcompar 
{
	
	public static void main (String args[]) 
	{
		double ntp1, ntp2;
		String pass;
		boolean eq;
		System.out.printf("Insira dois valores reais:\nNº1:");
		Scanner sca = new Scanner(System.in);
		ntp1 = sca.nextDouble();
		System.out.print("Nº2:");
		ntp2 = sca.nextDouble();
		
		eq = ntp1 == ntp2;
		if(!eq)
		{
			eq = ntp1 > ntp2;
			if(eq)
			{
				pass = "Nº1 > Nº2!"; 
			}
			else
			{
				pass = "Nº1 < Nº2!";
			}
		}
		else
		{
			pass = "Nº1 = Nº2!";
		}
		System.out.print(pass + "\n");
	}
}

