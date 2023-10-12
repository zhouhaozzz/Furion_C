#pragma once

#ifndef FUR_G_FURION__CYLINDER_ELLIPSE_MIRROR_H_
#define FUR_G_FURION__CYLINDER_ELLIPSE_MIRROR_H_

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

        void intersection(double* T) override;
        void normal(double *Nx, double *Ny, double *Nz) override;
        void cneter_to_oe_p(double *X2, double *Y2, double *Z2, double *X, double *Y, double *Z);
        void cneter_to_oe_v(double *Nx, double *Ny, double *Nz, double *L, double *M, double *N);
        void matrixMulti_GFCEM(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, int n);
        virtual void set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
    };
}

#endif



