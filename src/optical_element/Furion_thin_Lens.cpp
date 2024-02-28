#include "Furion_thin_Lens.h"

using namespace Furion_NS;

Furion_Thin_Lens::Furion_Thin_Lens()
{

}

Furion_Thin_Lens::~Furion_Thin_Lens()
{
    
}

void Furion_Thin_Lens::Furion_thin_Lens(std::vector<std::vector<std::complex<double>> >& out_Field, std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& in_Field, double wavelength, double focus_length, int flag, int n)
{
    double k = 2 * std::_Pi / wavelength;
    double cache = -k / 2 / focus_length;

    if (flag == 1)
    {
        for (int i = 0; i < n; i++) 
        {
            for (int j = 0; j < n; j++) 
            {
                out_Field[i][j] = in_Field[i][j] * std::exp(std::complex<double>(0, X[i][j] * X[i][j] * cache));
            }
        }
    }
    else if (flag == 2)
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                out_Field[i][j] = in_Field[i][j] * std::exp(std::complex<double>(0, Y[i][j] * Y[i][j] * cache));
            }
        }
    }
    else
    {
        for (int i = 0; i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                out_Field[i][j] = in_Field[i][j] * std::exp(std::complex<double>(0, Y[i][j] * Y[i][j] * cache));
            }
        }
    }
}




