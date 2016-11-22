/*
 * itssocool.java
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

public class itssocool 
{
	static boolean isValid(int value)
	{
		return (value>0); 
	}
	
	public static void main (String args[]) 
	{
		Scanner sca = new Scanner(System.in);
		String out = "", socool = "P1 é fixe!", sunova = "Input inválido.";
		//Input
		System.out.printf("Insira um número!\n>");
		int timestoprint = sca.nextInt();
		if (isValid(timestoprint))
		{
			out = socool;
		}
		else
		{
			timestoprint = 1;
			out = sunova;
		}
		do
		{
			System.out.println(out);
			timestoprint--;
		} while(timestoprint>0);
	}
}
//El Psy Congroo
