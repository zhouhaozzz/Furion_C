#pragma once

#ifndef FUR_FURION_ROTX_H_
#define FUR_FURION_ROTX_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Rotx
    {
    public:

        Furion_Rotx();
        ~Furion_Rotx();
        void furion_rotx(double t, std::vector<double>& matrix);
    };
}

#endif

