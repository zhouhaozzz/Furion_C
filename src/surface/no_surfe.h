#pragma once

#ifndef FUR_NO_SURFE_H_
#define FUR_NO_SURFE_H_

#include "Furion.h"

namespace Furion_NS
{
    class No_Surfe
    {
    public:
        //double* meri_X = new double[Furion::n]; //Meridian coordinates
        //double* sag_Y = new double[Furion::n]; //Sagittal direction coordinates
        //double* V = new double[Furion::n]; //Height profile error value

        //vector<vector<double>>* meri_X = new std::vector<std::vector<double>>;
        //vector<vector<double>>* sag_Y = new std::vector<std::vector<double>>;
        //vector<vector<double>>* V = new std::vector<std::vector<double>>;

        double** meri_X;
        double** sag_Y;
        double** V;
        const char* adress;

        No_Surfe();
        ~No_Surfe();

        virtual void value(double* Vq, double* X, double* Y, int n);
    };
}

#endif




