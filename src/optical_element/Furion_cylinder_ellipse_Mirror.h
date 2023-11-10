#pragma once

#ifndef FUR_FURION__CYLINDER_ELLIPSE_MIRROR_H_
#define FUR_FURION__CYLINDER_ELLIPSE_MIRROR_H_

#include "Furion.h"
#include "w_oe.h"



namespace Furion_NS
{
    class Furion_Cylinder_Ellipse_Mirror : public W_Oe
    {
    public: 
        double r;
        double r1;
        double r2;
        double flag;

        Furion_Cylinder_Ellipse_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating, double flag);
        ~Furion_Cylinder_Ellipse_Mirror();

        void run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating, double flag);
        std::string tracing() override;
        void create_w_beam(double* s_phase) override;
        //void interp2(double* Vq, double** X, double** Y, double** V, double* x, double* y, int n);

    };
}

#endif



