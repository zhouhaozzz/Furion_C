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

        void Furion_fresnel_spatialh(double** X, double** Y, std::complex<double>** field, double wavelength, int n);
    };
}

#endif

