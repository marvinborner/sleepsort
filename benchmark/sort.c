#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int array[];
extern int size;

int compare(const void *a, const void *b)
{
	return *(int *)a - *(int *)b;
}

int main(int argc, char *argv[])
{
	int len = (int)&size; // ??
	qsort(array, len, sizeof(int), compare);
	for (int i = 0; i < len; i++)
		printf("%d\n", array[i]);
	return 0;
}
