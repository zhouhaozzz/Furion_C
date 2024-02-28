#include "Beam.h"

using namespace Furion_NS;

Beam::Beam(std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& field, double wavelength, int N) :
    wavelength(wavelength), X(X), Y(Y), field(field), N(N)//, XX(nullptr), YY(nullptr), phase_field(nullptr)
{
    cout << "Beam的初始化" << endl;
    //create_2d(phase_field, N);
    //create_2d(kk, N);
    this->kk = std::vector<std::vector<double> >(N, std::vector<double>(N));
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
    //destory_2d(X, N);
    //destory_2d(Y, N);
    //destory_2d(field, N);
    //destory_1d(XX);
    //destory_1d(YY);
    cout << "Beam的destory" << endl;
}

Beam Beam::translate(double distance)
{
    int flag = 2;
    double L = Furion_NS::Max(this->X[0], N) - Furion_NS::Min(this->X[0], N);
    
    if (flag == 1)
    {
        f_f_spa.Furion_fresnel_spatialh(this->X, this->Y, this->field, this->wavelength, distance, this->N);
    }
    else if (flag == 2)
    {
        f_f_spe.Furion_fresnel_spectralh(this->N, 1 / L, this->field, this->wavelength, distance);

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

Beam Beam::resize1(double L)
{
    //double* x = new double[this->N];
    //double* y = new double[this->N];
    std::vector<double> x(this->N);
    std::vector<double> y(this->N);
    Furion_NS::linspace(x, -L / 2, L / 2, this->N);
    Furion_NS::linspace(y, -L / 2, L / 2, this->N);

    //std::complex<double>** Field_new;
    //create_2d(Field_new, this->N);
    std::vector<std::vector<std::complex<double>> > Field_new(this->N, std::vector<std::complex<double>>(this->N));
    //scatteredInterpolant_2d_complex(Field_new, x, y, this->X, this->Y, this->field, this->N);

    //double** X_r;
    //double** Y_r;
    //create_2d(X_r, this->N);
    //create_2d(Y_r, this->N);
    std::vector<std::vector<double> > X_r(this->N, std::vector<double>(this->N));
    std::vector<std::vector<double> > Y_r(this->N, std::vector<double>(this->N));

    for (int i = 0; i < this->N; i++)
    {
        for (int j = 0; j < this->N; j++)
        {
            X_r[i][j] = x[j];
            Y_r[i][j] = y[i];
        }
    }
    
    return Beam(X_r, Y_r, Field_new, this->wavelength, this->N);
    cout << "Beam的resize1" << endl;
}

Beam Beam::resize2(double L, int N)
{
    std::vector<double> x(N);
    std::vector<double> y(N);
    Furion_NS::linspace(x, -L / 2, L / 2, N);
    Furion_NS::linspace(y, -L / 2, L / 2, N);

    std::vector<std::vector<std::complex<double>> > Field_new(N, std::vector<std::complex<double>>(N));
    //scatteredInterpolant_2d_complex(Field_new, x, y, this->X, this->Y, this->field, this->N);

    std::vector<std::vector<double> > X_r(N, std::vector<double>(N));
    std::vector<std::vector<double> > Y_r(N, std::vector<double>(N));

    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            X_r[i][j] = x[j];
            Y_r[i][j] = y[i];
        }
    }

    return Beam(X_r, Y_r, Field_new, this->wavelength, N);
    cout << "Beam的resize2" << endl;
}

Beam Beam::resize3(double Lx, double Ly, int N)
{
    std::vector<double> x(N);
    std::vector<double> y(N);
    Furion_NS::linspace(x, -Lx / 2, Lx / 2, N);
    Furion_NS::linspace(y, -Ly / 2, Ly / 2, N);

    std::vector<std::vector<std::complex<double>> > Field_new(N, std::vector<std::complex<double>>(N));
    //scatteredInterpolant_2d_complex(Field_new, x, y, this->X, this->Y, this->field, this->N);

    std::vector<std::vector<double> > X_r(N, std::vector<double>(N));
    std::vector<std::vector<double> > Y_r(N, std::vector<double>(N));

    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            X_r[i][j] = x[j];
            Y_r[i][j] = y[i];
        }
    }

    return Beam(X_r, Y_r, Field_new, this->wavelength, N);
    cout << "Beam的resize3" << endl;
}

double Beam::power()
{
    int N = this->X[0].size();
    double p = 0;
    double cache;

    std::vector<double> data(N);
    std::vector<double> y(N);
    std::vector<std::vector<double> > field2(N, std::vector<double>(N));
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            cache = std::abs(this->field[i][j]);
            field2[i][j] = cache * cache;
        }
        y[i] = this->Y[i][0];
    }
    
    trapz(data, this->X[0], field2, 2.0);
    trapz(p, y, data, 1);

    return p;
}

void Beam::trapz(std::vector<double>& out, std::vector<double>& x, std::vector<std::vector<double>>& y, double dx) 
{
    int num_points = x.size();
    int num_cols = y[0].size();
    double sum;

    for (int j = 0; j < num_cols; ++j) 
    {
        sum = 0.0;
        for (int i = 1; i < num_points; ++i) 
        {
            sum += (y[i - 1][j] + y[i][j]) * (x[i] - x[i - 1]) / dx;
        }
        out[j] = sum;
    }
}

void Beam::trapz(double& out, std::vector<double>& x, std::vector<double>& y, double dx)
{
    int num_points = x.size();
    out = 0;

    for (int i = 1; i < num_points; ++i) 
    {
        out += (y[i - 1] + y[i]) * (x[i] - x[i - 1]) / dx;
    }
}