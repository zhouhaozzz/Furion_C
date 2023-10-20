#pragma once

#ifndef FUR_FURION_ANGLE_VECTOR_H_
#define FUR_FURION_ANGLE_VECTOR_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Angle_Vector
    {
    private:
        /* data */
    public:
        Furion_Angle_Vector();
        ~Furion_Angle_Vector();

        void Furion_angle_vector(double *Phi, double *Psi, double *L, double *M, double *N);
    };
}

#endif

