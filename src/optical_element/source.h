#pragma once

#ifndef FUR_SOURCE_H_
#define FUR_SOURCE_H_

#include "Furion.h"
#include "beam.h"

namespace Furion_NS
{
    class Source
    {
    private:
        /* data */
    public:
        double wavelength;
        double L;
        int N;
        double sigma;

        double** X;
        double** Y;
        std::complex<double>** field;
        double** XX;
        double** YY;

        Source(double L, int N, double sigma, double wavelength);
        ~Source();

        Beam* beam_out();
        void linspace(double* x, double min, double max, int N);
    };
}

#endif

