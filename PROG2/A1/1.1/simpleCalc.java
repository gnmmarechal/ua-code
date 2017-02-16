/*
 * simpleCalc.java
 * 
 * Copyright 2017 Mário Alexandre Lopes Liberato <mliberato@ua.pt>
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


public class simpleCalc 
{
	final static String versionString = "v0.0.1";
	
	final static String[] validOperators = {"+", "-", "*", "x", "/"};
	
	final static Scanner sca = new Scanner(System.in);
		
	public static void main (String args[]) 
	{
		System.out.println("GCalc v." + versionString + "\nCopyright 2017, Mário Liberato");
		
		boolean running = true;
		while(running)
		{
			System.out.printf(">>");
			double valA = sca.nextDouble();
			String op = sca.next();
			double valB = sca.nextDouble();
			System.out.println(printResults(valA, valB, op, validOperators));
		}	
	}
	public static String printResults(double A, double B, String OP, String[] OPT)
	{
		String temp = "ERROR ?";
		boolean isValidOP = false;
		
		//Check for OP validity
		for(int i = 0; i < OPT.length; i++)
		{
			if (OPT[i].equals(OP)) isValidOP = true;	
		}
		
		if (isValidOP)
		{
			temp = "> " + A + " " + OP + " " + B + " = " + calcFunc(A, B, OP);
		}
		else
		{
			temp = errorPrint("Invalid Operator '" + OP + "'.");
		}
		
		
		return temp; 
	}
	public static double calcFunc(double A, double B, String OP)
	{
		double temp = 0;
		switch(OP)
		{
			case "+":
				temp = A + B;
				break;
			case "-":
				temp = A - B;
				break;
			case "*":
			case "x":
				temp = A * B;
				break;
			case "/":
				temp = A / B;
				break;
		}
		return temp;
	}
	
	public static String errorPrint(String MSG)
	{
		String temp = "ERROR: " + MSG;
		//System.err.println(temp);
		return temp;
	}
}

