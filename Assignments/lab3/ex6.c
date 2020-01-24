#include <stdio.h>
int NchooseK(int a, int b);
int main (){
	int n, k, result, i;
	i=1;
	do{
		printf("Enter two integers (for n and k) separated by space:\n");
		scanf("%d%d", &n, &k);
		if(n==0&&k==0){
			i=0;
		}
		result = NchooseK(n,k);
		printf("%d\n", result);
	}while(i!=0);
}
int NchooseK(int a, int b){
	int r=0;
	if(b==0){
		r=1;
	}else if(a==b){
		r=1;
	}else{
		r = NchooseK(a-1,b-1)+NchooseK(a-1,b);
	}
	return r;
}
