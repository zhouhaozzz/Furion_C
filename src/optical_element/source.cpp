#include "source.h"

using namespace Furion_NS;

Source::Source(double L, int N, double sigma, double wavelength)
    : L(L), N(N), wavelength(wavelength), sigma(sigma), X(nullptr), Y(nullptr), field(nullptr), XX(nullptr), YY(nullptr)
{
    cout << "Source的初始化" << endl;
    double* x = new double[N];

    Furion_NS::linspace(x, -this->L / 2, this->L / 2, this->N);

    create_2d(this->X, N);
    create_2d(this->Y, N);
    create_2d(this->field, N);

    double imagPart = 0.0;
    double sigma2 = sigma * sigma;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            this->X[i][j] = x[j];
            this->Y[i][j] = x[i];
            this->field[i][j] = std::complex<double>(exp(-(this->X[i][j] * this->X[i][j] + this->Y[i][j] * this->Y[i][j]) / 2 / sigma2), imagPart);
        }
    }

    destory_1d(x);
}

Source::~Source()
{
    destory_2d(this->X, N);
    destory_2d(this->Y, N);
    destory_2d(this->field, N);
    destory_1d(this->XX);
    destory_1d(this->YY);
    cout << "Source的析构" << endl;

}

Beam* Source::beam_out()
{
    //Beam beam;
    Beam* beam = new Beam(this->X, this->Y, this->field, this->wavelength, this->N);

    return beam;
}
