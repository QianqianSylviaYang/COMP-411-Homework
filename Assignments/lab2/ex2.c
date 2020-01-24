#include<stdio.h>
int main(){
	double max, min, sum, pro, a;
	printf("Enter 10 floating-point numbers:\n");
	for (int i=0; i<10; i++){
		scanf("%lf", &a);
		if(i==0){
			max = a;
			min = a;
			sum = a;
			pro = a;
		}
		else{
			if(a>max){
				max = a;
			}
			if(a<min){
				min = a;
			}
			sum = sum + a;
			pro = pro * a;
		}
	}
	printf("Sum is %.5lf\n", sum);
	printf("Min is %.5lf\n", min);
	printf("Max is %.5lf\n", max);
	printf("Product is %.5lf\n", pro);
}
