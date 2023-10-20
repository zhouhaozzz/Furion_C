#include "g_cyliner_parabolic_collimation.h"

using namespace Furion_NS;

G_Cyliner_Parabolic_Collimation::G_Cyliner_Parabolic_Collimation(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    this->r1 = r1;
    this->p = r1 * (1 - cos(2 * theta));
    cout << "G_Cyliner_Parabolic_Collimation 初始化" << endl;
}

G_Cyliner_Parabolic_Collimation::~G_Cyliner_Parabolic_Collimation()
{
    //delete ct;
}

void G_Cyliner_Parabolic_Collimation::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Cyliner_Parabolic_Collimation的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Cyliner_Parabolic_Collimation::source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N)
{
    int n = this->n;

    double* OS = new double[9];
    double* OS_0 = new double[9];
    double* OS_1 = new double[9];
    f_rx.furion_rotx(2*this->theta, OS_0);
    f_rz.furion_rotz(this->chi, OS_1);

    double* X0 = new double[n];
    double* Y0 = new double[n];
    double* Z0 = new double[n];
    double* Z = new double[1];
    Z[0] = this->r1 - ds;

    matrixMulti0(X0, Y0, Z0, OS_1, X, Y, Z, n);
    matrixMulti(this->X1, this->Y1, this->Z1, OS_0, X0, Y0, Z0, this->p / 2, n);

    matrixMulti33(OS, OS_0, OS_1);
    matrixMulti(this->L1, this->M1, this->N1, OS, L, M, N, 0, n);
    
    delete[] X0, Y0, Z0, Z, OS, OS_0, OS_1;
    cout << "G_Cyliner_Parabolic_Collimation的source_to_oe" << endl;
}


void G_Cyliner_Parabolic_Collimation::intersection(double* T)
{
    int n = this->n;

    double* A = new double[n];
    double* B = new double[n];
    double* C = new double[n];

    for (int i = 0; i < n; i++)
    {
        A[i] = this->M1[i] * this->M1[i];
        B[i] = 2 * (-this->N1[i] * this->p + this->M1[i] * this->Y1[i]);
        C[i] = this->Y1[i] * this->Y1[i] - 2 * this->p * this->Z1[i];
        T[i] = (-B[i] + sqrt(B[i] * B[i] - 4 * A[i] * C[i])) / (2 * A[i]);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i] * this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i] * this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i] * this->N1[i];
    }
    cout << "G_Cyliner_Parabolic_Collimation的intersection" << endl;

    delete[] A, B, C;
}

void G_Cyliner_Parabolic_Collimation::normal(double* Nx, double* Ny, double* Nz)
{
    int n = this->n;

    double data;
    double p2 = this->p * this->p;

    for (int i = 0; i < n; i++)
    {
        data = sqrt(this->Y2[i] * this->Y2[i] + p2);
        Ny[i] = -(this->Y2[i]) / data;
        Nz[i] = (this->p) / data;
        Nx[i] = 0;

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }
    cout << "G_Cyliner_Parabolic_Collimation的normal" << endl;
}

void G_Cyliner_Parabolic_Collimation::h_slope(double* h_slope, double* Y2)
{
    int n = this->n;

    for (int i = 0; i < n; i++)
    {
        h_slope[i] = 0;
        // Y2[i] = h0[i] + Y2[i];
    }
    cout << " G_Cyliner_Parabolic_Collimation的h_slope" << endl;

}