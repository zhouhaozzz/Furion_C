#include "g_Furion_cyliner_spherical_Mirror.h"

using namespace Furion_NS;

G_Furion_Cyliner_Spherical_Mirror::G_Furion_Cyliner_Spherical_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating), r(r)
{
    cout << "初始化g_Furion_cyliner_spherical_Mirror" << endl;
    //run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

G_Furion_Cyliner_Spherical_Mirror::~G_Furion_Cyliner_Spherical_Mirror()
{
    //delete ct;
}

void G_Furion_Cyliner_Spherical_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating)
{
    cout << "G_Furion_Cyliner_Spherical_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Furion_Cyliner_Spherical_Mirror::intersection(std::vector<double>& T)
{
    int n = this->n;
    double r1 = r;

    //double *A = new double[this->n];
    //double *B = new double[this->n];
    //double *C = new double[this->n];
    //std::vector<double> A(n);
    //std::vector<double> B(n);
    //std::vector<double> C(n);

    double A, B, C;

    for (int i = 0; i < n; i++) 
    {
        A = this->N1[i] * this->N1[i] + this->M1[i] * this->M1[i];
        B = 2 * (this->N1[i] * this->Z1[i] + this->M1[i] * this->Y1[i] - r1 * this->M1[i]);
        C = this->Y1[i] * this->Y1[i] + this->Z1[i] * this->Z1[i] - 2 * r1 * this->Y1[i];
        T[i] = (-B + std::sqrt(B * B - 4 * A * C)) / (2 * A);

        this->X2[i] = this->X1[i] + T[i] * this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i] * this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i] * this->N1[i];
    }
    cout << "g_Furion_cyliner_spherical_Mirror的intersection" << endl;

    //destory_1d(A);
    //destory_1d(B);
    //destory_1d(C);
}

void G_Furion_Cyliner_Spherical_Mirror::normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz)
{
    int n = this->n;
    
    for (int i = 0; i < n; i++) 
    {
        Nx[i] = 0;
        Ny[i] = -(this->Y2[i] - this->r) / this->r;
        Nz[i] = -this->Z2[i] / this->r;
    }    

    cout << "g_Furion_cyliner_spherical_Mirror的normal" << endl;
}