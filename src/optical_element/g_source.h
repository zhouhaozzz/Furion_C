#pragma once

#ifndef FUR_G_SOURCE_H_
#define FUR_G_SOURCE_H_

#include "Furion.h"
#include "g_beam.h"

namespace Furion_NS
{
    class G_Source
    {
    private:
        /* data */
    public:
        class G_Beam beam_out;
        double lambda;          //wave length
        int n;
        //double* XX;
        //double* YY;
        //double* psi;
        //double* phi;
        std::vector<double> XX;
        std::vector<double> YY;
        std::vector<double> psi;
        std::vector<double> phi;

        G_Source(double sigma_beamsize, double sigma_divergence, int n, double lambda, int rank1);
        ~G_Source();

        void normrnd(std::vector<double>& resultArray, double mu, double sigma_beamsize, int n, int n1, int rank1);
    };
}

#endif

