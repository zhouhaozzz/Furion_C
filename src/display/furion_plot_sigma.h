#pragma once

#ifndef FUR_FURION_PLOT_SIGMA_H_
#define FUR_FURION_PLOT_SIGMA_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Plot_Sigma
    {
    public:

        Furion_Plot_Sigma();
        ~Furion_Plot_Sigma();

        void Furion_plot_sigma(std::vector<double>& X, std::vector<double>& Y, std::vector<double>& Phi, std::vector<double>& Psi, int rank1, int n);
        string inttoStr(int s);
    };
}

#endif



