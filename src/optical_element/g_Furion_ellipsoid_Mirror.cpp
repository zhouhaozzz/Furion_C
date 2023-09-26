#include "g_Furion_ellipsoid_Mirror.h"

using namespace Furion_NS;

G_Furion_ellipsoid_Mirror::G_Furion_ellipsoid_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Furion_Cylinder_Ellipse_Mirror(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{

}

G_Furion_ellipsoid_Mirror::~G_Furion_ellipsoid_Mirror()
{
    //delete ct;
}

