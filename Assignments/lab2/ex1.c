#include <stdio.h>
int main() {
	int a;

	printf("Enter a number from 1 to 20:\n");
	scanf("%d",&a);
	if(a < 1 || a > 20){
		printf("Number is not in the range from 1 to 20\n");
	}
	else{
		printf("Here are the first %d ordinal numbers:\n", a);
		for(int i=1; i<=a; i++){
			if(i<=3){
				if(i==1){
					printf("1st\n");
				}
				if(i==2){
					printf("2nd\n");
				}
				if(i==3){
					printf("3rd\n");
				}
			}
			else{
				printf("%dth\n", i);
			}
		}
	}
}
