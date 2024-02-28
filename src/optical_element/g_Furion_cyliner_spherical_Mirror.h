#pragma once

#ifndef FUR_G_FURION_CYLINER_SPHERICAL_MIRROR_H_
#define FUR_G_FURION_CYLINER_SPHERICAL_MIRROR_H_

#include "Furion.h"
#include "g_oe.h"

namespace Furion_NS
{
    class G_Furion_Cyliner_Spherical_Mirror : public G_Oe
    {
    public:

        G_Furion_Cyliner_Spherical_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating);
        ~G_Furion_Cyliner_Spherical_Mirror();

        double r;

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating);
        void intersection(std::vector<double>& T) override;
        void normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz) override;
    };
}

#endif

