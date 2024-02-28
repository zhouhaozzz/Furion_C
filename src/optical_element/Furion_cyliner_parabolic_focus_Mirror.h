#pragma once

#ifndef FUR_FURION_CYLINER_PARABOLIC_FOCUS_MIRROR_H_
#define FUR_FURION_CYLINER_PARABOLIC_FOCUS_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"

namespace Furion_NS
{
    class Furion_Cyliner_Parabolic_Focus_Mirror : public W_Oe
    {
    public:

        Furion_Cyliner_Parabolic_Focus_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating);
        ~Furion_Cyliner_Parabolic_Focus_Mirror();

        double r;
        double r2;

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
    };
}

#endif







