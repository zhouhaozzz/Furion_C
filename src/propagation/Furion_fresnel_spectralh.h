#pragma once

#ifndef FUR_FURION_FRESNEL_SPECTRALH_H_
#define FUR_FURION_FRESNEL_SPECTRALH_H_

#include "Furion.h"
#include <complex>
#include <fftw3.h>

namespace Furion_NS
{
    class Furion_Fresnel_Spectralh
    {
    private:
        /* data */
    public:
        Furion_Fresnel_Spectralh();
        ~Furion_Fresnel_Spectralh();

        void Furion_fresnel_spectralh(int N, double deltax_Fre, std::complex<double>** in_Field, double wave_Lambda, double distance);
        void FFTW2(std::complex<double>** output, std::complex<double>** in_Field, int N);
        void iFFTW2(std::complex<double>** output, std::complex<double>** in_Field, int N);
        void FFTshift(std::complex<double>** output, std::complex<double>** field, int N);
        void iFFTshift(std::complex<double>** output, std::complex<double>** field, int N);

    };
}

#endif

