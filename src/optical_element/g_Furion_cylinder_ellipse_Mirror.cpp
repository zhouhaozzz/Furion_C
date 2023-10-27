#include "g_Furion_cylinder_ellipse_Mirror.h"

using namespace Furion_NS;

G_Furion_Cylinder_Ellipse_Mirror::G_Furion_Cylinder_Ellipse_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "G_Furion_Cylinder_Ellipse_Mirror 初始化" << endl;
}

G_Furion_Cylinder_Ellipse_Mirror::~G_Furion_Cylinder_Ellipse_Mirror()
{
    //delete ct;
}

void G_Furion_Cylinder_Ellipse_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Cylinder_Ellipse_Mirror的run" << endl;
    set_center(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    reflect(beam_in, ds, di, chi, theta);
}

void G_Furion_Cylinder_Ellipse_Mirror::intersection(double* T)
{
    int n = this->n;
    
    for (int i = 0; i < n; i++) {T[i] = center->T[i];}
    cneter_to_oe_p(this->X2, this->Y2, this->Z2, center->X2, center->Y2, center->Z2);
    cout << "G_Furion_Cylinder_Ellipse_Mirror的intersection" << endl;

}

void G_Furion_Cylinder_Ellipse_Mirror::normal(double *Nx, double *Ny, double *Nz)
{
    cneter_to_oe_v(Nx, Ny, Nz, center->Nx, center->Ny, center->Nz);
    cout << "G_Furion_Cylinder_Ellipse_Mirror的normal" << endl;
}

void G_Furion_Cylinder_Ellipse_Mirror::matrixMulti_GFCEM(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, int n)
{
    for (int i = 0; i < n; i++)
    {
        L2[i] = matrix[0] * L[i] + matrix[1] * M[i] + matrix[2] * (N[i] + dx);
        M2[i] = matrix[3] * L[i] + matrix[4] * M[i] + matrix[5] * (N[i] + dx);
        N2[i] = matrix[6] * L[i] + matrix[7] * M[i] + matrix[8] * (N[i] + dx);
    }
}

void G_Furion_Cylinder_Ellipse_Mirror::cneter_to_oe_p(double *X2, double *Y2, double *Z2, double *X, double *Y, double *Z)
{
    double a1 = center->e;
    double alpha1 = center->alpha;
    int n = this->n;

    double *OS_0 = new double[9];
    double *OS_1 = new double[9]; 
    f_rx.furion_rotx(this->theta, OS_0);
    f_rx.furion_rotx(-alpha1, OS_1);

    double *X0 = new double[n];
    double *Y0 = new double[n];
    double *Z0 = new double[n];
    //for (int i = 0; i < n; i++) {ZZ[i] = Z[i] + a1;}
    matrixMulti_GFCEM(X0, Y0, Z0, OS_1, X, Y, Z, a1, n);
    //for (int i = 0; i < n; i++) {Z0[i] = Z0[i] - center->r1;}
    matrixMulti_GFCEM(X2, Y2, Z2, OS_0, X0, Y0, Z0, - center->r1, n);
    
    // Furion_rotx(obj.theta)*((Furion_rotx(-alpha1)*[X;Y;Z+a1])-repmat([0; 0;obj.center.r1],1,n));
    destory_1d(X0);
    destory_1d(Y0);
    destory_1d(Z0);
    destory_1d(OS_0);
    destory_1d(OS_1);
}

void G_Furion_Cylinder_Ellipse_Mirror::cneter_to_oe_v(double *Nx, double *Ny, double *Nz, double *L, double *M, double *N)
{
    double alpha1 = center->alpha;
    int n = this->n;

    double* OS = new double[9];
    double *OS_0 = new double[9];
    double *OS_1 = new double[9];
    f_rx.furion_rotx(this->theta, OS_0);
    f_rx.furion_rotx(-alpha1, OS_1);

    matrixMulti33(OS, OS_0, OS_1);
    matrixMulti(Nx, Ny, Nz, OS, L, M, N, 0, n);

    destory_1d(OS);
    destory_1d(OS_0);
    destory_1d(OS_1);

}

void G_Furion_Cylinder_Ellipse_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Cylinder_Ellipse_Mirror的set_center" << endl;
    center = new G_Cylinder_Ellipse(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    center->run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}