/*
 * tikdec.java
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

public class tikdec 
{
	
	public static void main (String args[]) 
	{
		double ntp1;
		String pass;
		System.out.printf("Insira a sua idade:");
		Scanner sca = new Scanner(System.in);
		ntp1 = sca.nextDouble();
		
		//Verificar bilhete
		if(ntp1<0)
		{
			pass = "Erro";
		}
		else if(ntp1<6)
		{
			pass = "Isento de pagamento";
		}
		else if(ntp1<13)
		{
			pass = "Bilhete de criança";
		}
		else if(ntp1<65)
		{
			pass = "Bilhete normal";
		}
		else
		{
			pass = "Bilhete de 3ª Idade";
		}
		System.out.print(pass + "\n");
	}
}

