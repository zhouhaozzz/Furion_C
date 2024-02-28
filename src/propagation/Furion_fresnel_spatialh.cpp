#include "Furion_fresnel_spatialh.h"
#include <complex>
#include <fftw3.h>

using namespace Furion_NS;

Furion_Fresnel_Spatialh::Furion_Fresnel_Spatialh()
{

}

Furion_Fresnel_Spatialh::~Furion_Fresnel_Spatialh()
{
    
}

void Furion_Fresnel_Spatialh::Furion_fresnel_spatialh(std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& in_Field, double wave_Lambda, double distance, int n)
{
	int Nx = in_Field[0].size();
	int max_val = *std::max_element(X[0].begin(), X[0].end());
	int min_val = *std::min_element(X[0].begin(), X[0].end());
	int L_size = max_val - min_val;
	double spatial_Fre = 1 / wave_Lambda;

	std::vector<std::vector<std::complex<double>> > h_response(n, std::vector<std::complex<double>>(n));
	std::complex<double> cache1 = std::exp(std::complex<double>(0, 2 * std::_Pi * spatial_Fre * distance));
	double cache2 = std::_Pi * spatial_Fre / distance;
	std::complex<double> cache3 = std::complex<double>(0, 1 / wave_Lambda / distance);

	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			h_response[i][j] = cache1 * std::exp(std::complex<double>(0, cache2 * (X[i][j] * X[i][j] + Y[i][j] * Y[i][j]))) * cache3;
		}
	}

	std::vector<std::vector<std::complex<double>> > H_response(n, std::vector<std::complex<double>>(n));
	std::vector<std::vector<std::complex<double>> > In_Field(n, std::vector<std::complex<double>>(n));
	Furion_NS::FFTW2(H_response, h_response, n);
	
	Furion_NS::FFTW2(In_Field, in_Field, n);	//In_Field == out_Field

	Furion_Fresnel_Spatialh::iFFTW2(h_response, H_response, In_Field, n);	//Reuse of variables to save memory space
	double data = (double(L_size) / Nx) * (double(L_size) / Nx);
	Furion_Fresnel_Spatialh::iFFTshift(in_Field, h_response, data, n);
}

void Furion_Fresnel_Spatialh::iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field1, std::vector<std::vector<std::complex<double>> >& field2, int N)
{
	fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * N * N);
	std::complex<double> cache;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			cache = field1[i][j] * field2[i][j];
			data[i * N + j][0] = cache.real();
			data[i * N + j][1] = cache.imag();
		}
	}

	fftw_plan plan = fftw_plan_dft_2d(N, N, data, data, FFTW_BACKWARD, FFTW_ESTIMATE);
	fftw_execute(plan);

	double N2 = N * N;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[i][j] = std::complex<double>(data[i * N + j][0] / N2, data[i * N + j][1] / N2);
		}
	}

	fftw_destroy_plan(plan);
	fftw_free(data);
}

void Furion_Fresnel_Spatialh::iFFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, double data, int N)
{
	int N2 = N / 2 + 1;

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[(i + N2) % N][(j + N2) % N] = field[i][j] * data;
		}
	}
}




