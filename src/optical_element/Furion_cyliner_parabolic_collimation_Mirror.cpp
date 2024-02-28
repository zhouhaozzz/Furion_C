#include "Furion_cyliner_parabolic_collimation_Mirror.h"

using namespace Furion_NS;

Furion_Cyliner_Parabolic_Collimation_Mirror::Furion_Cyliner_Parabolic_Collimation_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "Furion_Cyliner_Parabolic_Collimation_Mirror 初始化" << endl;
    this->r1 = r1;
}

Furion_Cyliner_Parabolic_Collimation_Mirror::~Furion_Cyliner_Parabolic_Collimation_Mirror()
{

}

void Furion_Cyliner_Parabolic_Collimation_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Cyliner_Parabolic_Collimation_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

std::string Furion_Cyliner_Parabolic_Collimation_Mirror::tracing()
{
    cout << "Furion_Cyliner_Parabolic_Collimation_Mirror的tracing" << endl;
    this->g_FCPC_mirror = new G_Furion_Cyliner_Parabolic_Collimation_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r1, this->grating);
    g_FCPC_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, this->surface, this->r1, this->grating);

    return ("Furion_Cyliner_Parabolic_Collimation_Mirror");
}