#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdbool.h>

#define BUFFER_SIZE 1024
#define TOKEN_SIZE 32

typedef struct symbol
{
    char* identifierName;
    char* datatype;
    int offset;
    struct symbol* next;
}symbol;

void insert(symbol** headRef,char* identifier,char* type)
{
    symbol* newnode = (symbol*) malloc(sizeof(symbol));
    static symbol* prevnode;
    newnode->identifierName = (char*) malloc((strlen(identifier)+1)*sizeof(char));
    newnode->datatype = (char*) malloc((strlen(type)+1)*sizeof(char));

    if(*headRef==NULL) 
    {
        newnode->offset=0;
        prevnode = newnode;
    }

    strcpy(newnode->identifierName,identifier);
    strcpy(newnode->datatype,type);

    if(strcmp(newnode->datatype,"int") == 0) 
        (newnode->offset) = (prevnode->offset) + sizeof(int);
    else if(strcmp("float",newnode->datatype) == 0)
        (newnode->offset) = (prevnode->offset) + sizeof(float);
    else if(strcmp("char",newnode->datatype) == 0)
        (newnode->offset) = (prevnode->offset) + sizeof(char);
    else if(strcmp("double",newnode->datatype) == 0)
        (newnode->offset) = (prevnode->offset) + sizeof(double);

    prevnode = newnode;
    newnode->next = (*headRef);
    (*headRef) = newnode;
}

void display(symbol* node)
{
    while(node!=NULL)
    {
        printf("%s %s %d \n",node->identifierName,node->datatype,node->offset);
        node = node->next;
    }
}

bool isIdentifier(const char* token)
{
    if(isalpha(token[0]) || token[0]=='_')
    {
        for(int i=1;token[i]!=(char)NULL;i++)
        {
            if(!isalnum(token[i]))
                return false;
        }
        return true;
    }
    return false;
}

bool isDatatype(const char* token)
{
    static const char *datatype[]={"char","double","float","int"};
    for(size_t i=0;i<(sizeof(datatype)/sizeof(char*));i++)
    {
        if(strcmp(token,datatype[i])==0)
            return true;
    }
    return false;
}

void isDeclaration(char* statement,symbol** head)
{
    char *delimiters = " ,;\t";
    char *token = strtok(statement,delimiters);
    if(!isDatatype(token))
        return;
    char *datatype = token;
    while((token=strtok(NULL,delimiters)))
        if(isIdentifier(token))
            insert(head,token,datatype);    
}

FILE* openFile(int param1,char* param2[])
{
    if(param1<2) 
    {
        fprintf(stderr,"No file found \n");
        exit( EXIT_FAILURE );
    }

    if(param1>2)
    {
        fprintf(stderr,"Cannot read \n");
        exit( EXIT_FAILURE );
    }

    FILE *fp = fopen(param2[1],"r");

    if(fp==NULL)
    {
        fprintf(stderr,"No file found \n");
        exit( EXIT_FAILURE );
    }
    return fp;
}


int main(int argc, char *argv[])
{   
    FILE *fp = openFile(argc,argv);

    char string[BUFFER_SIZE];
    symbol* head = NULL;

    while(fgets(string,sizeof string, fp))
        isDeclaration(string,&head);

    display(head);
    return 0;
}
