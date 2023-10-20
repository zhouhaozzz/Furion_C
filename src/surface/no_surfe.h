#pragma once

#ifndef FUR_NO_SURFE_H_
#define FUR_NO_SURFE_H_

#include "Furion.h"

namespace Furion_NS
{
    class No_Surfe
    {
    public:
        double* meri_X = new double[Furion::n]; //Meridian coordinates
        double* sag_Y = new double[Furion::n]; //Sagittal direction coordinates
        double* V = new double[Furion::n]; //Height profile error value
        double* adress = new double[Furion::n];

        No_Surfe();
        ~No_Surfe();

        void value(double *Vq, double *Z, double *X, int n);
    };
}

#endif




