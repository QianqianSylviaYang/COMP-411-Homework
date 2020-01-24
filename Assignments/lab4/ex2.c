#include <stdio.h>
#include <string.h>

#define NUM 25
#define LEN 1000

/*int my_compare_strings(char string1[], char string2[]){
	int length1 = strlen(string1)-1;
	int length2 = strlen(string2)-1;
	int lengthC, sameL;
	sameL=0;
	if(length1==length2){
		lengthC = length1;
		sameL=1; //sameL is 1 when heve equal length
	}else if(length1<length2){
		lengthC = length1;
		sameL=2; //sameL is 2 when string1 is shorter
	}else{
		lengthC = length2;
		sameL=3; //sameL is 3 when string2 is shorter
	}
	for(int i=0; i<lengthC; i++){
		if(string1[i]<string2[i]){
			return -1;
		}else if(string1[i]>string2[i]){
			return +1;
		}
	}
	if(sameL==1){
		return 0;
	}else if(sameL==2){
		return -1;
	}else if(sameL==3){
		return 1;
	}
}*/

/*void my_swap_strings(char string1[], char string2[]){
	char temp;
	int length1 = strlen(string1);
	int length2 = strlen(string2);
	int lengthC;
	if(length1<length2){
		lengthC=length2;
	}else if(length1>length2){
		lengthC=length1;
	}else{
		lengthC=length1;
	}
	for(int i=0; i<lengthC; i++){
		temp = string1[i];
		string1[i] = string2[i];
		string2[i] = temp;
	}
	string1[length2]='\0';
	string2[length1]='\0';
}*/

int main(){
	char Strings[NUM][LEN];

	printf("Please enter %d strings, one per line:\n", NUM);

	for(int i=0; i<NUM; i++){
		fgets(Strings[i], LEN, stdin);
	}
	puts("\nHere are the strings in the order you entered:");
	//write a for loop here to print all the strings
	for(int i; i<NUM; i++){
		printf("%s", Strings[i]);
	}
	//Bubble sort
	//write code here to bubble sort the strings in ascending alphabetical order
	for(int i=0; i<NUM-1; i++){
		for(int j=0; j<NUM-i-1; j++){
			int checkO = strncmp(Strings[j], Strings[j+1],LEN);
			if(checkO>0){
				char tempstring[LEN];
				strcpy(tempstring,Strings[j]);
				strcpy(Strings[j], Strings[j+1]);
				strcpy(Strings[j+1], tempstring);
			}
		}
	}
	puts ("\nIn alphabetical order, the strings are:");
	for(int i; i<NUM; i++){
		printf("%s", Strings[i]);
	}
}
