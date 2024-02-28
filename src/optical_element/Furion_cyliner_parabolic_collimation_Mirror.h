#pragma once

#ifndef FUR_FURION_CYLINER_PARABOLIC_COLLIMATION_MIRROR_H_
#define FUR_FURION_CYLINER_PARABOLIC_COLLIMATION_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"
#include "no_surfe.h"

namespace Furion_NS
{
    class Furion_Cyliner_Parabolic_Collimation_Mirror : public W_Oe
    {
    public:

        Furion_Cyliner_Parabolic_Collimation_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating);
        ~Furion_Cyliner_Parabolic_Collimation_Mirror();

        double r;       //Radius of curvature of cylindrical mirror
        double r1;

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
    };
}

#endif