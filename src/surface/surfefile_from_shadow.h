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

        void value(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, int n) override;
        int CountLine(const char* filename);
        void meshgrid(std::vector<std::vector<double>>& X, std::vector<std::vector<double>>& Y, const std::vector<double>& x, const std::vector<double>& y);
    };
}

#endif




