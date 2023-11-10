#include "Beam.h"

using namespace Furion_NS;

Beam::Beam(double** X, double** Y, std::complex<double>** field, double wavelength, int N) :
    wavelength(wavelength), X(X), Y(Y), field(field), XX(nullptr), YY(nullptr), N(N), phase_field(nullptr)
{
    cout << "Beam的初始化" << endl;
    //create_2d(phase_field, N);
}

Beam::~Beam()
{
    //destory_2d(X, N);
    //destory_2d(Y, N);
    //destory_2d(field, N);
    //destory_1d(XX);
    //destory_1d(YY);
    cout << "Beam的析构" << endl;
}

void Beam::destory()
{
    destory_2d(X, N);
    destory_2d(Y, N);
    destory_2d(field, N);
    destory_1d(XX);
    destory_1d(YY);
    cout << "Beam的destory" << endl;
}

Beam Beam::translate(double distance)
{
    int flag = 2;
    double L = Furion_NS::Max(this->X[0], N) - Furion_NS::Min(this->X[0], N);
    
    if (flag == 1)
    {

    }
    else if (flag == 2)
    {
        f_f_s.Furion_fresnel_spectralh(this->N, 1 / L, this->field, this->wavelength, distance);

    }
    else if (flag == 3)
    {

    }
    else
    {

    }

    //for (int i = 0; i < N; i++)
    //{
    //    for (int j = 0; j < N; j++)
    //    {
    //        cout << this->field[i][j] << "  ";
    //    }
    //    cout << endl;
    //}

    return Beam(this->X, this->Y, this->field, this->wavelength, this->N);
}

void Beam::plot_sigma(double distance, int rank1)
{
    //Beam beam = translate(distance);
    //f_p_s.Furion_plot_sigma(beam.XX, beam.YY, beam.phi, beam.psi, rank1, beam.n);
}

double Furion_NS::Max(double* X, int n)
{
    double max = X[0];
    for (int i = 1; i < n; i++)
    {
        if (X[i] > max)
        {
            max = X[i];
        }
    }

    return max;
}

double Furion_NS::Min(double* X, int n)
{
    double min = X[0];
    for (int i = 1; i < n; i++)
    {
        if (X[i] < min)
        {
            min = X[i];
        }
    }

    return min;
}


