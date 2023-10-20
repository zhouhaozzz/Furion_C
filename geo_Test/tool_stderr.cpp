#include "tool_stderr.h"
//template <typename T>

double tool_stderr(double* arr, int length) {
	double sum=0;
	for (int i = 0; i < length; i++)
	{
		sum = sum + arr[i]* arr[i];
	}
	sum = sqrt(sum / length);
	return sum;
}
