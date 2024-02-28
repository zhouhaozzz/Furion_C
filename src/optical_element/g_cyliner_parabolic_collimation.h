#pragma once

#ifndef FUR_G_CYLINDER_PARABOLIC_COLLIMATION_H_
#define FUR_G_CYLINDER_PARABOLIC_COLLIMATION_H_

#include "Furion.h"
#include "g_oe.h"

namespace Furion_NS
{

    class G_Cyliner_Parabolic_Collimation : public G_Oe       //The tracking phase converts to Angle
    {
    public:

        //double *T = new double[Furion::n];                     //Elliptic parameter
        //double *Nx = new double[Furion::n];          //In center coordinates, the normal vector
        //double *Ny = new double[Furion::n];          //In center coordinates, the normal vector
        //double *Nz = new double[Furion::n];          //In center coordinates, the normal vector
        std::vector<double> T;
        std::vector<double> Nx;
        std::vector<double> Ny;
        std::vector<double> Nz;

        double r1;
        double p;

        G_Cyliner_Parabolic_Collimation(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating);
        ~G_Cyliner_Parabolic_Collimation();

        void run(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, Grating* grating);

        void intersection(std::vector<double>& T) override;
        void source_to_oe(std::vector<double>& X, std::vector<double>& Y, double ds, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N) override;
        void normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz) override;
        void h_slope(std::vector<double>& h_slope, std::vector<double>& Y2) override;
    };
}

#endif



