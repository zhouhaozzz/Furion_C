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

        void Furion_reflect_Vector(double *cos_Alpha, double *L2, double *M2, double *N2, double *L1, double *M1, double *N1, double *Nx, double *Ny, double *Nz, double lambda, double m, double n0, double b, double *Z2, double *h_slope, double Cff);
        void matrixCross(double *L2, double *M2, double *N2, double *Nx, double *Ny, double *Nz, double *L1, double *M1, double *N1);  //There is no matrix cross function in the Eigen library, and it can only be implemented by custom
        
    };
}

#endif
