#pragma once

#ifndef FUR_BEAM_H_
#define FUR_BEAM_H_

#include "Furion.h"
#include "Furion_fresnel_spectralh.h"
//#include <boost/math/interpolators/barycentric_rational.hpp>
//#include <boost/math/interpolators/>

namespace Furion_NS
{
    class Beam
    {
    public:
        double wavelength;
        int N;

        double** X;
        double** Y;
        double** phase_field;
        std::complex<double>** field;
        double* XX;
        double* YY;

        Beam(double** X, double** Y, std::complex<double>** field, double wavelength, int N);
        ~Beam();

        void destory();


        class Furion_Fresnel_Spectralh f_f_s;

        Beam translate(double distance);
        void plot_sigma(double distance, int rank1);
        //void creat_Furion_plot_sigma(int rank1);
    };
    double Max(double* X, int n);
    double Min(double* X, int n);
}

#endif

