#include "g_Furion_paraboid_collimation_Mirror.h"
#include "g_paraboid_collimation.h"

using namespace Furion_NS;

G_Furion_Paraboid_Collimation_Mirror::G_Furion_Paraboid_Collimation_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Furion_Cyliner_Parabolic_Collimation_Mirror(beam_in, ds, di, chi, theta, surface, r1, r2, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "G_Furion_Paraboid_Collimation_Mirror 初始化" << endl;
}

G_Furion_Paraboid_Collimation_Mirror::~G_Furion_Paraboid_Collimation_Mirror()
{
    //delete ct;
}

void G_Furion_Paraboid_Collimation_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Paraboid_Collimation_Mirror::run的run" << endl;
    set_center(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

void G_Furion_Paraboid_Collimation_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Paraboid_Collimation_Mirror的set_center" << endl;
    center = new G_Paraboid_Collimation(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}