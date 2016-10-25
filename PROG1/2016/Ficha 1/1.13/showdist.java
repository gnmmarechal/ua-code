/*
 * showdist.java
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
import java.lang.*;

public class showdist 
{
	public static double distcalc(double x1p, double y1p, double x2p, double y2p, double sc)
	{
		double x1 = x1p*sc, x2 = x2p*sc, y1 = y1p*sc, y2 = y2p*sc;
		return Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
	}
	public static void main (String args[]) 
	{
		Scanner sca = new Scanner(System.in);
		double[] input = {0,0,0,0}; //Coordenadas
		double scalefactor = 100000; //O factor de escala é inserido em cm:cm.
		double scalefactorshrt = scalefactor/1000; //Converte o factor para cm:Km.
		System.out.printf("Escala: 1/%f (cm:Km)\nInsira as coordenadas (x1, y1):\n>", scalefactorshrt);
		input[0] = sca.nextDouble();
		input[1] = sca.nextDouble();
		System.out.printf("Insira as coordenadas (x2, y2):\n>");
		input[2] = sca.nextDouble();
		input[3] = sca.nextDouble();
		System.out.printf("A distância entre os pontos é %fKm.", distcalc(input[0], input[1], input[2], input[3],scalefactorshrt));
	}
}

