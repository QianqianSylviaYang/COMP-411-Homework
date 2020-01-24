#include <stdio.h>
#include <string.h>
#include <ctype.h>
#define MAX_BUF 1024

int main (){
	char buf[MAX_BUF];
	int length;

	do{
		//read a line
		fgets(buf, MAX_BUF, stdin);
		//calculate its length
		length = strlen(buf)-1;
		//modify the line by switching characters
		if(length==0 && buf[length]=='\n'){
			break;
		}
		for(int i=0; i<MAX_BUF; i++){
			if(buf[i]=='E'||buf[i]=='e'){
				buf[i] = '3';
			}else if(buf[i]=='I'||buf[i]=='i'){
				buf[i] = '1';
			}else if(buf[i]=='O'||buf[i]=='o'){
				buf[i] = '0';
			}else if(buf[i]=='S'||buf[i]=='s'){
				buf[i] = '5';
			}
		}
		//print the modified line
		printf("%s", buf);
	}while(length > 1);
}
