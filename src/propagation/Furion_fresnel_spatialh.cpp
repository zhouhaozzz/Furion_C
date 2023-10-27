#include "Furion_fresnel_spatialh.h"
#include <complex>

using namespace Furion_NS;

Furion_Fresnel_Spatialh::Furion_Fresnel_Spatialh()
{

}

Furion_Fresnel_Spatialh::~Furion_Fresnel_Spatialh()
{
    
}

void Furion_Fresnel_Spatialh::Furion_fresnel_spatialh(double** X, double** Y, std::complex<double>** field, double wavelength, int n)
{
    //int n = Furion::n;
	std::complex<double>** phase_field = new std::complex<double>* [n];

	for (int i = 0; i < n; i++)
	{
		//phase_field[i] = new double[n];
		//for (int j = 0; j < n; j++)
		//{
		//	std::complex<double> z(3.0, 4.0);
		//	phase_field[i][j] = 
		//}
	}

}




