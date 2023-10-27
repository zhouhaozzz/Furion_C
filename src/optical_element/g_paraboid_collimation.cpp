#include "g_paraboid_collimation.h"

using namespace Furion_NS;

G_Paraboid_Collimation::G_Paraboid_Collimation(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Cyliner_Parabolic_Collimation(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "G_Paraboid_Collimation的初始化" << endl;
    G_Cyliner_Parabolic_Collimation::run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

G_Paraboid_Collimation::~G_Paraboid_Collimation()
{
    //delete[] T, Nx, Ny, Nz;
}

void G_Paraboid_Collimation::intersection(double* T)
{
    int n = this->n;

    double *A= new double[n];
    double *B= new double[n];
    double *C= new double[n];

    for (int i = 0; i < n; i++) 
    {
        A[i] = this->M1[i] * this->M1[i] + this->L1[i] * this->L1[i];
        B[i] = 2 * (-this->p * this->N1[i] + this->M1[i] * this->Y1[i] + this->L1[i] * this->X1[i]);
        C[i] = this->X1[i] * this->X1[i] + this->Y1[i] * this->Y1[i] - 2 * this->p * this->Z1[i];
        T[i] = (-B[i] + sqrt(B[i]*B[i] - 4*A[i]*C[i])) / (2*A[i]);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i]*this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i]*this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i]*this->N1[i];
    } 
    cout << "G_Paraboid_Collimation的intersection" << endl;
    
    destory_1d(A);
    destory_1d(B);
    destory_1d(C);
}

void G_Paraboid_Collimation::normal(double *Nx, double *Ny, double *Nz)
{
    int n = this->n;

    double data;
    double p2 = this->p * this->p;

    for (int i = 0; i < n; i++) 
    {
        data = sqrt(this->X2[i]*this->X2[i] + this->Y2[i] * this->Y2[i] + p2);
        Nx[i] = -(this->X2[i]) / data;
        Ny[i] = -(this->Y2[i]) / data;
        Nz[i] = this->p / sqrt(this->X2[i] * this->X2[i] + this->Y2[i] * this->Y2[i] + p2);

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }    
}