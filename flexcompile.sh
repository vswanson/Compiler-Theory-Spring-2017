#! /bin/bash
flex project1.l
cc lex.yy.c
./a.out < test-data.txt > output.txt
cat output.txt
