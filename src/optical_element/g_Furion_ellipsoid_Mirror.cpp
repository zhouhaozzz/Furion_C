#include "g_Furion_ellipsoid_Mirror.h"
#include "g_ellipsoid.h"

using namespace Furion_NS;

G_Furion_ellipsoid_Mirror::G_Furion_ellipsoid_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Furion_Cylinder_Ellipse_Mirror(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "G_Furion_ellipsoid_Mirror 初始化" << endl;
    //test();
}

G_Furion_ellipsoid_Mirror::~G_Furion_ellipsoid_Mirror()
{
    //delete center;
    //cout << "G_Furion_ellipsoid_Mirror 析构" << endl;
}

void G_Furion_ellipsoid_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    center = new G_Ellipsoid(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    cout << "G_Furion_ellipsoid_Mirror的set_center" << endl;
}