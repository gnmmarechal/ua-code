/*
 * TP84917.java
 * 
 * Copyright 2016 gnmso <gnmso@DESKTOP-50P6M9O>
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

public class TP84917 
{
	static Scanner sca = new Scanner(System.in);
	static int num_vals = 10;
	static int possible_vals = 12; //Valores possíveis (0-11)
	
	public static void main (String[] args) 
	{
		System.out.printf("Insira 10 notas:");
		
		//Declarar os arrays que armazenarão as notas e histograma (tamanho num_vals/possible_vals)
		double notas[] = new double[num_vals];
		int histoData[] = new int[possible_vals];
		
		
		//Ler as notas/ calcular histograma
		notas = readGrades(num_vals);
		histoData = histoGen(notas);
		
		//Listar as notas
		System.out.println("Notas dos alunos:\n" + gerchar(17, "="));
		
		for(int z = 0; z < notas.length; z++)
		{
			String valtoprint = "";
			if (notas[z] == 11) valtoprint = "F"; //Falta
			else if (notas[z] < 0 || notas[z] > 11) valtoprint = "E"; //Erro
			else valtoprint = String.valueOf(notas[z]); //Nota
			System.out.println("Aluno " + String.format("%02d", z + 1) + ": " + valtoprint);
		}
		
		System.out.println(gerchar(17, "="));
		
		//Imprimir o histograma
		
		printHisto(histoData);
		
		System.out.println(gerchar(17, "="));
		//Imprimir a média
		System.out.println("\nMédia Geral: " + calcAvg(notas, true) + "\nMédia (Sem faltas): " + calcAvg(notas, false));
		
		
		
		
	}
	
	public static double[] readGrades(int size) //Lê as notas
	{
		double armnotas[] = new double[size];
		for(int z = 0; z < size; z++)
		{
			System.out.printf("\n>");
			armnotas[z] = sca.nextDouble();
		}
		return armnotas;
	}
	
	public static int[] histoGen(double lista[]) //Gera dados para o histograma
	{
		int histoToRet[] = new int[possible_vals];
		//A lista é convertida em inteiros (ex. 13.5 -> 13)
		
		for(int z = 1; z <= lista.length; z++)
		{
			if (lista[z-1] < 12 && lista[z-1] >= 0) histoToRet[(int) lista[z-1]]++;
		}
		return histoToRet;
	}
	
	public static void printHisto(int histoData[]) //Imprime o histograma
	{
		for(int z = 0; z < histoData.length; z++)
		{
			String valtoprint = "";
			if(z == 11) valtoprint = " F";
			else valtoprint = String.format("%02d", z);
			System.out.println(valtoprint + " | " + gerchar(histoData[z], "*"));
		}
		return;
	}
	
	public static double calcAvg( double lista[], boolean includeFaltas)
	{
		double avg = 0, sum = 0, setNo = 0;
		for(int z = 0; z < lista.length; z++)
		{
			if(lista[z] <= 11 && lista[z] >= 0)
			{
				if (lista[z] < 11 ) sum += lista[z];
				if (lista[z] < 11 || includeFaltas) setNo++;
			}
		}
		return sum/setNo;
	}
	public static String gerchar(long n, String ch) //Gera caracteres
	{
		String ret = "";
		for (long z = 0; z < n; z++) ret += ch;
		return ret;
	}	
	
}

