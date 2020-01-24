#include <stdio.h>
int main(){
	int arr[6];
	int a;
	printf("Enter six integers:\n");
	for(int i=0; i<6; i++){
		scanf("%d", &a);
		arr[i] = a;
	}
	printf("1234567890bb1234567890\n");
	for(int i=0; i<6; i++){
		if(i%2==0){
			printf("%10d", arr[i]);
		}
		else{
			printf("  %10d\n", arr[i]);
		}
	}
}
