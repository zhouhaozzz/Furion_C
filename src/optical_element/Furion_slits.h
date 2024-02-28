#pragma once

#ifndef FUR_FURION_SLITS_H_
#define FUR_FURION_SLITS_H_

#include "Furion.h"
#include "beam.h"

namespace Furion_NS
{
    class Furion_Slits
    {
    public:

        Furion_Slits();  
        ~Furion_Slits();

        Beam* beam_out;

        void Furion_slits(Beam* beam_in, double center_x, double center_y, double width, double height, int N);
    };
}

#endif
