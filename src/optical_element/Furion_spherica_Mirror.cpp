#include "Furion_spherica_Mirror.h"

using namespace Furion_NS;

Furion_Spherica_Mirror::Furion_Spherica_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "Furion_Spherica_Mirror ³õÊ¼»¯" << endl;
    this->r = r;
}

Furion_Spherica_Mirror::~Furion_Spherica_Mirror()
{

}

void Furion_Spherica_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Spherica_MirrorµÄrun" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

std::string Furion_Spherica_Mirror::tracing()
{
    cout << "Furion_Spherica_Mirror" << endl;
    this->g_FS_mirror = new G_Furion_Spherical_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r, this->grating);
    g_FPC_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r, this->grating);

    return ("Furion_Spherica_Mirror");
}

