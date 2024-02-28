#pragma once

#ifndef FUR_FURION_PHASE_UNWRAPP_H_
#define FUR_FURION_PHASE_UNWRAPP_H_

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

        void Furion_phase_unwrap2(std::vector<std::vector<double> >& phase_field, std::vector<std::vector<std::complex<double>> >& in_Field, int N);
        void angle(std::vector<std::vector<double> >& angle, std::vector<std::vector<std::complex<double>> >& field, int N);
        void unwrap(std::vector<std::vector<double> >& phase_new, std::vector<std::vector<double> >& phase, int N, int n);
    };
}

#endif

