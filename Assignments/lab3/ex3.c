#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 1000

int main()
{
	char text[MAX],reverse[MAX], c1, c2;
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
		if(isspace(reverse[i])||ispunct(reverse[i])){
			continue;
		}else if(isalpha(reverse[i])){
			if(isupper(reverse[i])){
				c1 = tolower(reverse[i]);
			}else{
				c1 = reverse[i];
			}
		}else{
			c1 = reverse[i];
		}
		while(isspace(reverse[j])||ispunct(reverse[j])){
			j--;
		}
		if(isalpha(reverse[j])){
			if(isupper(reverse[j])){
				c2 = tolower(reverse[j]);
			}else{
				c2 = reverse[j];
			}
		}else{
			c2 = reverse[j];
		}
		if(c1!=c2){
			pal=0;
			break;
		}
		j--;
	}
	if(pal==1){
		printf("Found a palindrome!\n");
	}
}
