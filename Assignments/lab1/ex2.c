/*  Example: C program to find area of a circle */

#include <stdio.h>
#define PI 3.14159

int main()
{
float r, a, tempr, c;

printf("Enter radius (in cm):\n");
scanf("%f", &r);

tempr = r / 2.54;
a = PI * tempr * tempr;
c = 2 * tempr * PI;

  printf("Circle's area is %3.2f (sq in).\n", a);
printf("Its circumference is %3.2f (in).\n", c);
}
