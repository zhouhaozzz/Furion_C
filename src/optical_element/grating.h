#pragma once

#ifndef FUR_GRATING_H_
#define FUR_GRATING_H_

#include "Furion.h"

namespace Furion_NS
{
    class Grating
    {
    private:
        /* data */
    public:
        double n0;          //Grating linear density
        double b;           //Variable line distance parameter
        double m;           //Diffraction order
        double lambda_G;    //Grating wavelength

        Grating(double n0, double b, double m, double lambda_G);
        ~Grating();
    };
}

#endif


