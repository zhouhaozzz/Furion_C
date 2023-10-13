#pragma once

#ifndef FUR_G_FURION_HOLE_H_
#define FUR_G_FURION_HOLE_H_

#include "Furion.h"
#include "g_beam.h"
//#include "g_oe.h"

namespace Furion_NS
{
    class G_Furion_Hole
    {
    public:
        G_Furion_Hole(G_Beam* beam_in, double center_x, double center_y, double r);
        ~G_Furion_Hole();

        G_Beam* beam_out;
        //void run(double *Nx, double *Ny, double *Nz);
    };
}

#endif

