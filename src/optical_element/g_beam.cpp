#include "G_Beam.h"

using namespace Furion_NS;

G_Beam::G_Beam(std::vector<double>& XX, std::vector<double>& YY, std::vector<double>& phi, std::vector<double>& psi, double lambda, int n) :
    n(n), lambda(lambda), XX(XX), YY(YY), phi(phi), psi(psi)
{
    cout << "G_Beam的初始化" << endl;
}

G_Beam::~G_Beam()
{
    //destory_1d(this->XX);
    //destory_1d(this->YY);
    //destory_1d(this->psi);
    //destory_1d(this->phi);
    cout << "G_Beam的析构" << endl;

}

G_Beam G_Beam::translate(double distance)
{
    for (int i = 0; i < n; i++)
    {
        XX[i] = XX[i] + distance * tan(phi[i]) * cos(psi[i]);
        YY[i] = YY[i] + distance * tan(psi[i]);
    }

    return G_Beam(XX, YY, phi, psi, lambda, n);
}

void G_Beam::plot_sigma(double distance, int rank1)
{
    G_Beam beam = translate(distance);
    f_p_s.Furion_plot_sigma(beam.XX, beam.YY, beam.phi, beam.psi, rank1, beam.n);
}


