#pragma once

#ifndef FUR_G_FURION_PARABOID_FOCUS_MIRROR_H_
#define FUR_G_FURION_PARABOID_FOCUS_MIRROR_H_

#include "Furion.h"
#include "g_Furion_cyliner_parabolic_focus_Mirror.h"

namespace Furion_NS
{
    class G_Furion_Paraboid_Focus_Mirror : public G_Furion_Cyliner_Parabolic_Focus_Mirror
    {
    public: 

        G_Furion_Paraboid_Focus_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating);
        ~G_Furion_Paraboid_Focus_Mirror();

        void set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating) override;
        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r2, Grating* grating);
    };
}

#endif



