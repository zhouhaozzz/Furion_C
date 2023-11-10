#pragma once

#ifndef FUR_SURFERILE_FROM_SHADOW_H_
#define FUR_SURFERILE_FROM_SHADOW_H_

#include "Furion.h"
#include "no_surfe.h"

namespace Furion_NS
{
    class Surfefile_From_Shadow : public No_Surfe
    {
    public:
        Surfefile_From_Shadow(const char* EXP_file);
        ~Surfefile_From_Shadow();

        size_t numRows;
        size_t numCols;

        void value(double* Vq, double* X, double* Y, int n) override;
        int CountLine(const char* filename);
        void meshgrid(vector<vector<double>>* X, vector<vector<double>>* Y, const vector<double>& x, const std::vector<double>& y);
    };
}

#endif




