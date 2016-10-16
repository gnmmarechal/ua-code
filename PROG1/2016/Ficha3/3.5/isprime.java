/*
 * isprime.java
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

public class isprime 
{
	public static boolean primecheck (int arg)
	{
		//Verificação de primo
		if(arg==1) return false; //1 não é considerado primo
		for (int i = 2;2*i<arg;i++)
		{
			if(arg%i==0) return false;
		}
		return true;
	}
	public static void main (String args[]) 
	{
		Scanner sca = new Scanner(System.in);
		int inp;
		String msg="", tmsg = "O número é primo.", fmsg = "O número não é primo.";
		inp = sca.nextInt();
		if(primecheck(inp))
		{
			msg = tmsg;
		}
		else
		{
			msg = fmsg;
		}
		System.out.println(msg);
	}
}

