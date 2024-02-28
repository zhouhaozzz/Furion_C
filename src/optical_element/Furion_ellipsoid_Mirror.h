#pragma once

#ifndef FUR_FURION_ELLIPSOID_MIRROR_H_
#define FUR_FURION_ELLIPSOID_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"

namespace Furion_NS
{
    class Furion_Ellipsoid_Mirror : public W_Oe
    {
    public:

        Furion_Ellipsoid_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~Furion_Ellipsoid_Mirror();

        double r;
        double r1;
        double r2;

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
    };
}

#endif







