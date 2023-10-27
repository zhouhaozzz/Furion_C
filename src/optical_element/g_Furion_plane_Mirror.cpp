#include "g_Furion_plane_Mirror.h"

using namespace Furion_NS;

G_Furion_Plane_Mirror::G_Furion_Plane_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "G_Furion_Plane_Mirror ³õÊ¼»¯" << endl;
}

G_Furion_Plane_Mirror::~G_Furion_Plane_Mirror()
{
    //delete ct;
}

void G_Furion_Plane_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Plane_MirrorµÄrun" << endl;
    reflect(beam_in, ds, di, chi, theta);
}