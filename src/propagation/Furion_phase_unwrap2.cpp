#include "Furion_phase_unwrap2.h"

using namespace Furion_NS;

Furion_Phase_Unwrap2::Furion_Phase_Unwrap2()
{

}

Furion_Phase_Unwrap2::~Furion_Phase_Unwrap2()
{
    
}

void Furion_Phase_Unwrap2::Furion_phase_unwrap2(double** phase_field, std::complex<double>** in_Field, int N)
{
	double** Phase_field;
	create_2d(Phase_field, N);
	angle(Phase_field, in_Field, N);

	int mid = std::round(N/2);

	double** unwrapmid = new double* [1]; unwrapmid[0] = new double[N];
	unwrap(unwrapmid, Phase_field, N, mid);

	double** unwrapP;
	create_2d(unwrapP, N);
	unwrap(unwrapP, Phase_field, N, 0);

	destory_2d(Phase_field, N);
	
	double* miderr;
	create_1d(miderr, N);
	for (int i = 0; i < N; i++)
	{
		miderr[i] = unwrapP[mid][i] - unwrapmid[0][i];
	}
	destory_2d(unwrapmid, 1);

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			phase_field[i][j] = unwrapP[i][j] - miderr[j];
		}
	}

	destory_2d(unwrapP, N);
	destory_1d(miderr);
}

void Furion_Phase_Unwrap2::angle(double** angle, std::complex<double>** field, int N)
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			angle[i][j] = atan2( field[i][j].imag(), field[i][j].real());
		}
	}
}

void Furion_Phase_Unwrap2::unwrap(double** phase_new, double** phase, int N, int n)
{
	if (n == 0) //for matrix
	{
		double Pi2 = 2 * _Pi;

		double** phase1;
		create_2d(phase1, N);
		for (int i = 0; i < N; i++)  //矩阵转置，提高缓存命中率
		{
			for (int j = 0; j < N; j++) {
				phase1[i][j] = phase[j][i];
			}
		}

		for (int i = 0; i < N; i++)
		{
			phase1[i][0] = phase[i][0];

			for (int j = 1; j < N; ++j) {
				double delta = phase[i][j] - phase[i][j - 1];
				if (delta > _Pi) {
					phase1[i][j] = phase1[i][j - 1] + delta - Pi2;
				}
				else if (delta < -_Pi) {
					phase1[i][j] = phase1[i][j - 1] + delta + Pi2;
				}
				else {
					phase1[i][j] = phase1[i][j - 1] + delta;
				}
			}
		}

		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < N; j++) {
				phase_new[i][j] = phase1[j][i];
			}
		}

		destory_2d(phase1, N);
	}
	else //for row
	{
		int i = n;
		double Pi2 = 2 * _Pi;

		phase_new[0][0] = phase[i][0];

		for (int j = 1; j < N; ++j) {
			double delta = phase[i][j] - phase[i][j - 1];
			if (delta > _Pi) {
				phase_new[0][j] = phase_new[0][j - 1] + delta - Pi2;
			}
			else if (delta < -_Pi) {
				phase_new[0][j] = phase_new[0][j - 1] + delta + Pi2;
			}
			else {
				phase_new[0][j] = phase_new[0][j - 1] + delta;
			}
		}
	}
}
