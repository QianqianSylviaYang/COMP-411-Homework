#include<stdio.h>

int NchooseK(int n, int k);

int main(){
	int n, k, result,i;
	do{
		scanf("%d", &n);
		if(n==0){
			break;
		}
		scanf("%d", &k);
		if(k==0){
			break;
		}
		result = NchooseK(n,k);
		printf("%d\n",result);
	}while(i!=0);
}
int NchooseK(int n, int k){
	int r=0;
	if(k==0){
		r=1;
	}else if(n==k){
		r=1;
	}else{
		r=NchooseK(n-1,k-1)+NchooseK(n-1,k);
	}
	return r;
}
