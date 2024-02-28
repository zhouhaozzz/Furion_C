#pragma once

#ifndef FUR_G_FURION_SLITS_H_
#define FUR_G_FURION_SLITS_H_

#include "Furion.h"
#include "g_beam.h"
//#include "g_oe.h"

namespace Furion_NS
{
    class G_Furion_Slits
    {
    public:
        G_Furion_Slits(G_Beam* beam_in, double center_x, double center_y, double width, double height);
        ~G_Furion_Slits();

        G_Beam* beam_out;
        //void run(double *Nx, double *Ny, double *Nz);
    };
}

#endif

