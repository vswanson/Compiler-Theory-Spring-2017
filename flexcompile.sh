#! /bin/bash
flex numbers.l
cc lex.yy.c
./a.out < test-data.txt > output.txt
cat output.txt
