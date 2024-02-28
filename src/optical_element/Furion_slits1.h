#pragma once

#ifndef FUR_FURION_SLITSS_H_
#define FUR_FURION_SLITSS_H_

#include "Furion.h"
#include "beam.h"

namespace Furion_NS
{
    class Furion_Slits1
    {
    public:

        Furion_Slits1();  
        ~Furion_Slits1();

        Beam* beam_out;

        void Furion_slits1(Beam* beam_in, double center_x, double center_y, double width, double height, int N);
    };
}

#endif
