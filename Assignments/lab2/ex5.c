#include <stdio.h>
int main(){
	int w,h,k;
	k = 1;
	while(k==1){
		printf("Please enter width and height:\n");
		scanf("%d", &w);
		if(w!=0){
			scanf("%d", &h);
			for(int i=0; i<h; i++){
				if(i==0||i==h-1){
					for(int j=0; j<w; j++){
						if(j==0||j==w-1){
							printf("+");
						}
						else{
							printf("-");
						}
					}
				}
				else{
					for(int j=0; j<w; j++){
						if(j==0||j==w-1){
							printf("|");
						}
						else{
							printf("~");
						}
					}
				}
				printf("\n");
			}
		}
		else{
			k=k-1;
		}
	}
	printf("End\n");
}
