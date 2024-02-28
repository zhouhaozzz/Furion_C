#pragma once

#ifndef FUR_FURION_PLANE_MIRROR_H_
#define FUR_FURION_PLANE_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"

namespace Furion_NS
{
    class Furion_Plane_Mirror : public W_Oe
    {
    public: 

        Furion_Plane_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        ~Furion_Plane_Mirror();

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        std::string tracing() override;
        void create_w_beam(std::vector<double>& s_phase) override;
    };

}

#endif



