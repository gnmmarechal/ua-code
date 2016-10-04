/*
 * diasmes.java
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

public class diasmes 
{
	
	public static void main (String args[]) 
	{
		boolean isBis = false;
		int mes, ano, nodias;
		int[] dias = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
		Scanner sca = new Scanner(System.in);
		System.out.print("Insira o mês:");
		mes = sca.nextInt();
		System.out.print("Insira o ano:");
		ano = sca.nextInt();
		
		//Verifica o mês
		nodias = 0; //Inicializar para não dar erro de compilação (devido a esta variável só ser usada num dos ramos do if)
		if (mes == 2)
		{
			//Verificar se o ano é bissexto (Divisível por 4 e não por cem OU divisível por 4 e 400)
			if ((ano%4 == 0 && ano%100 != 0) || (ano%4 == 0 && ano%400 == 0))
			{
				isBis = true;
			}
			else
			{
				isBis = false;
			}
			
			//Definir nodias
			if(isBis)
			{
				nodias = dias[mes-1] + 1;
			}
			else
			{
				nodias = dias[mes-1];
			}
		}
		else
		{
			nodias = dias[mes-1];
		}
		System.out.print("O mês " + mes + " do ano " + ano + " tem " + nodias + " dias.\n");
	}
}

