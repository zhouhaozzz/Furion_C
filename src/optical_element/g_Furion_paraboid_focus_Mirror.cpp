#include "g_Furion_paraboid_focus_Mirror.h"
#include "g_paraboid_focus.h"

using namespace Furion_NS;

G_Furion_Paraboid_Focus_Mirror::G_Furion_Paraboid_Focus_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating)
    : G_Furion_Cyliner_Parabolic_Focus_Mirror(beam_in, ds, di, chi, theta, surface, r2, grating)
{
    G_Furion_Cyliner_Parabolic_Focus_Mirror::run(beam_in, ds, di, chi, theta, surface, r2, grating);
    cout << "G_Furion_Paraboid_Focus_Mirror 初始化" << endl;
}

G_Furion_Paraboid_Focus_Mirror::~G_Furion_Paraboid_Focus_Mirror()
{
    //delete center;
    //cout << "G_Furion_Paraboid_Focus_Mirror 析构" << endl;
}

void G_Furion_Paraboid_Focus_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating)
{
    cout << "G_Furion_Paraboid_Focus_Mirror的run" << endl;
    set_center(beam_in, ds, di, chi, theta, surface, r2, grating);
}

void G_Furion_Paraboid_Focus_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating)
{
    cout << "G_Furion_Paraboid_Focus_Mirror的set_center" << endl;
    center = new G_Paraboid_Focus(beam_in, ds, di, chi, theta, surface, r2, grating);
}