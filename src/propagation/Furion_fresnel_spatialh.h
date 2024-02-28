#pragma once

#ifndef FUR_FURION_FRESNEL_SPATIALH_H_
#define FUR_FURION_FRESNEL_SPATIALH_H_

#include "Furion.h"
#include <complex>


namespace Furion_NS
{
    class Furion_Fresnel_Spatialh
    {
    private:
        /* data */
    public:
        Furion_Fresnel_Spatialh();
        ~Furion_Fresnel_Spatialh();

        void Furion_fresnel_spatialh(std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& in_Field, double wave_Lambda, double distance, int n);
        void iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field1, std::vector<std::vector<std::complex<double>> >& field2, int N);
        void iFFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, double data, int N);
    };
}

#endif

