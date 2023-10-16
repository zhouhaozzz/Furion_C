#pragma once

#ifndef FUR_G_PARABOID_FOCUS_H_
#define FUR_G_PARABOID_FOCUS_H_

#include "Furion.h"
#include "g_cyliner_parabolic_focus.h"

namespace Furion_NS
{

    class G_Paraboid_Focus : public G_Cyliner_Parabolic_Focus       //The tracking phase converts to Angle
    {
    public:
        G_Paraboid_Focus(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Paraboid_Focus();

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating) override;

        void intersection(double* T) override;
        //void source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N) override;
        void normal(double *Nx, double *Ny, double *Nz) override;
        //void h_slope(double *h_slope, double *Y2) override;
    };
}

#endif



