#include "G_Cylinder_Ellipse.h"

using namespace Furion_NS;

G_Cylinder_Ellipse::G_Cylinder_Ellipse(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    this->r1 = r1;
    this->e = sqrt(r1 * r1 + r2 * r2 - 2 * r1 * r2 * cos(_Pi - 2 * theta)) / 2;
    this->alpha = acos((r1 * r1 + 4 * this->e * this->e - r2 * r2) / (4 * r1 * this->e));
    this->beta = acos((r2 * r2 + 4 * this->e * this->e - r1 * r1) / (4 * r2 * this->e));
    this->a = (r1 + r2) / 2;
    this->b = sqrt(this->a * this->a - this->e * this->e);
    this->T = std::vector<double>(Furion::n);
    this->Nx = std::vector<double>(Furion::n);
    this->Ny = std::vector<double>(Furion::n);
    this->Nz = std::vector<double>(Furion::n);
    //cout << this->r1 << " " << e << " " << alpha << " " << beta << " " << a << " " << b<<endl;
    cout << "G_Cylinder_Ellipse的初始化" << endl;
}

G_Cylinder_Ellipse::~G_Cylinder_Ellipse()
{
    //destory_1d(this->T);
    //destory_1d(this->Nx);
    //destory_1d(this->Ny);
    //destory_1d(this->Nz);
    T.clear();
    Nx.clear();
    Ny.clear();
    Nz.clear();
    cout << "G_Cylinder_Ellipse的析构" << endl;
}

void G_Cylinder_Ellipse::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating)
{
    cout << "G_Cylinder_Ellipse的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Cylinder_Ellipse::source_to_oe(std::vector<double>& X, std::vector<double>& Y, double ds, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N)
{
    int n = this->n;

    //double* OS = new double[9];
    //double *OS_0 = new double[9];
    //double *OS_1 = new double[9]; 
    std::vector<double> OS(9);
    std::vector<double> OS_0(9);
    std::vector<double> OS_1(9);
    f_rx.furion_rotx(this->alpha, OS_0);
    f_rz.furion_rotz(this->chi, OS_1);

    //double *X0 = new double[n];
    //double *Y0 = new double[n];
    //double *Z0 = new double[n];
    //std::vector<double> X0(n);
    //std::vector<double> Y0(n);
    //std::vector<double> Z0(n);
    //double *Z = new double[1];
    std::vector<double> Z(1);
    Z[0] = this->r1 - ds;

    double x0, y0, z0;
    matrixMulti33(OS, OS_0, OS_1);
    for (int i = 0; i < n; i++)
    {
        x0 = OS_1[0] * X[i] + OS_1[1] * Y[i] + OS_1[2] * Z[0];
        y0 = OS_1[3] * X[i] + OS_1[4] * Y[i] + OS_1[5] * Z[0];
        z0 = OS_1[6] * X[i] + OS_1[7] * Y[i] + OS_1[8] * Z[0];

        this->X1[i] = OS_0[0] * x0 + OS_0[1] * y0 + OS_0[2] * z0;
        this->Y1[i] = OS_0[3] * x0 + OS_0[4] * y0 + OS_0[5] * z0;
        this->Z1[i] = OS_0[6] * x0 + OS_0[7] * y0 + OS_0[8] * z0 - this->e;

        this->L1[i] = OS[0] * L[i] + OS[1] * M[i] + OS[2] * N[i];
        this->M1[i] = OS[3] * L[i] + OS[4] * M[i] + OS[5] * N[i];
        this->N1[i] = OS[6] * L[i] + OS[7] * M[i] + OS[8] * N[i];
    }

    //matrixMulti0(X0, Y0, Z0, OS_1, X, Y, Z, n);
    //matrixMulti(this->X1, this->Y1, this->Z1, OS_0, X0, Y0, Z0, -this->e, n);
    
    //matrixMulti33(OS, OS_0, OS_1);
    //matrixMulti(this->L1, this->M1, this->N1, OS, L, M, N, 0, n);

    //destory_1d(X0);
    //destory_1d(Y0);
    //destory_1d(Z0);
    //destory_1d(Z);
    //destory_1d(OS);
    //destory_1d(OS_0);
    //destory_1d(OS_1);

    cout << "G_Cylinder_Ellipse的source_to_oe" << endl;
}


void G_Cylinder_Ellipse::intersection(std::vector<double>& T)
{
    int n = this->n;

    //double *A= new double[n];
    //double *B= new double[n];
    //double *C= new double[n];
    //std::vector<double> A(n);
    //std::vector<double> B(n);
    //std::vector<double> C(n);
    double a2 = this->a * this->a;
    double b2 = this->b * this->b;
    double ab2 = a2*b2;
    double A, B, C;

    for (int i = 0; i < n; i++) 
    {
        A = b2*this->N1[i]*this->N1[i] + a2*this->M1[i]*this->M1[i];
        B = 2 * (b2*this->N1[i]*this->Z1[i] + a2*this->M1[i]*this->Y1[i]);
        C = a2*this->Y1[i]*this->Y1[i] + b2*this->Z1[i]*this->Z1[i] - ab2;
        T[i] = (-B + sqrt(B*B - 4*A*C)) / (2*A);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i]*this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i]*this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i]*this->N1[i];
    } 
    cout << "G_Cylinder_Ellipse的intersection" << endl;

    //destory_1d(A);
    //destory_1d(B);
    //destory_1d(C);
}

void G_Cylinder_Ellipse::normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz)
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
        data = sqrt(this->Y2[i]*this->Y2[i]/b4 + this->Z2[i]*this->Z2[i]/a4);
        Ny[i] = -(this->Y2[i]/b2) / data;
        Nz[i] = -(this->Z2[i]/a2) / data;
        Nx[i] = 0;

        this->Nx[i] = Nx[i];
        this->Ny[i] = Ny[i];
        this->Nz[i] = Nz[i];
    }    
    cout << "G_Cylinder_Ellipse的normal" << endl;
}

void G_Cylinder_Ellipse::h_slope(std::vector<double>& h_slope, std::vector<double>& Y2)
{
    int n = this->n;

    for (int i = 0; i < n; i++) 
    {
        h_slope[i] = 0;
        // Y2[i] = h0[i] + Y2[i];
    }
    cout << " G_Cylinder_Ellipse的h_slope" << endl;

}