#pragma once

#ifndef FUR_FURION_ROTY_H_
#define FUR_FURION_ROTY_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Roty
    {
    public:

        Furion_Roty();
        ~Furion_Roty();
        void furion_roty(double t, std::vector<double>& matrix);
    };
}

#endif

