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

        void Furion_angle_vector(std::vector<double>& Phi, std::vector<double>& Psi, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N, int n);
        void Furion_angle_vector(std::vector<std::vector<double> >& Phi, std::vector<std::vector<double> >& Psi, std::vector<std::vector<double> >& L, std::vector<std::vector<double> >& M, std::vector<std::vector<double> >& N, int n1, int n2);
    };
}

#endif

