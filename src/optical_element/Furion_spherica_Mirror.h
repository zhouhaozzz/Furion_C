#pragma once

#ifndef FUR_FURION_SPHERICA_MIRROR_H_
#define FUR_FURION_SPHERICA_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"

namespace Furion_NS
{
    class Furion_Spherica_Mirror : public W_Oe
    {
    public:

        Furion_Spherica_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r, Grating* grating);
        ~Furion_Spherica_Mirror();

        double r;      

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
    };
}

#endif