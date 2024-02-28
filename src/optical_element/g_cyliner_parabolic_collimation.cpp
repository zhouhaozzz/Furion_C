#include "g_cyliner_parabolic_collimation.h"

using namespace Furion_NS;

G_Cyliner_Parabolic_Collimation::G_Cyliner_Parabolic_Collimation(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)//, center(beam_in, ds, di, chi, theta, surface, r1, r2, grating)
{
    this->r1 = r1;
    this->p = r1 * (1 - cos(2 * theta));
    cout << "G_Cyliner_Parabolic_Collimation 初始化" << endl;
}

G_Cyliner_Parabolic_Collimation::~G_Cyliner_Parabolic_Collimation()
{
    /*destory_1d(this->T);
    destory_1d(this->Nx);
    destory_1d(this->Ny);
    destory_1d(this->Nz);*/
    cout << "G_Cyliner_Parabolic_Collimation的析构" << endl;
}

void G_Cyliner_Parabolic_Collimation::run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating)
{
    cout << "G_Cyliner_Parabolic_Collimation的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Cyliner_Parabolic_Collimation::source_to_oe(std::vector<double>& X, std::vector<double>& Y, double ds, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N)
{
    int n = this->n;

    //double* OS = new double[9];
    //double* OS_0 = new double[9];
    //double* OS_1 = new double[9];
    std::vector<double> OS(9);
    std::vector<double> OS_0(9);
    std::vector<double> OS_1(9);
    f_rx.furion_rotx(2*this->theta, OS_0);
    f_rz.furion_rotz(this->chi, OS_1);

    //double* X0 = new double[n];
    //double* Y0 = new double[n];
    //double* Z0 = new double[n];
    //double* Z = new double[1];
    //std::vector<double> X0(n);
    //std::vector<double> Y0(n);
    //std::vector<double> Z0(n);
    std::vector<double> Z = std::vector<double>(1);
    Z[0] = this->r1 - ds;

    double x0, y0, z0, dx;
    dx = this->p / 2;
    matrixMulti33(OS, OS_0, OS_1);
    for (int i = 0; i < n; i++)
    {
        x0 = OS_1[0] * X[i] + OS_1[1] * Y[i] + OS_1[2] * Z[0];
        y0 = OS_1[3] * X[i] + OS_1[4] * Y[i] + OS_1[5] * Z[0];
        z0 = OS_1[6] * X[i] + OS_1[7] * Y[i] + OS_1[8] * Z[0];

        this->X1[i] = OS_0[0] * x0 + OS_0[1] * y0 + OS_0[2] * z0;
        this->Y1[i] = OS_0[3] * x0 + OS_0[4] * y0 + OS_0[5] * z0;
        this->Z1[i] = OS_0[6] * x0 + OS_0[7] * y0 + OS_0[8] * z0 + dx;

        this->L1[i] = OS[0] * L[i] + OS[1] * M[i] + OS[2] * N[i];
        this->M1[i] = OS[3] * L[i] + OS[4] * M[i] + OS[5] * N[i];
        this->N1[i] = OS[6] * L[i] + OS[7] * M[i] + OS[8] * N[i];
    }

    //matrixMulti0(X0, Y0, Z0, OS_1, X, Y, Z, n);
    //matrixMulti(this->X1, this->Y1, this->Z1, OS_0, X0, Y0, Z0, this->p / 2, n);

    //matrixMulti33(OS, OS_0, OS_1);
    //matrixMulti(this->L1, this->M1, this->N1, OS, L, M, N, 0, n);
    
    //destory_1d(X0);
    //destory_1d(Y0);
    //destory_1d(Z0);
    //destory_1d(Z);
    //destory_1d(OS);
    //destory_1d(OS_0);
    //destory_1d(OS_1);
    cout << "G_Cyliner_Parabolic_Collimation的source_to_oe" << endl;
}


void G_Cyliner_Parabolic_Collimation::intersection(std::vector<double>& T)
{
    int n = this->n;

    //double* A = new double[n];
    //double* B = new double[n];
    //double* C = new double[n];
    //std::vector<double> A(n);
    //std::vector<double> B(n);
    //std::vector<double> C(n);
    double A, B, C;

    for (int i = 0; i < n; i++)
    {
        A = this->M1[i] * this->M1[i];
        B = 2 * (-this->N1[i] * this->p + this->M1[i] * this->Y1[i]);
        B = this->Y1[i] * this->Y1[i] - 2 * this->p * this->Z1[i];
        T[i] = (-B + sqrt(B * B - 4 * A * B)) / (2 * A);
        this->T[i] = T[i];

        this->X2[i] = this->X1[i] + T[i] * this->L1[i];
        this->Y2[i] = this->Y1[i] + T[i] * this->M1[i];
        this->Z2[i] = this->Z1[i] + T[i] * this->N1[i];
    }
    cout << "G_Cyliner_Parabolic_Collimation的intersection" << endl;

    //destory_1d(A);
    //destory_1d(B);
    //destory_1d(C);
}

void G_Cyliner_Parabolic_Collimation::normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz)
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

void G_Cyliner_Parabolic_Collimation::h_slope(std::vector<double>& h_slope, std::vector<double>& Y2)
{
    int n = this->n;

    for (int i = 0; i < n; i++)
    {
        h_slope[i] = 0;
        // Y2[i] = h0[i] + Y2[i];
    }
    cout << " G_Cyliner_Parabolic_Collimation的h_slope" << endl;

}