#include <stdio.h>

int main()
{
	int A[3][3];
	int B[3][3];
	int C[3][3];

	printf("Please enter 9 values for matrix A:\n");
	scanf("%d%d%d%d%d%d%d%d%d", &A[0][0], &A[0][1], &A[0][2], &A[1][0], 
		&A[1][1], &A[1][2], &A[2][0], &A[2][1], &A[2][2]);
	printf("Please enter 9 values for matrix B:\n");
	scanf("%d%d%d%d%d%d%d%d%d", &B[0][0], &B[0][1], &B[0][2], &B[1][0],
		&B[1][1], &B[1][2], &B[2][0], &B[2][1], &B[2][2]);
	for(int i=0; i<3; i++){
		for(int j=0; j<3; j++){
			C[i][j] = A[i][j] + B[i][j];
		}
	}
	printf("C = B + A =\n");
	for(int i=0; i<3; i++){
		for(int j=0; j<3; j++){
			printf("%10d", C[i][j]);
			if(j==2){
				printf("\n");
			}
		}
	}
}

