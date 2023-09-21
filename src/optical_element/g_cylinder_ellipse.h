#pragma once

#ifndef FUR_G_CYLINDER_ELLIPSE_H_
#define FUR_G_CYLINDER_ELLIPSE_H_

#include "Furion.h"
#include "g_oe.h"

namespace Furion_NS
{

    class G_Cylinder_Ellipse : public G_Oe       //The tracking phase converts to Angle
    {
    public:

        double *T = new double[Furion::n];                     //Elliptic parameter
        double *Nx = new double[Furion::n];          //In center coordinates, the normal vector
        double *Ny = new double[Furion::n];          //In center coordinates, the normal vector
        double *Nz = new double[Furion::n];          //In center coordinates, the normal vector

        double alpha;
        double a;
        double b;
        double beta;
        double r1;
        double e;

        G_Cylinder_Ellipse(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Cylinder_Ellipse();

        void intersection(double* T) override;
        void source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N) override;
        void normal(double *Nx, double *Ny, double *Nz) override;
        void h_slope(double *h_slope, double *Y2) override;
    };
}

#endif



