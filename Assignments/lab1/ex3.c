/*  Example: C program to find area of a circle */

#include <stdio.h>
#define PI 3.14159

int main()
{
float r, a, tempr, c, n;
n = 1;

while(n!=0){

	printf("Enter radius (in cm):\n");
	scanf("%f", &r);

	if(r==0){
		n = n-1;
	}

	tempr = r / 2.54;
	a = PI * tempr * tempr;
	c = 2 * tempr * PI;

  	printf("Circle's area is %3.2f (sq in).\n", a);
	printf("Its circumference is %3.2f (in).\n", c);
}
}
