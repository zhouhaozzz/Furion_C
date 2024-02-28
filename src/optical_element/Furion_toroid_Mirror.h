#pragma once

#ifndef FUR_FURION_TOROID_MIRROR_H_
#define FUR_FURION_TOROID_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"

namespace Furion_NS
{
    class Furion_Toroid_Mirror : public W_Oe
    {
    public:

        Furion_Toroid_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating);
        ~Furion_Toroid_Mirror();

        double R1;
        double R2;
        double rho1;
        double rho2;

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
    };
}

#endif