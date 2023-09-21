#include "G_Beam.h"

using namespace Furion_NS;

G_Beam::G_Beam(double* XX, double* YY, double* phi, double* psi, double lambda) :
    XX(XX), YY(YY), phi(phi), psi(psi), n(Furion::n), lambda(lambda)
{

}

G_Beam::~G_Beam()
{
    //delete XX, YY, psi, phi;   
}

G_Beam G_Beam::translate(double distance)
{
    for (int i = 0; i < n; i++)
    {
        XX[i] = XX[i] + distance * tan(phi[i]) * cos(psi[i]);
        YY[i] = YY[i] + distance * tan(psi[i]);
    }

    return G_Beam(XX, YY, phi, psi, lambda);
}

void G_Beam::plot_sigma(double distance, int rank1)
{
    G_Beam beam = translate(distance);
    f_p_s.Furion_plot_sigma(beam.XX, beam.YY, beam.phi, beam.psi, rank1);
}


