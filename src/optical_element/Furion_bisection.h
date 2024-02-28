#pragma once

#ifndef FUR_FURION_BISECTION_H_
#define FUR_FURION_BISECTION_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Bisection
    {
    public:

        Furion_Bisection();
        ~Furion_Bisection();

        void Furion_bisection(double& x1, double& y1, double& z1, double& error_Final, double& t_Final, double t_Min, double t_Max, double x0, double y0, double z0, double l0, double m0, double n0, double epsilon, double R, double rho, int n);
    };
}

#endif
