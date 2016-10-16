/*
 * highlow.java
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

public class highlow 
{
	
	public static void main (String args[]) 
	{
		int inp, tent = 0;
		String msg = "Default", msga = "O número é muito grande!", msgb = "O número é muito pequeno!", msgc = "O número é igual!";
		Scanner sca = new Scanner(System.in);
		int ran = (int) (100*Math.random()) + 1;
		System.out.println(ran);
		System.out.println("Insira números:");
		do
		{
			tent++;
			System.out.printf(">");
			inp = sca.nextInt();
			if(inp>ran) msg = msga;
			if(inp<ran) msg = msgb;
			if(inp==ran) msg = msgc;
			System.out.println(msg);
		} while(inp!=ran);
		System.out.println("Foram feitas " + tent + " tentativas.");
	}
}

