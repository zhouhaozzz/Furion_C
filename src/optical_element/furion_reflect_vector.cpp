#include "Furion_Reflect_Vector.h"

using namespace Furion_NS;

Furion_Reflect_Vector::Furion_Reflect_Vector()
{

}

Furion_Reflect_Vector::~Furion_Reflect_Vector()
{

}

void Furion_Reflect_Vector::Furion_reflect_Vector(double *cos_Alpha, double *L2, double *M2, double *N2, double *L1, double *M1, double *N1, double *Nx, double *Ny, double *Nz, double lambda, double m, double n0, double b, double *Z2, double *h_slope, double Cff)
{
    int n = Furion::n;
    
    double *t_Base_x = new double[Furion::n];
    double *t_Base_y = new double[Furion::n];
    double *t_Base_z = new double[Furion::n];
    double *t_Base_model = new double[Furion::n];
    matrixCross(L2, M2, N2, Nx, Ny, Nz, L1, M1, N1);
    matrixCross(t_Base_x, t_Base_y, t_Base_z, L2, M2, N2, Nx, Ny, Nz);

    for (int i = 0; i < n; i++) 
    {
        t_Base_model[i] = sqrt(t_Base_x[i]*t_Base_x[i] + t_Base_y[i]*t_Base_y[i] + t_Base_z[i]*t_Base_z[i]);
        t_Base_x[i] = t_Base_x[i] / t_Base_model[i];
        t_Base_y[i] = t_Base_y[i] / t_Base_model[i];
        t_Base_z[i] = t_Base_z[i] / t_Base_model[i];
    }

    double *sin_Alpha = new double[Furion::n];
    // double *N_lambda = new double[Furion::n];
    double *sin_Beta = new double[Furion::n];
    // double *Beta = new double[Furion::n];
    double *cos_Beta = new double[Furion::n];

    for (int i = 0; i < n; i++) 
    {
        cos_Alpha[i] = fabs(L1[i]*Nx[i] + M1[i]*Ny[i] + N1[i]*Nz[i]);
        sin_Alpha[i] = sqrt(1 - cos_Alpha[i]*cos_Alpha[i]);
        // N_lambda[i] = n0*(1 + b*Z2[i]);
        sin_Beta[i] = sin_Alpha[i] - m*(n0*(1 + b*Z2[i]))*lambda - (1+Cff)*h_slope[i]*cos_Alpha[i]; 
        // Beta[i] = asin(sin_Beta[i]);
        cos_Beta[i] = sqrt(1-sin_Beta[i]*sin_Beta[i]);
        L2[i] = cos_Beta[i]*Nx[i] + sin_Beta[i]* t_Base_x[i];
        M2[i] = cos_Beta[i]*Ny[i] + sin_Beta[i]* t_Base_y[i];
        N2[i] = cos_Beta[i]*Nz[i] + sin_Beta[i]* t_Base_z[i];
    }            

    delete[] t_Base_x, t_Base_y, t_Base_z, t_Base_model;
    delete[] sin_Alpha, sin_Beta, cos_Beta;
}

void Furion_Reflect_Vector::matrixCross(double *L2, double *M2, double *N2, double *Nx, double *Ny, double *Nz, double *L1, double *M1, double *N1)  //There is no matrix cross function in the Eigen library, and it can only be implemented by custom
{
    int n = Furion::n;
    
    for (int i = 0; i < n; i++) 
    {
        L2[i] = N1[i]*Ny[i] - M1[i]*Nz[i];
        M2[i] = -N1[i]*Nx[i] + L1[i]*Nz[i];
        N2[i] = M1[i]*Nx[i] - L1[i]*Ny[i];
    }
}