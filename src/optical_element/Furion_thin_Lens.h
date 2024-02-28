#pragma once

#ifndef FUR_FURION_THIN_LENS_H_
#define FUR_FURION_THIN_LENS_H_

#include "Furion.h"

namespace Furion_NS
{
    class Furion_Thin_Lens
    {
    private:
        /* data */
    public:
        Furion_Thin_Lens();
        ~Furion_Thin_Lens();

        void Furion_thin_Lens(std::vector<std::vector<std::complex<double>> >& out_Field, std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& in_Field, double wavelength, double focus_length, int flag, int n);
    };
}

#endif

