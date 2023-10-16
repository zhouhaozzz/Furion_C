#include "g_cyliner_parabolic_focus.h"

using namespace Furion_NS;

G_Cyliner_Parabolic_Focus::G_Cyliner_Parabolic_Focus(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    this->r2 = r2;
    this->p = r2 * (1 - cos(2 * theta));
    cout << "G_Cyliner_Parabolic_Focus 初始化" << endl;
    //run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

G_Cyliner_Parabolic_Focus::~G_Cyliner_Parabolic_Focus()
{
    //delete ct;
}

void G_Cyliner_Parabolic_Focus::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Cyliner_Parabolic_Focus的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Cyliner_Parabolic_Focus::matrixMulti_GCPF(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, double dy, int n)
{
    for (int i = 0; i < n; i++)
    {
        L2[i] = matrix[0] * L[i] + matrix[1] * (M[i] + dy) + matrix[2] * (N[0] + dx);
        M2[i] = matrix[3] * L[i] + matrix[4] * (M[i] + dy) + matrix[5] * (N[0] + dx);
        N2[i] = matrix[6] * L[i] + matrix[7] * (M[i] + dy) + matrix[8] * (N[0] + dx);
    }
}

void G_Cyliner_Parabolic_Focus::source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N)
{
    int n = Furion::n;

    double* OS = new double[9];
    f_rz.furion_rotz(this->chi, OS);

    double* Z = new double[1];
    Z[0] = -(ds + this->r2 - 0.5 * this->p);
    double dy = -this->r2 * sin(2 * this->theta);

    matrixMulti_GCPF(this->X1, this->Y1, this->Z1, OS, X, Y, Z, 0, dy, n);

    matrixMulti(this->L1, this->M1, this->N1, OS, L, M, N, 0, n);
    
    delete[] Z, OS;
    cout << "G_Cyliner_Parabolic_Focus的source_to_oe" << endl;
}


void G_Cyliner_Parabolic_Focus::intersection(double* T)
{
    int n = Furion::n;

    double* A = new double[Furion::n];
    double* B = new double[Furion::n];
    double* C = new double[Furion::n];

    for (int i = 0; i < n; i++)
    {
        A[i] = this->M1[i] * this->M1[i];
        B[i] = 2 * (this->N1[i] * this->p + this->M1[i] * this->Y1[i]);
        C[i] = this->Y1[i] * this->Y1[i] + 2 * this->p * this->Z1[i];
        T[i] = A[i];

        if (A[i] == 0)
        {
            T[i] = (this->Y1[i] * this->Y1[i] + 2 * this->p * this->Z1[i]) / (-2 * this->p * this->N1[i]);
        }
        else
        {
            T[i] = sqrt(-B[i] + (B[i] * B[i] - 4 * A[i] * C[i])) / (2 * A[i]);
        }
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i] * this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i] * this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i] * this->N1[i];
    }
    cout << "G_Cyliner_Parabolic_Focus的intersection" << endl;

    delete[] A, B, C;
}

void G_Cyliner_Parabolic_Focus::normal(double* Nx, double* Ny, double* Nz)
{
    int n = Furion::n;

    double data;
    double p2 = this->p * this->p;

    for (int i = 0; i < n; i++)
    {
        data = sqrt(this->Y2[i] * this->Y2[i] + p2);
        Ny[i] = -(this->Y2[i]) / data;
        Nz[i] = -(this->p) / data;
        Nx[i] = 0;

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }
    cout << "G_Cyliner_Parabolic_Focus的normal" << endl;
}

void G_Cyliner_Parabolic_Focus::h_slope(double* h_slope, double* Y2)
{
    int n = Furion::n;

    for (int i = 0; i < n; i++)
    {
        h_slope[i] = 0;
        // Y2[i] = h0[i] + Y2[i];
    }
    cout << " G_Cyliner_Parabolic_Focus的h_slope" << endl;

}