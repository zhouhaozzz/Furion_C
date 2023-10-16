#pragma once

#ifndef FUR_G_CYLINDER_PARABOLIC_FOCUS_H_
#define FUR_G_CYLINDER_PARABOLIC_FOCUS_H_

#include "Furion.h"
#include "g_oe.h"

namespace Furion_NS
{

    class G_Cyliner_Parabolic_Focus : public G_Oe       //The tracking phase converts to Angle
    {
    public:

        double *T = new double[Furion::n];                     //Elliptic parameter
        double *Nx = new double[Furion::n];          //In center coordinates, the normal vector
        double *Ny = new double[Furion::n];          //In center coordinates, the normal vector
        double *Nz = new double[Furion::n];          //In center coordinates, the normal vector

        double r2;
        double p;

        G_Cyliner_Parabolic_Focus(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Cyliner_Parabolic_Focus();

        virtual void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);

        void intersection(double* T) override;
        void matrixMulti_GCPF(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, double dy, int n);
        void source_to_oe(double* X, double* Y, double ds, double* L, double* M, double* N) override;
        void normal(double *Nx, double *Ny, double *Nz) override;
        void h_slope(double *h_slope, double *Y2) override;
    };
}

#endif



