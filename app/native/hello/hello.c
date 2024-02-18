#include <stdio.h>
#include <string.h>

char *helloWorld(char *name)
{
    static char message[100]; // Assuming the maximum length of the resulting string is 100 characters
    strcpy(message, "hello ");
    strcat(message, name);
    return message;
}