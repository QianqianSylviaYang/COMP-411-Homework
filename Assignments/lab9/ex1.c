#include<stdio.h>

void BinaryPattern(int arr[],int len, int x);

int main(){
	int n;
	scanf("%d",&n);
	int binaryC[n];
	BinaryPattern(binaryC,n,n);
}

void BinaryPattern(int arr[], int len, int x){
	arr[len-x] = 0;
	if(x==1){
		for(int i=0; i<len; i++){
			printf("%d", arr[i]);
		}
		printf("\n");
	}else{
		BinaryPattern(arr,len,x-1);
	}
	arr[len-x] = 1;
	if(x==1){
		for(int i=0; i<len; i++){
			printf("%d", arr[i]);
		}
		printf("\n");
	}else{
		BinaryPattern(arr,len,x-1);
	}
}
