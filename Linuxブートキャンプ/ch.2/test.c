#include <stdio.h>

int main(int argc, char *argv[]){
	FILE *f;
	f = fopen(argv[1], "w");
	fclose(f);
	return(0);
}
