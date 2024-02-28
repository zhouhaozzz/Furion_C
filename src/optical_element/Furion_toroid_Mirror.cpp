#include "Furion_toroid_Mirror.h"

using namespace Furion_NS;

Furion_Toroid_Mirror::Furion_Toroid_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "Furion_Toroid_Mirror ³õÊ¼»¯" << endl;
    this->R1 = R1;
    this->R2 = R2;
    this->rho1 = rho1;
    this->rho2 = rho2;
}

Furion_Toroid_Mirror::~Furion_Toroid_Mirror()
{

}

void Furion_Toroid_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Toroid_MirrorµÄrun" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

std::string Furion_Toroid_Mirror::tracing()
{
    cout << "Furion_Toroid_Mirror" << endl;
    this->g_FT_mirror = new G_Furion_Toroid_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->R1, this->R2, this->rho1, this->rho2, this->grating);
    g_FT_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta);

    return ("Furion_Toroid_Mirror");
}

