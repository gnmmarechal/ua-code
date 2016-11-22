/*
 * leibnitz.java
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

public class leibnitz 
{
	static double seriesCalcSum(int n)
	{
		double total = 0, sign = 1.0 ;
		for(int i =1;i<=n;i+=2)
			{
				total += sign/i;
				sign *= -1;
			}		
		
		
		return total;
	}
	static String compNum(double a, double b)
	{
		String ma = "maior que", eq = "igual a", men = "menor que";
		if(a>b)
		{
			return ma;
		}
		else if(b<a)
		{
			return men;
		}	
		else return eq;
	}
	
	public static void main (String args[]) 
	{
		double piforth = Math.PI/4;
		Scanner sca = new Scanner(System.in);
		System.out.printf("Insira um valor N:\n>");
		int input = sca.nextInt();
		double calcn = seriesCalcSum(input);
		System.out.printf("Valor obtido : %.015f\nValor de PI/4 : %.015f\nO valor calculado é " + compNum(calcn, piforth) + " PI/4\n", calcn, piforth); //O símbolo π (e símbolos como é ou è) parece não ser mostrado quando o programa é executado. Este comportamento foi verificado em Windows, e com ambos o símbolo e a representação \u03C0. 
		//Para determinados valores, apesar de calcn != piforth, o programa considera-os iguais?
	}
}

