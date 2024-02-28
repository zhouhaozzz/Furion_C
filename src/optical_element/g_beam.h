#pragma once

#ifndef FUR_G_BEAM_H_
#define FUR_G_BEAM_H_

#include "Furion.h"
#include "Furion_Plot_Sigma.h"

namespace Furion_NS
{
    class G_Beam
    {
    public:

        double lambda;          //wave length
        int n;
        //double* XX = new double[Furion::n];
        //double* YY = new double[Furion::n];
        //double* psi = new double[Furion::n];
        //double* phi = new double[Furion::n];
        std::vector<double> XX;
        std::vector<double> YY;
        std::vector<double> psi;
        std::vector<double> phi;


        G_Beam(std::vector<double>& XX, std::vector<double>& YY, std::vector<double>& phi, std::vector<double>& psi, double lambda, int n);
        ~G_Beam();

        class Furion_Plot_Sigma f_p_s;

        G_Beam translate(double distance);
        void plot_sigma(double distance, int rank1);
        //void creat_Furion_plot_sigma(int rank1);
    };
}

#endif

