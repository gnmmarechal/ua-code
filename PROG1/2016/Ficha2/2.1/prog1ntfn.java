/*
 * prog1ntfn.java
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

public class prog1ntfn 
{
	
	public static void main (String args[]) 
	{
		double ntp1, ntp2, napi, nep;
		boolean pass;
		String pstr;
		System.out.printf("Insira os valores pedidos (0/20):\nTP1:");
		Scanner sca = new Scanner(System.in);
		ntp1 = sca.nextDouble();
		System.out.print("TP2:");
		ntp2 = sca.nextDouble();
		System.out.print("API:");
		napi = sca.nextDouble();
		System.out.print("EP:");
		nep = sca.nextDouble();
		
		if(ntp1 > 20 | ntp2 > 20 | napi > 20 | nep > 20) return;
		//Verificar se a média ponderada >= 9,5
		
		pass = 0.1*ntp1 + 0.1*ntp2 + 0.3*napi + 0.5*nep >= 9.5;
		if(pass)
		{
			pstr = "Aprovado";
		}
		else
		{
			pstr = "Reprovado";
		}	
		System.out.print(pstr + "\n");
		return;
	}
}

