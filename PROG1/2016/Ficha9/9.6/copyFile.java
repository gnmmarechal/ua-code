/*
 * copyFile.java
 * 
 * Copyright 2016 Mário Alexandre Lopes Liberato <gs2012@Qosmio-X70-B-10T>
 * 
 * This program is free software; you cauntitledn redistribute it and/or modify
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
import java.io.*;
import java.util.*;

public class copyFile
{
	static Scanner sca = new Scanner(System.in);
	public static void main (String args[]) throws IOException
	{
		if (args.length == 2)
		{
			String filenameA = args[0];
			String filenameB = args[1];
			File fileA = new File(filenameA);
			File fileB = new File(filenameB);
			
			if(fileExists(fileA))
				writeFile(fileA, fileB);
			else
				{System.out.println("IO Error. Input file doesn't exist, is not a file or is not readable."); return;}
		}
		else
			System.out.println("Error. Invalid arguments provided.");
	}
	
	public static boolean fileExists(File inputFile)
	{
		if (!inputFile.exists() || !inputFile.isFile() || !inputFile.canRead() )
			return false;
		else
			return true;
	}
	public static void writeFile(File A, File B) throws IOException
	{
		if (fileExists(B))
		{
			System.out.printf("Overwrite output file (y/n)?\n>");
			if (!sca.nextLine().equals("y")) return;
			B.delete();
		}
		PrintWriter pwf = new PrintWriter(B);
		Scanner fileRead = new Scanner(A);
			while(fileRead.hasNextLine())
				pwf.println(fileRead.nextLine());
				
			pwf.close();	
				
	}
}

