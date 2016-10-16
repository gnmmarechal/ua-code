/*
 * maxminmedn.java
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

public class maxminmedn 
{
	
	public static void main (String args[]) 
	{
		double count = 0, input, oginput, minval = Double.MAX_VALUE, maxval = Double.MIN_VALUE, sum = 0;
		boolean run = true;
		Scanner sca = new Scanner(System.in);
		System.out.println("Introduza números:");
		System.out.printf(">");
		oginput = sca.nextDouble();
		input = oginput;
		if(input<minval)minval=input;
		if(input>maxval)maxval=input;
		sum=input;
		count++;
		do
		{
			System.out.printf(">");
			input = sca.nextDouble();			
			if(oginput!=input)
			{
				//Verificar max/min
				if(input<minval)minval=input;
				if(input>maxval)maxval=input;
				//Somar
				sum+=input;
				count++;
			}
			else
			{
				run = false;
			}	
			 
		} while(run);
		
		//Calcular a média
		double med = sum/count;
		System.out.println("Máximo: " + maxval + "\nMínimo: " + minval + "\nMédia: " + med);
	}
}

