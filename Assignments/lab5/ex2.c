#include <stdio.h>

int A[10][10];
int B[10][10];
int C[10][10];

int main(){
	int M,temp;
	scanf("%d", &M);
	for(int i=0; i<M; i++){
		for(int j=0; j<M; j++){
			scanf("%d",&temp);
			A[i][j]=temp;
		}
	}
	for(int i=0; i<M; i++){
		for(int j=0; j<M; j++){
			scanf("%d", &temp);
			B[i][j]=temp;
		}
	}

	for(int i=0; i<M; i++){
		for(int j=0; j<M; j++){
			temp=0;
			for(int k=0; k<M; k++){
				temp = A[i][k]*B[k][j]+temp;
			}
		C[i][j]=temp;
		}
	}
	for(int i=0; i<M; i++){
		for(int j=0; j<M; j++){
			printf("%6d", C[i][j]);
		}
		printf("\n");
	}
}
