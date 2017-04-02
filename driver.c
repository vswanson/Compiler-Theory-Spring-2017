#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <table.h>

#define MAX_LEN 80

void quit()
	{
		printf("Goodbye");
		exit(1);
	}

void lookup(SYMBOL){
	insert(SYMBOL);
	printf("%p\n",(void*)&symbol);
}



int main() {
 char SYMBOL[MAX_LEN];
 scanf("%s", SYMBOL);
 lookup(SYMBOL)
   
}
