#include <stdio.h>
#include <string.h>

#define MAX 1000

int main()
{
	char text[MAX],reverse[MAX], c;
	int length,pal, j;
	pal=1;
	j=0;

	puts("Type some text (then ENTER):");

	/* Save typed characters in text[]: */

	fgets(text, MAX, stdin);
	length = strlen(text)-1;

	/* Analyse contents of text[]: */

	for(int i=length-1; i>=0; i--){
		reverse[j]=text[i];
		j++;
	}
	reverse[length]='\0';
	printf("Your input in reverse is:\n");
	printf("%s\n", reverse);
	j=length-1;
	for(int i=0; i<=length/2+1; i++){
		if(reverse[i]!=reverse[j]){
			pal=0;
			break;
		}
		j--;
	}
	if(pal==1){
		printf("Found a palindrome!\n");
	}
}
