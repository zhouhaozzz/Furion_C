#include "Furion_Reflect_Vector.h"

using namespace Furion_NS;

Furion_Reflect_Vector::Furion_Reflect_Vector()
{

}

Furion_Reflect_Vector::~Furion_Reflect_Vector()
{

}

void Furion_Reflect_Vector::Furion_reflect_Vector(std::vector<double>& cos_Alpha, std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& L1, std::vector<double>& M1, std::vector<double>& N1, std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz, double lambda, double m, double n0, double b, std::vector<double>& Z2, std::vector<double>& h_slope, double Cff, int n)
{
    //int n = Furion::n;
    
    //double *t_Base_x = new double[n];
    //double *t_Base_y = new double[n];
    //double *t_Base_z = new double[n];
    //double *t_Base_model = new double[n];
    //std::vector<double> t_Base_x = std::vector<double>(n);
    //std::vector<double> t_Base_y = std::vector<double>(n);
    //std::vector<double> t_Base_z = std::vector<double>(n);
    //std::vector<double> t_Base_model = std::vector<double>(n);

    //(L2, M2, N2,  Nx, Ny, Nz,  L1, M1, N1, int n)  //There is no matrix cross function in the Eigen library, and it can only be implemented by custom

    double t_Base_model, t_Base_x, t_Base_y, t_Base_z;
    double x1, y1, z1;
    double sin_Alpha, cos_Beta, sin_Beta;

    for (int i = 0; i < n; i++)
    {
        x1 =  N1[i] * Ny[i] - M1[i] * Nz[i];             //Nx,y,z * L1,2,3
        y1 = -N1[i] * Nx[i] + L1[i] * Nz[i];
        z1 =  M1[i] * Nx[i] - L1[i] * Ny[i];

        t_Base_x =  Nz[i] * y1 - Ny[i] * z1;       
        t_Base_y = -Nz[i] * x1 + Nx[i] * z1;
        t_Base_z =  Ny[i] * x1 - Nx[i] * y1;
        
        t_Base_model = sqrt(t_Base_x * t_Base_x + t_Base_y * t_Base_y + t_Base_z * t_Base_z);
        t_Base_x = t_Base_x / t_Base_model;
        t_Base_y = t_Base_y / t_Base_model;
        t_Base_z = t_Base_z / t_Base_model;

        cos_Alpha[i] = abs(L1[i] * Nx[i] + M1[i] * Ny[i] + N1[i] * Nz[i]);
        sin_Alpha = sqrt(1 - cos_Alpha[i] * cos_Alpha[i]);
        // N_lambda[i] = n0*(1 + b*Z2[i]);
        sin_Beta = sin_Alpha - m * (n0 * (1 + b * Z2[i])) * lambda - (1 + Cff) * h_slope[i] * cos_Alpha[i];
        //Beta[i] = asin(sin_Beta[i]);
        cos_Beta = sqrt(1 - sin_Beta * sin_Beta);
        L2[i] = cos_Beta * Nx[i] + sin_Beta * t_Base_x;
        M2[i] = cos_Beta * Ny[i] + sin_Beta * t_Base_y;
        N2[i] = cos_Beta * Nz[i] + sin_Beta * t_Base_z;
    }

    //matrixCross(L2, M2, N2, Nx, Ny, Nz, L1, M1, N1, n);
    //matrixCross(t_Base_x, t_Base_y, t_Base_z, L2, M2, N2, Nx, Ny, Nz, n);

    //for (int i = 0; i < n; i++) 
    //{
    //    t_Base_model[i] = sqrt(t_Base_x[i]*t_Base_x[i] + t_Base_y[i]*t_Base_y[i] + t_Base_z[i]*t_Base_z[i]);
    //    t_Base_x[i] = t_Base_x[i] / t_Base_model[i];
    //    t_Base_y[i] = t_Base_y[i] / t_Base_model[i];
    //    t_Base_z[i] = t_Base_z[i] / t_Base_model[i];
    //}

    //double *sin_Alpha = new double[n];
    // double *N_lambda = new double[Furion::n];
    //double *sin_Beta = new double[n];
    // double *Beta = new double[Furion::n];
    //double *cos_Beta = new double[n];
    // 
    //std::vector<double> sin_Alpha = std::vector<double>(n);
    //std::vector<double> sin_Beta = std::vector<double>(n);
    //std::vector<double> cos_Beta = std::vector<double>(n);

    //double sin_Alpha, cos_Beta, sin_Beta;

    //for (int i = 0; i < n; i++) 
    //{
    //    cos_Alpha[i] = abs(L1[i] * Nx[i] + M1[i] * Ny[i] + N1[i] * Nz[i]);
    //    sin_Alpha = sqrt(1 - cos_Alpha[i]*cos_Alpha[i]);
    //    // N_lambda[i] = n0*(1 + b*Z2[i]);
    //    sin_Beta = sin_Alpha - m*(n0*(1 + b*Z2[i]))*lambda - (1+Cff)*h_slope[i]*cos_Alpha[i]; 
    //     //Beta[i] = asin(sin_Beta[i]);
    //    cos_Beta = sqrt(1-sin_Beta*sin_Beta);
    //    L2[i] = cos_Beta*Nx[i] + sin_Beta* t_Base_x[i];
    //    M2[i] = cos_Beta*Ny[i] + sin_Beta* t_Base_y[i];
    //    N2[i] = cos_Beta*Nz[i] + sin_Beta* t_Base_z[i];
    //}            

    //destory_1d(t_Base_x);
    //destory_1d(t_Base_y);
    //destory_1d(t_Base_z);
    //destory_1d(t_Base_model);
    //destory_1d(sin_Alpha);
    //destory_1d(sin_Beta);
    //destory_1d(cos_Beta);
}

void Furion_Reflect_Vector::matrixCross(std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz, std::vector<double>& L1, std::vector<double>& M1, std::vector<double>& N1, int n)  //There is no matrix cross function in the Eigen library, and it can only be implemented by custom
{
    //int n = Furion::n;
    
    for (int i = 0; i < n; i++) 
    {
        L2[i] = N1[i]*Ny[i] - M1[i]*Nz[i];
        M2[i] = -N1[i]*Nx[i] + L1[i]*Nz[i];
        N2[i] = M1[i]*Nx[i] - L1[i]*Ny[i];
    }
}