#pragma once

#ifndef FUR_FURION_REFLECT_VECTOR_H_
#define FUR_FURION_REFLECT_VECTOR_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Reflect_Vector
    {
    public:

        Furion_Reflect_Vector();
        ~Furion_Reflect_Vector();

        void Furion_reflect_Vector(std::vector<double>& cos_Alpha, std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& L1, std::vector<double>& M1, std::vector<double>& N1, std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz, double lambda, double m, double n0, double b, std::vector<double>& Z2, std::vector<double>& h_slope, double Cff, int n);
        void matrixCross(std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz, std::vector<double>& L1, std::vector<double>& M1, std::vector<double>& N1, int n);  //There is no matrix cross function in the Eigen library, and it can only be implemented by custom
        
    };
}

#endif
