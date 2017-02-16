#!/usr/bin/python

f = open("test.txt", "r")
f2 = open("testOut.txt", "w")

for line in f:
	f2.writeLine(line)


f.close()
f2.close()	
