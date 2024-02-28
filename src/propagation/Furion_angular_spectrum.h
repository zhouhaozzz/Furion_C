#pragma once

#ifndef FUR_FURION_ANGULAR_SPECTRALH_H_
#define FUR_FURION_ANGULAR_SPECTRALH_H_

#include "Furion.h"
#include <complex>
#include <fftw3.h>

namespace Furion_NS
{
    class Furion_Angular_Spectralh
    {
    private:
        /* data */
    public:
        Furion_Angular_Spectralh();
        ~Furion_Angular_Spectralh();

        void Furion_angular_spectralh(int N, double deltax_Fre, std::vector<std::vector<std::complex<double>> >& in_Field, double wave_Lambda, double distance);
    };
}

#endif

