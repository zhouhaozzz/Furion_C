#include "g_ellipsoid.h"

using namespace Furion_NS;

G_Ellipsoid::G_Ellipsoid(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Cylinder_Ellipse(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    cout << "��ʼ��G_Ellipsoid" << endl;
    run(beam_in, ds, di, chi, theta, surface, r1, r2, grating);
}

G_Ellipsoid::~G_Ellipsoid()
{
    //delete ct;
}

void G_Ellipsoid::intersection(std::vector<double>& T)
{
    int n = this->n;

    //double *A = new double[this->n];
    //double *B = new double[this->n];
    //double *C = new double[this->n];
    //std::vector<double> A(n);
    //std::vector<double> B(n);
    //std::vector<double> C(n);
    double a2 = this->a * this->a;
    double b2 = this->b * this->b;
    double ab2 = a2*b2;
    double A, B, C;

    for (int i = 0; i < n; i++) 
    {
        A = b2 * this->N1[i] * this->N1[i] + a2 * this->M1[i] * this->M1[i] + a2 * this->M1[i] * this->L1[i];
        B = 2 * (b2 * this->N1[i] * this->Z1[i] + a2 * this->M1[i] * this->Y1[i] + a2 * this->L1[i] * this->X1[i]);
        C = a2 * this->Y1[i] * this->Y1[i] + b2 * this->Z1[i] * this->Z1[i] - ab2 + a2 * this->X1[i] * this->X1[i];
        T[i] = (-B + sqrt(B * B - 4 * A * C)) / (2 * A);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i]*this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i]*this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i]*this->N1[i];
    }
    cout << "G_Ellipsoid��intersection" << endl;

    //destory_1d(A);
    //destory_1d(B);
    //destory_1d(C);
}

void G_Ellipsoid::normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz)
{
    int n = this->n;
    
    double a2 = this->a * this->a;
    double b2 = this->b * this->b;
    double a4 = a2*a2;
    double b4 = b2*b2;
    double ab2 = a2*b2;
    double data;
    
    for (int i = 0; i < n; i++) 
    {
        data = sqrt(this->Y2[i]*this->Y2[i]/b4 + this->Z2[i]*this->Z2[i]/a4 + this->X2[i] * this->X2[i] / b4);
        Nx[i] = -(this->X2[i]/b2) / data;;
        Ny[i] = -(this->Y2[i]/b2) / data;
        Nz[i] = -(this->Z2[i]/a2) / data;

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }    

    cout << "G_Ellipsoid��normal" << endl;
}