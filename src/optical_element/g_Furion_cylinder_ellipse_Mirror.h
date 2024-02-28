#pragma once

#ifndef FUR_G_FURION_CYLINDER_ELLIPSE_MIRROR_H_
#define FUR_G_FURION_CYLINDER_ELLIPSE_MIRROR_H_

#include "Furion.h"
#include "g_oe.h"
#include "g_cylinder_ellipse.h"

namespace Furion_NS
{
    class G_Furion_Cylinder_Ellipse_Mirror : public G_Oe
    {
    public:

        G_Furion_Cylinder_Ellipse_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Furion_Cylinder_Ellipse_Mirror();

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);

        G_Cylinder_Ellipse* center;

        void intersection(std::vector<double>& T) override;
        void normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz) override;
        void cneter_to_oe_p(std::vector<double>& X2, std::vector<double>& Y2, std::vector<double>& Z2, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& Z);
        void cneter_to_oe_v(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N);
        void matrixMulti_GFCEM(std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& matrix, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N, double dx, int n);
        virtual void set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);

    };
}

#endif



