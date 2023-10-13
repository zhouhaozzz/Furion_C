#pragma once

#ifndef FUR_G_FURION__PARABOID_COLLIMATION_MIRROR_H_
#define FUR_G_FURION__PARABOID_COLLIMATION_MIRROR_H_

#include "Furion.h"
#include "g_Furion_cyliner_parabolic_collimation_Mirror.h"
#include "g_cylinder_ellipse.h"

namespace Furion_NS
{
    class G_Furion_Paraboid_Collimation_Mirror : public G_Furion_Cyliner_Parabolic_Collimation_Mirror
    {
    public:
        G_Furion_Paraboid_Collimation_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Furion_Paraboid_Collimation_Mirror();

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);

        virtual void set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
    };
}

#endif



