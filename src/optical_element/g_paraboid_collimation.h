#pragma once

#ifndef FUR_G_PARABOID_COLLIMATION_H_
#define FUR_G_PARABOID_COLLIMATION_H_

#include "Furion.h"
#include "g_cyliner_parabolic_collimation.h"

namespace Furion_NS
{

    class G_Paraboid_Collimation : public G_Cyliner_Parabolic_Collimation       //The tracking phase converts to Angle
    {
    public:
        G_Paraboid_Collimation(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating);
        ~G_Paraboid_Collimation();

        //void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating);

        void intersection(std::vector<double>& T) override;
        //void source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N) override;
        void normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz) override;
        //void h_slope(double *h_slope, double *Y2) override;
    };
}

#endif



