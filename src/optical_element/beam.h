#pragma once

#ifndef FUR_BEAM_H_
#define FUR_BEAM_H_

#include "Furion.h"
#include "Furion_fresnel_spectralh.h"
#include "Furion_fresnel_spatialh.h"
//#include <boost/math/interpolators/barycentric_rational.hpp>
//#include <boost/math/interpolators/>

namespace Furion_NS
{
    class Beam
    {
    public:
        double wavelength;
        int N;

        //double** X;
        //double** Y;
        //double** phase_field;
        //std::complex<double>** field;
        //double* XX;
        //double* YY;
        std::vector<std::vector<double> > X;
        std::vector<std::vector<double> > Y;
        std::vector<std::vector<double> > phase_field;
        std::vector<std::vector<std::complex<double>> > field;
        std::vector<double> XX;
        std::vector<double> YY;

        //double** kk;
        std::vector<std::vector<double> > kk;

        Beam(std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<std::complex<double>> >& field, double wavelength, int N);
        ~Beam();

        void destory();

        class Furion_Fresnel_Spectralh f_f_spe;
        class Furion_Fresnel_Spatialh f_f_spa;

        Beam translate(double distance);

        Beam resize1(double L);
        Beam resize2(double L, int N);
        Beam resize3(double Lx, double Ly, int N);

        double power();
        void trapz(std::vector<double>& out, std::vector<double>& x, std::vector<std::vector<double>>& y, double dx);
        void trapz(double& out, std::vector<double>& x, std::vector<double>& y, double dx);


        //void creat_Furion_plot_sigma(int rank1);
    };
}

#endif

