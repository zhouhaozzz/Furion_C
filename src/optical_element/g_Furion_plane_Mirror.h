#pragma once

#ifndef FUR_G_FURION_PLANE_MIRROR_H_
#define FUR_G_FURION_PLANE_MIRROR_H_

#include "Furion.h"
#include "g_oe.h"

namespace Furion_NS
{
    class G_Furion_Plane_Mirror : public G_Oe
    {
    public: 

        G_Furion_Plane_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Furion_Plane_Mirror();

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
    };
}

#endif



