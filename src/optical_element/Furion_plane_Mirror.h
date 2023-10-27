#pragma once

#ifndef FUR_FURION__PLANE_MIRROR_H_
#define FUR_FURION__PLANE_MIRROR_H_

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
        void tracing() override;
        void create_w_beam(double* s_phase) override;
    };

    void reshape(double** output, double* input, int x, int y);
}

#endif



