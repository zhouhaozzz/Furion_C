#pragma once

#ifndef FUR_FURION_HOLE_H_
#define FUR_FURION_HOLE_H_

#include "Furion.h"
//#include "w_oe.h"
#include "beam.h"

namespace Furion_NS
{
    class Furion_Hole
    {
    public:

        Furion_Hole();
        ~Furion_Hole();

        Beam* beam_out;

        void Furion_hole(Beam* beam_in, std::vector<std::vector<double> >& center_x, std::vector<std::vector<double> >& center_y, double r, int N);
    };
}

#endif







