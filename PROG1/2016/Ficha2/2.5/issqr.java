/*
 * issqr.java
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

public class issqr 
{
	public static double pdist(double x1,double y1, double x2, double y2)
	{
		return Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
	}
	
	public static void main (String args[]) 
	{
		double[] x = {0,0,0,0}, y = {0,0,0,0};
		String sim = "É ", nao = "Não é ", choi;
		Scanner sca = new Scanner(System.in);
		System.out.print("Insira as coordenadas de quatro pontos (x, y):\nP1:");
		x[0] = sca.nextDouble();
		y[0] = sca.nextDouble();
		System.out.print("P2:");
		x[1] = sca.nextDouble();
		y[1] = sca.nextDouble();
		System.out.print("P3:");
		x[2] = sca.nextDouble();
		y[2] = sca.nextDouble();
		System.out.print("P4:");
		x[3] = sca.nextDouble();
		y[3] = sca.nextDouble();
		double theta;
		//D(P1,P2) = D(P2,P3) = D(P3,P4) = D(P4,P1) --> Quadrado
		if (pdist(x[0],y[0],x[1],y[1]) == pdist(x[1],y[1],x[2],y[2]) && pdist(x[1],y[1],x[2],y[2]) == pdist(x[2],y[2],x[3],y[3]) && pdist(x[2],y[2],x[3],y[3]) == pdist(x[3],y[3],x[0],y[0]))
		{
			//Confirmar a existência de um ângulo recto (se sim, será um quadrado)
			
			//Vector AB = B - A
			//Através do produto escalar, verificar a amplitude do ângulo
			double[] AB = {x[1] - x[0], y[1] - y[0]}, BC = {x[2] - x[1], y[2] - y[1]}; //Vectores
			double dAB = pdist(x[0],y[0],x[1],y[1]); //Comprimento de AB (e BC)
			double pABBC = AB[0]*BC[0] + AB[1]*BC[1]; //Produto escalar AB * BC
			//Ângulo
			double thetarad = Math.acos(pABBC/(dAB*dAB)); // Ângulo em radianos
			theta = (thetarad * 180) / Math.PI; //Graus
			if (theta == 90.0)
			{
				choi = sim;
			}
			else
			{
				choi = nao;
			}
		}
		else
		{
			choi = nao;
		}
		System.out.print(choi + "quadrado");
	}
}

