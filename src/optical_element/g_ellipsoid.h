#pragma once

#ifndef FUR_G_ELLIPSOID_H_
#define FUR_G_ELLIPSOID_H_

#include "Furion.h"
//#include "g_oe.h"
#include "g_cylinder_ellipse.h"
//#include "g_Furion_cylinder_ellipse_Mirror.h"

namespace Furion_NS
{
    class G_Ellipsoid : public G_Cylinder_Ellipse
    {
    public:

        G_Ellipsoid(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Ellipsoid();

        void intersection(double* T) override;
        void normal(double *Nx, double *Ny, double *Nz) override;
    };
}

#endif

