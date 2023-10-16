#include "g_Furion_cyliner_parabolic_focus_Mirror.h"

using namespace Furion_NS;

G_Furion_Cyliner_Parabolic_Focus_Mirror::G_Furion_Cyliner_Parabolic_Focus_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "G_Furion_Cyliner_Parabolic_Focus_Mirror 初始化" << endl;
    //run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

G_Furion_Cyliner_Parabolic_Focus_Mirror::~G_Furion_Cyliner_Parabolic_Focus_Mirror()
{

}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Cyliner_Parabolic_Focus_Mirror的run" << endl;
    set_center(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    reflect(beam_in, ds, di, chi, theta);
}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::intersection(double* T)
{
    int n = Furion::n;
    
    for (int i = 0; i < n; i++) {T[i] = center->T[i];}
    cneter_to_oe_p(this->X2, this->Y2, this->Z2, center->X2, center->Y2, center->Z2);
    cout << "G_Furion_Cyliner_Parabolic_Focus_Mirror的intersection" << endl;
}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::normal(double *Nx, double *Ny, double *Nz)
{
    cneter_to_oe_v(Nx, Ny, Nz, center->Nx, center->Ny, center->Nz);
    cout << "G_Furion_Cyliner_Parabolic_Focus_Mirror的normal" << endl;
}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::matrixMulti_GFCPFM(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, double dy, int n)
{
    for (int i = 0; i < n; i++)
    {
        L2[i] = matrix[0] * L[i] + matrix[1] * (M[i] + dy) + matrix[2] * (N[i] + dx);
        M2[i] = matrix[3] * L[i] + matrix[4] * (M[i] + dy) + matrix[5] * (N[i] + dx);
        N2[i] = matrix[6] * L[i] + matrix[7] * (M[i] + dy) + matrix[8] * (N[i] + dx);
    }
}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::cneter_to_oe_p(double *X2, double *Y2, double *Z2, double *X, double *Y, double *Z)
{
    int n = beam_in->n;

    double *OS = new double[9];
    f_rx.furion_rotx(this->theta, OS);

    double dx = center->r2 - 0.5 * center->p;
    double dy = center->r2 * sin(2 * center->theta);
    matrixMulti_GFCPFM(X2, Y2, Z2, OS, X, Y, Z, dx, dy, n);
    
    delete[] OS;
}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::cneter_to_oe_v(double *Nx, double *Ny, double *Nz, double *L, double *M, double *N)
{
    int n = beam_in->n;

    double* OS = new double[9];

    f_rx.furion_rotx(this->theta, OS);

    matrixMulti(Nx, Ny, Nz, OS, L, M, N, 0, n);

    delete[] OS;

}

void G_Furion_Cyliner_Parabolic_Focus_Mirror::set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Furion_Cyliner_Parabolic_Collimation_Mirror的set_center" << endl;
    center = new G_Cyliner_Parabolic_Focus(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
    center->run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}