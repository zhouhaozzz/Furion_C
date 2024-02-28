#include "Furion_angular_spectrum.h"
#include <fftw3.h>

using namespace Furion_NS;

Furion_Angular_Spectralh::Furion_Angular_Spectralh()
{

}

Furion_Angular_Spectralh::~Furion_Angular_Spectralh()
{

}

void Furion_Angular_Spectralh::Furion_angular_spectralh(int N, double deltax_Fre, std::vector<std::vector<std::complex<double>> >& in_Field, double wave_Lambda, double distance)
{
	//double* inter_index;
	//int** filter_fre;
	//double** spatial_Fz;
	//create_1d(inter_index, N);
	//create_2d(filter_fre, N);
	//create_2d(spatial_Fz, N);
	std::vector<double> inter_index(N);
	//std::vector<std::vector<double> > filter_fre(N, std::vector<double>(N));
	std::vector<std::vector<double> > spatial_Fz(N, std::vector<double>(N));

	double spatial_Fre = 1e9;
	double spatial_Fre2 = spatial_Fre * spatial_Fre;
	double cache1;

	for (int i = 0; i < N; i++) {inter_index[i] = (i - (N - 1) / 2) * deltax_Fre;}

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{

			cache1 = spatial_Fre2 - inter_index[j] * inter_index[j] - inter_index[i] * inter_index[i];
			spatial_Fz[i][j] = std::sqrt(cache1);
			if ((cache1) <= 0.0)
			{
				spatial_Fz[i][j] = 0;
			}

		}
	}
	//destory_1d(inter_index);
	//destory_2d(filter_fre, N);
	inter_index.clear();
	//filter_fre.clear();

	//std::complex<double>** In_Field = new std::complex<double>*[N];
	//std::complex<double>** data = new std::complex<double>*[N];
	//for (int i = 0; i < N; i++)
	//{
	//	In_Field[i] = new std::complex<double>[N];
	//	data[i] = new std::complex<double>[N];
	//}
	//std::vector<std::vector<std::complex<double>> > In_Field(N, std::vector<std::complex<double>>(N));
	std::vector<std::vector<std::complex<double>> > data(N, std::vector<std::complex<double>>(N));
	Furion_NS::FFTW2(data, in_Field, N);
	Furion_NS::FFTshift(in_Field, data, N);

	//std::complex<double>** angular_Sp = new std::complex<double>*[N];
	std::vector<std::vector<std::complex<double>> > angular_Sp(N, std::vector<std::complex<double>>(N));

	cache1 = 2 * _Pi * distance;
	for (int i = 0; i < N; i++)
	{
		//angular_Sp[i] = new std::complex<double>[N];
		for (int j = 0; j < N; j++)
		{
			std::complex<double> result(0,  cache1 * spatial_Fz[i][j]);
			angular_Sp[i][j] = in_Field[i][j] * std::exp(result);
		}
	}
	//destory_2d(spatial_Fz, N);
	//destory_2d(In_Field, N);
	spatial_Fz.clear();
	//In_Field.clear();


	Furion_NS::iFFTshift(data, angular_Sp, N);
	//destory_2d(angular_Sp, N);
	angular_Sp.clear();
	Furion_NS::iFFTW2(in_Field, data, N);

	//destory_2d(data, N);
	data.clear();
}


