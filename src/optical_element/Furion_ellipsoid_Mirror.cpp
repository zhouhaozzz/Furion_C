#include "Furion_ellipsoid_Mirror.h"

using namespace Furion_NS;

Furion_Ellipsoid_Mirror::Furion_Ellipsoid_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "Furion_Ellipsoid_Mirror 初始化" << endl;
    this->r1 = r1;
    this->r2 = r2;
}

Furion_Ellipsoid_Mirror::~Furion_Ellipsoid_Mirror()
{

}

void Furion_Ellipsoid_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Ellipsoid_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

std::string Furion_Ellipsoid_Mirror::tracing()
{
    cout << "Furion_Ellipsoid_Mirror的tracing" << endl;
    this->g_FE_mirror = new G_Furion_ellipsoid_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r1, this->r2, this->grating);
    g_FE_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r1, this->r2, this->grating);

    return ("Furion_Ellipsoid_Mirror");
}

