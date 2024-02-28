#pragma once

#ifndef FUR_FURION_ANGLE_TO_ANGLE_H_
#define FUR_FURION_ANGLE_TO_ANGLE_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Angle_To_Angle
    {
    private:
        /* data */
    public:
        Furion_Angle_To_Angle();
        ~Furion_Angle_To_Angle();

        void Furion_angle_To_angle(std::vector<double>& X1, std::vector<double>& Y1, std::vector<double>& PHI, std::vector<double>& PSI, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& Phi, std::vector<double>& Psi, int n);
        void Furion_angle_To_angle(std::vector<std::vector<double> >& X1, std::vector<std::vector<double> >& Y1, std::vector<std::vector<double> >& PHI, std::vector<std::vector<double> >& PSI, std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<double> >& Phi, std::vector<std::vector<double> >& Psi, int n1, int n2);
    };
}

#endif

