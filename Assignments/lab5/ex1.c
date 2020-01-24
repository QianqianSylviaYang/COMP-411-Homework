#include<stdio.h>
#include<stdlib.h>

#define true 1
#define false 0

#define MAX 100

int maze[100][100];  //100x100 is the maximum size needed
int wasHere[100][100];
int correctPath[100][100];
int width, height;
int startX, startY, endX, endY;

int recursiveSolve(int x, int y);

int main(){
	int x, y;
	scanf("%d%d", &width, &height);
	scanf("\n"); // This is needed to "eat" the newline after height,
		//before the actual maze entries begin on the next line


	/* NOTE: maze[y][x] will refer to the (x,y)element of the maze,
		i.e., y-th row and x-th column in the maze.
		The row is typically the first index in  2D array because
		reading and writing is done row-wise. This is called 
		"row-major" oreder.

		Also note that although we have declared the maze to be 100x100,
		that is the maximum size we need. The actual entries in the 
		maze will be height * width
	*/

	char tempchar;

	for(y=0; y<height; y++){
		for(x=0; x<width; x++){
			scanf("%c", &tempchar);
			maze[y][x]=tempchar;
			//Check for 'S' and 'F' here and use that to set
			//values of startX, startY, endX and endY
			if(tempchar=='S'){
				startX=x;
				startY=y;
			}
			if(tempchar=='F'){
				endX=x;
				endY=y;
			}

			wasHere[y][x] = false;
			correctPath[y][x]= false;
		}
		scanf("%c", &tempchar); //This is used to "eat"the newline
	}

	recursiveSolve(startX, startY);
	for(int i=0; i<height; i++){
		for(int j=0; j<width; j++){
			if(correctPath[i][j]==1){
				if(maze[i][j]!='S'){
					printf(".");
				}else{
					printf("%c",maze[i][j]);
				}
			}
			else{
				printf("%c",maze[i][j]);
			}
		}printf("\n");
	}

}

int recursiveSolve(int i, int j){
	if(i==endX&&j==endY)return true;//If you reached the end
	if(maze[j][i]=='*'||wasHere[j][i]==true)return false;//If you are on a wall or already were here
	wasHere[j][i]=true;
	if(i!=0){//Check if not on left edge
		if(recursiveSolve(i-1, j)){//Calls method one to the left
			correctPath[j][i]=true;//Set that path value to true;
			return true;
		}
	}
	if(i!=width-1){//Check if not on the right edge
		if(recursiveSolve(i+1,j)){//Calls methos on to the right
			correctPath[j][i]=true;
			return true;
		}
	}
	if(j!=0){//Checks if not on the top edge
		if(recursiveSolve(i,j-1)){//Calls method one up
			correctPath[j][i] = true;
			return true;
		}
	}
	if(j!=height-1){//Checks if not on bottom edge
		if(recursiveSolve(i, j+1)){//Calls method one down
			correctPath[j][i] = true;
			return true;
		}
	}
	return false;
}
