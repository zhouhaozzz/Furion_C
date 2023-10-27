#include "Furion_fresnel_spectralh.h"
#include <fftw3.h>

using namespace Furion_NS;

Furion_Fresnel_Spectralh::Furion_Fresnel_Spectralh()
{

}

Furion_Fresnel_Spectralh::~Furion_Fresnel_Spectralh()
{

}

void Furion_Fresnel_Spectralh::Furion_fresnel_spectralh(int N, double deltax_Fre, std::complex<double>**  in_Field, double wave_Lambda, double distance)
{
	double* inter_index;
	int** filter_fre;
	double** spatial_Fz;
	create_1d(inter_index, N);
	create_2d(filter_fre, N);
	create_2d(spatial_Fz, N);

	double spatial_Fre = 1e9;
	double spatial_Fre2 = spatial_Fre * spatial_Fre;

	for (int i = 0; i < N; i++) {inter_index[i] = (i - (N - 1) / 2) * deltax_Fre;}

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			if ((spatial_Fre2 - inter_index[j] * inter_index[j] - inter_index[i] * inter_index[i]) > 0.0){filter_fre[i][j] = 1;}
			else{filter_fre[i][j] = 0;}

			spatial_Fz[i][j] = spatial_Fre - 0.5 * filter_fre[i][j] * filter_fre[i][j] * (inter_index[j] * inter_index[j] + inter_index[i] * inter_index[i]) * wave_Lambda;
		}
	}
	destory_1d(inter_index);
	destory_2d(filter_fre, N);

	std::complex<double>** In_Field = new std::complex<double>*[N];
	std::complex<double>** data = new std::complex<double>*[N];
	for (int i = 0; i < N; i++)
	{
		In_Field[i] = new std::complex<double>[N];
		data[i] = new std::complex<double>[N];
	}
	FFTW2(data, in_Field, N);
	FFTshift(In_Field, data, N);

	std::complex<double>** angular_Sp = new std::complex<double>*[N];

	for (int i = 0; i < N; i++)
	{
		angular_Sp[i] = new std::complex<double>[N];
		for (int j = 0; j < N; j++)
		{
			std::complex<double> result(0, 2 * _Pi * spatial_Fz[i][j] * distance);
			angular_Sp[i][j] = In_Field[i][j]*exp(result);
		}
	}
	destory_2d(spatial_Fz, N);
	destory_2d(In_Field, N);


	iFFTshift(data, angular_Sp, N);
	destory_2d(angular_Sp, N);
	iFFTW2(in_Field, data, N);

	destory_2d(data, N);
}

void Furion_Fresnel_Spectralh::FFTW2(std::complex<double>** output, std::complex<double>** field, int N)
{
	fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * N * N);
	for (int i = 0; i < N; i++) 
	{
		for (int j = 0; j < N; j++) 
		{
			data[i * N + j][0] = field[i][j].real();
			data[i * N + j][1] = field[i][j].imag();
		}
	}

	fftw_plan plan = fftw_plan_dft_2d(N, N, data, data, FFTW_FORWARD, FFTW_ESTIMATE);
	fftw_execute(plan);

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[i][j] = std::complex<double>(data[i * N + j][0], data[i * N + j][1]);
		}
	}

	fftw_destroy_plan(plan);
	fftw_free(data);
}

void Furion_Fresnel_Spectralh::iFFTW2(std::complex<double>** output, std::complex<double>** field, int N)
{
	fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * N * N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			data[i * N + j][0] = field[i][j].real();
			data[i * N + j][1] = field[i][j].imag();
		}
	}

	fftw_plan plan = fftw_plan_dft_2d(N, N, data, data, FFTW_BACKWARD, FFTW_ESTIMATE);
	fftw_execute(plan);

	double N2 = N * N;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[i][j] = std::complex<double>(data[i * N + j][0]/N2, data[i * N + j][1]/N2);
		}
	}

	fftw_destroy_plan(plan);
	fftw_free(data);
}

void Furion_Fresnel_Spectralh::FFTshift(std::complex<double>** output, std::complex<double>** field, int N)
{
	int N2 = N / 2;
	
	for (int i = 0; i < N; i++) 
	{
		for (int j = 0; j < N; j++)
		{
			output[(i + N2) % N][(j + N2) % N] = field[i][j];
		}
	}
}

void Furion_Fresnel_Spectralh::iFFTshift(std::complex<double>** output, std::complex<double>** field, int N)
{
	int N2 = N / 2 + 1;

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[(i + N2) % N][(j + N2) % N] = field[i][j];
		}
	}
}

