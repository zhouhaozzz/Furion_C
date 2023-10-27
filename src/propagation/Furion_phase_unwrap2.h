#pragma once

#ifndef FUR_FURION_PHASE_UNWRAP_H_
#define FUR_FURION_PHASE_UNWRAP_H_

#include "Furion.h"
#include <complex>

namespace Furion_NS
{
    class Furion_Phase_Unwrap2
    {
    private:
        /* data */
    public:
        Furion_Phase_Unwrap2();
        ~Furion_Phase_Unwrap2();

        void Furion_phase_unwrap2(double** phase_field, std::complex<double>** in_Field, int N);
        void angle(double** angle, std::complex<double>** field, int N);
        void unwrap(double** phase_new, double** phase, int N, int n);
    };
}

#endif

