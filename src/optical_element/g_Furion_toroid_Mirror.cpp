#include "g_Furion_toroid_Mirror.h"

using namespace Furion_NS;

G_Furion_Toroid_Mirror::G_Furion_Toroid_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double R1, double R2, double rho1, double rho2, Grating* grating)
    : G_Oe(beam_in, ds, di, chi, theta, surface, grating)
{
    cout << "初始化G_Furion_Toroid_Mirror" << endl;
    this->R = 2 / std::sin(theta) / (1 / R1 + 1 / R2);
    this->rho = 2 * std::sin(theta) / (1 / rho1 + 1 / rho2);
}

G_Furion_Toroid_Mirror::~G_Furion_Toroid_Mirror()
{
    //delete ct;
}

void G_Furion_Toroid_Mirror::run(G_Beam* beam_in, double ds, double di, double chi, double theta)
{
    cout << "G_Furion_Toroid_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void G_Furion_Toroid_Mirror::intersection(std::vector<double>& T)
{
    int n = this->n;
    double epsilon = 1.0e-11;
    double error_Final = 0.0;
    double t = 0.0;
    //std::vector<double> t_Min(n);
    //std::vector<double> t_Max(n);
    double t_Min, t_Max;

    fb = Furion_Bisection();

    for (int i = 0; i < n; i++)
    {
        t_Min = -(this->X1[i] * this->L1[i] + this->Y1[i] * this->M1[i] - this->R * this->M1[i]);
        t_Max = -this->Y1[i] / this->M1[i];
        fb.Furion_bisection(this->X2[i], this->Y2[i], this->Z2[i], error_Final, t, t_Min, t_Max, this->X1[i], this->Y1[i], this->Z1[i], this->L1[i], this->M1[i], this->N1[i], epsilon, this->R, this->rho, n);
    }



    cout << "G_Furion_Toroid_Mirror的intersection" << endl;

    //destory_1d(A);
    //destory_1d(B);
    //destory_1d(C);
}

void G_Furion_Toroid_Mirror::normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz)
{
    int n = this->n;

    //std::vector<double> Nx0(n);
    //std::vector<double> Ny0(n);
    //std::vector<double> Nz0(n);
    //std::vector<double> N_mod(n);

    double Nx0, Ny0, Nz0, N_mod;
    
    double cache = this->R - this->rho;
    double cache1, cache2;
    for (int i = 0; i < n; i++) 
    {
        cache1 = this->Y2[i] - this->R;
        cache2 = cache1 * cache1;
        Nx0 = this->X2[i];
        Ny0 = cache1 - (cache * cache1) / std::sqrt((this->Z2[i] * this->Z2[i]) + cache2);
        Nz0 = this->Z2[i] - cache * this->Z2[i] / std::sqrt(cache2 + this->Z2[i] * this->Z2[i]);
        N_mod = std::sqrt(Nx0 * Nx0 + Ny0 * Ny0 + Nz0 * Nz0);
        
        Nx[i] = -Nx0 / N_mod;
        Ny[i] = -Ny0 / N_mod;
        Nz[i] = -Nz0 / N_mod;
    }    

    cout << "G_Furion_Toroid_Mirror的normal" << endl;
}