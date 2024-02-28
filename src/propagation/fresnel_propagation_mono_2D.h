#pragma once

#ifndef FUR_FRENSNEL_PROPAGATION_MOMO_DD_H_
#define FUR_FRENSNEL_PROPAGATION_MOMO_DD_H_

#include "Furion.h"
#include <complex>
#include <fftw3.h>

namespace Furion_NS
{
    class Fresnel_Propagation_Mono_2D
    {
    private:
        /* data */
    public:
        Fresnel_Propagation_Mono_2D();
        ~Fresnel_Propagation_Mono_2D();

        void fresnel_propagation_mono_2D(std::vector<std::vector<std::complex<double>> >& Di, double L1, double L2, double lambda, double z);
        void iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field1, std::vector<std::vector<std::complex<double>> >& field2, int N);
    };
}

#endif

