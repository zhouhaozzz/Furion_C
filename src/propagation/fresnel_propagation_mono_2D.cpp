#include "fresnel_propagation_mono_2D.h"
#include <fftw3.h>

using namespace Furion_NS;

Fresnel_Propagation_Mono_2D::Fresnel_Propagation_Mono_2D()
{

}

Fresnel_Propagation_Mono_2D::~Fresnel_Propagation_Mono_2D()
{

}

void Fresnel_Propagation_Mono_2D::fresnel_propagation_mono_2D(std::vector<std::vector<std::complex<double>> >& Di, double L1, double L2, double lambda, double z)
{
	double dXY1 = L1 / Di.size();
	double dXY2 = L2 / Di[0].size();

	std::vector<double> fx;
	std::vector<double> fy;
	double start_fx, end_fx, step_fx;
	start_fx = -1.0 / (2 * dXY1);
	end_fx = 1.0 / (2 * dXY1) - 1.0 / L1;
	step_fx = 1.0 / L1;
	for (double freq = start_fx; freq <= end_fx; freq += step_fx) 
	{
		fx.push_back(freq);
	}

	start_fx = -1.0 / (2 * dXY2);
	end_fx = 1.0 / (2 * dXY2) - 1.0 / L1;
	step_fx = 1.0 / L1;
	for (double freq = start_fx; freq <= end_fx; freq += step_fx) 
	{
		fy.push_back(freq);
	}

	std::vector<std::vector<std::complex<double>>> H(fx.size(), std::vector<std::complex<double>>(fy.size()));
	std::vector<std::vector<std::complex<double>>> data(fx.size(), std::vector<std::complex<double>>(fy.size()));
	for (size_t i = 0; i < fx.size(); ++i) {
		for (size_t j = 0; j < fy.size(); ++j) {
			H[i][j] = std::exp(-1i * M_PI * lambda * z * (fx[i] * fx[i] + fy[j] * fy[j]));
		}
	}

	int N = fx.size();
	fx.clear();
	fy.clear();

	Furion_NS::iFFTshift(data, H, N);		//data == H

	Furion_NS::iFFTshift(H, Di, N);			//H == di
	Furion_NS::FFTW2(Di, H, N);				//Di == di

	Fresnel_Propagation_Mono_2D::iFFTW2(H, data, Di, N);
	data.clear();
	Furion_NS::iFFTshift(Di, H, N);
	
	H.clear();
}

void Fresnel_Propagation_Mono_2D::iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field1, std::vector<std::vector<std::complex<double>> >& field2, int N)
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

