#include "G_Cylinder_Ellipse.h"

using namespace Furion_NS;

G_Cylinder_Ellipse::G_Cylinder_Ellipse(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    this->r1 = r1;
    this->e = sqrt(r1 * r1 + r2 * r2 - 2 * r1 * r2 * cos(Pi - 2 * theta)) / 2;
    this->alpha = acos((r1 * r1 + 4 * this->e * this->e - r2 * r2) / (4 * r1 * this->e));
    this->beta = acos((r2 * r2 + 4 * this->e * this->e - r1 * r1) / (4 * r2 * this->e));
    this->a = (r1 + r2) / 2;
    this->b = sqrt(this->a * this->a - this->e * this->e);
    //cout << this->r1 << " " << e << " " << alpha << " " << beta << " " << a << " " << b<<endl;
    reflect(beam_in, ds, di, chi, theta);
}

G_Cylinder_Ellipse::~G_Cylinder_Ellipse()
{
    delete[] T, Nx, Ny, Nz;
}

void G_Cylinder_Ellipse::source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N)
{

    int n = Furion::n;

    double *OS_0 = new double[9];  
    double *OS_1 = new double[9]; 
    f_rx.furion_rotx(this->alpha, OS_0);
    f_rz.furion_rotz(this->chi, OS_1);

    double *X0 = new double[Furion::n];
    double *Y0 = new double[Furion::n];
    double *Z0 = new double[Furion::n];
    double *ZZ = new double[Furion::n];
    double z = this->r1 - ds; for (int i = 0; i < n; i++) {ZZ[i] = z;}
    matrixMulti(X0, Y0, Z0, OS_1, X, Y, ZZ, n);
    matrixMulti(this->X1, this->Y1, this->Z1, OS_0, X0, Y0, Z0, n);
    for (int i = 0; i < n; i++) {this->Z1[i] = this->Z1[i] -this->e;}

    matrixMulti(X0, Y0, Z0, OS_0, L, M, N, n);
    matrixMulti(this->L1, this->M1, this->N1, OS_1, X0, Y0, Z0, n);


    delete[] X0, Y0, Z0, ZZ, OS_0, OS_1;
}


void G_Cylinder_Ellipse::intersection(double* T)
{
    int n = Furion::n;

    double *A= new double[Furion::n];
    double *B= new double[Furion::n];
    double *C= new double[Furion::n];
    double a2 = this->a * this->a;
    double b2 = this->b * this->b;
    double ab2 = a2*b2;

    for (int i = 0; i < n; i++) 
    {
        A[i] = b2*this->N1[i]*this->N1[i] + a2*this->M1[i]*this->M1[i];
        B[i] = 2 * (b2*this->N1[i]*this->Z1[i] + a2*this->M1[i]*this->Y1[i]);
        C[i] = a2*this->Y1[i]*this->Y1[i] + b2*this->Z1[i]*this->Z1[i] - ab2;
        T[i] = (-B[i] + sqrt(B[i]*B[i] - 4*A[i]*C[i])) / (2*A[i]);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i]*this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i]*this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i]*this->N1[i];
    }

    delete[] A,B,C;
}

void G_Cylinder_Ellipse::normal(double *Nx, double *Ny, double *Nz)
{
    int n = Furion::n;
    
    double a2 = this->a * this->a;
    double b2 = this->b * this->b;
    double a4 = a2*a2;
    double b4 = b2*b2;
    double ab2 = a2*b2;
    double data;

    for (int i = 0; i < n; i++) 
    {
        data = sqrt(this->Y2[i]*this->Y2[i]/b4 + this->Z2[i]*this->Z2[i]/a4);
        Ny[i] = -(this->Y2[i]/b2) / data;
        Nz[i] = -(this->Z2[i]/a2) / data;
        Nx[i] = 0;

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }    
}

void G_Cylinder_Ellipse::h_slope(double *h_slope, double *Y2)
{
    int n = Furion::n;

    for (int i = 0; i < n; i++) 
    {
        h_slope[i] = 0;
        // Y2[i] = h0[i] + Y2[i];
    }
}