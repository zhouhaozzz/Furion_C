#include "Furion_Paraboid_Focus_Mirror.h"

using namespace Furion_NS;

Furion_Paraboid_Focus_Mirror::Furion_Paraboid_Focus_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "Furion_Paraboid_Focus_Mirror 初始化" << endl;
    this->r2 = r2;
}

Furion_Paraboid_Focus_Mirror::~Furion_Paraboid_Focus_Mirror()
{

}

void Furion_Paraboid_Focus_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Paraboid_Focus_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

std::string Furion_Paraboid_Focus_Mirror::tracing()
{
    cout << "Furion_Paraboid_Focus_Mirror的tracing" << endl;
    this->g_FPF_mirror = new G_Furion_Paraboid_Focus_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r2, this->grating);
    g_FPC_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r2, this->grating);

    return ("Furion_Paraboid_Focus_Mirror");
}

