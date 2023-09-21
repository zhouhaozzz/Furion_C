#include "g_Furion_cylinder_ellipse_Mirror.h"

using namespace Furion_NS;

G_Furion_Cylinder_Ellipse_Mirror::G_Furion_Cylinder_Ellipse_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating), center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    //this->center = G_Cylinder_Ellipse(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    reflect(beam_in, ds, di, chi, theta);

}

G_Furion_Cylinder_Ellipse_Mirror::~G_Furion_Cylinder_Ellipse_Mirror()
{
    //delete ct;
}


void G_Furion_Cylinder_Ellipse_Mirror::intersection(double* T)
{
    int n = Furion::n;
    
    for (int i = 0; i < n; i++) {T[i] = center.T[i];}
    cneter_to_oe_p(this->X2, this->Y2, this->Z2, center.X2, center.Y2, center.Z2);
}

void G_Furion_Cylinder_Ellipse_Mirror::normal(double *Nx, double *Ny, double *Nz)
{
    cneter_to_oe_v(Nx, Ny, Nz, center.Nx, center.Ny, center.Nz);
}


void G_Furion_Cylinder_Ellipse_Mirror::cneter_to_oe_p(double *X2, double *Y2, double *Z2, double *X, double *Y, double *Z)
{
    double a1 = center.e;
    double alpha1 = center.alpha;
    int n = beam_in->n;

    double *OS_0 = new double[9];  
    double *OS_1 = new double[9]; 
    f_rx.furion_rotx(this->theta, OS_0);
    f_rx.furion_rotx(-alpha1, OS_1);

    double *X0 = new double[Furion::n];
    double *Y0 = new double[Furion::n];
    double *Z0 = new double[Furion::n];
    double *ZZ = new double[Furion::n];
    for (int i = 0; i < n; i++) {ZZ[i] = Z[i] + a1;}
    matrixMulti(X0, Y0, Z0, OS_1, X, Y, ZZ, n);
    for (int i = 0; i < n; i++) {Z0[i] = Z0[i] - center.r1;}
    matrixMulti(X2, Y2, Z2, OS_0, X0, Y0, Z0, n);

    delete OS_0, OS_1, X0, Y0, Z0, ZZ;
}

void G_Furion_Cylinder_Ellipse_Mirror::cneter_to_oe_v(double *Nx, double *Ny, double *Nz, double *L, double *M, double *N)
{
    double alpha1 = center.alpha;
    int n = beam_in->n;

    double *OS_0 = new double[9];  
    double *OS_1 = new double[9];
    f_rx.furion_rotx(this->theta, OS_0);
    f_rx.furion_rotx(-alpha1, OS_1);

    double *X0 = new double[Furion::n];
    double *Y0 = new double[Furion::n];
    double *Z0 = new double[Furion::n];
    matrixMulti(X0, Y0, Z0, OS_1, L, M, N, n);
    matrixMulti(Nx, Ny, Nz, OS_0, X0, Y0, Z0, n);

    delete OS_0, OS_1, X0, Y0, Z0;
}

// void G_Furion_Cylinder_Ellipse_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
// {
//     this->center = G_Cylinder_Ellipse(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
// }