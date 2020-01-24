#include <stdio.h>
int AA[100];	//linearized version of A[10][10]
int BB[100];	//linearized version of B[10][10]
int CC[100];	//linearized version of C[10][10]
int m;		//actuall size of the above matrices is mxm,where m is at most 10

int main(){
	int temp,tempL;
	scanf("%d", &m);
	for(int i=0; i<m; i++){
		for(int j=0; j<m; j++){
			scanf("%d",&temp);
			tempL = i*m+j;
			AA[tempL]=temp;
		}
	}

	for(int i=0; i<m; i++){
		for(int j=0; j<m; j++){
			scanf("%d",&temp);
			tempL = i*m+j;
			BB[tempL]=temp;
		}
	}

	for(int i=0; i<m; i++){
		for(int j=0; j<m; j++){
			temp=0;
			for(int k=0; k<m; k++){
				int tempA, tempB;
				tempA = i*m+k;
				tempB = k*m+j;
				temp = AA[tempA]*BB[tempB]+temp;
			}
		int tempC;
		tempC=i*m+j;
		CC[tempC]=temp;
		}
	}

	for(int i=0; i<m; i++){
		for(int j=0; j<m; j++){
			tempL = i*m+j;
			printf("%d ",CC[tempL]);
		}
		printf("\n");
	}
}
