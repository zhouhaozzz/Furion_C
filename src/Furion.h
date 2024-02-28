#pragma once

#ifndef FUR_FURION_H_
#define FUR_FURION_H_

//#define BOOST_ALL_DYN_LINK

#include <iostream>
#include <math.h>
#include <fstream>
#include <sstream>
#include <vector>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iomanip>
#include <cstdio>
#include <cmath>
#include <random>
#include <complex>
#include <iterator>
#include <utility>

#include <gsl/gsl_math.h>
#include <gsl/gsl_interp2d.h>
#include <gsl/gsl_spline2d.h>
#include <gsl/gsl_fft_complex.h>
#include <fftw3.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_complex.h>
#include <gsl/gsl_complex_math.h>

#ifdef CGAL_INTER
#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Delaunay_triangulation_2.h>
#include <CGAL/Interpolation_traits_2.h>
#include <CGAL/natural_neighbor_coordinates_2.h>
#include <CGAL/interpolation_functions.h>
#endif


//#include <mpi.h>

using namespace std;

//#define Pi 3.141592653589793
#define E  2.7182818284590
//int nn = 0;


namespace Furion_NS
{
    class Furion
    {
    public:
        Furion(int rank1, int size1);
        ~Furion();

#ifdef Geometric
        class Grating* grating;            // Grate setting
        class G_Source* g_source;
        class G_Beam* g_beam;
        class No_Surfe* no_surfe;
        class G_Furion_Cylinder_Ellipse_Mirror* g_Furion_cylinder_ellipse_Mirror;
        class G_Furion_ellipsoid_Mirror* g_Furion_ellipsoid_Mirror;
        class G_Furion_Hole* g_Furion_hole;
        class G_Furion_Paraboid_Collimation_Mirror* g_Furion_paraboid_collimation_Mirror;
        class G_Furion_Paraboid_Focus_Mirror* g_Furion_paraboid_focus_Mirror;
        class G_Furion_Cyliner_Parabolic_Collimation_Mirror* g_Furion_cyliner_parabolic_collimation_Mirror;
        class G_Furion_Cyliner_Parabolic_Focus_Mirror* g_Furion_cyliner_parabolic_focus_Mirror;

        size_t i = 0;
        const static int n = 100000;
        double Lambda[5] = { 1, 1.55, 2, 2.5, 3 };
        double pre_Mirror_theta[5] = { 0.82448, 1.0266, 1.1662, 1.3039, 1.4285 };
        double grating_theta[5] = { 6.397, 7.9674, 9.0524, 10.124, 11.093 };
        double beamsize[5] = { 0.113155108251141, 0.134122084191793, 0.137907788181078, 0.139653456385901, 0.145485139180038 };
        double divergence[5] = { 3.9, 4.9731, 6.6307, 8.2884, 9.1 };
        double lambda, psigmax, psigmay, vsigmax, vsigmay;
#endif // Geometric

#ifdef WAVE


        size_t i = 0;
        const static int N = 5;
        const static int n = N * N;
#endif // WAVE

    };

    template <typename TYPE> void destory_1d(TYPE*& data)
    {
        if (data == nullptr) return;
        delete[] data;
        data = nullptr;
    }

    template <typename TYPE> void destory_2d(TYPE**& data, int N)
    {
        if (data == nullptr) return;
        for (int i = 0; i < N; i++)
        {
            delete[] data[i];
        }
        delete[] data;
        data = nullptr;
    }

    template <typename TYPE> void create_1d(TYPE*& data, int N)
    {
        data = new TYPE[N];
    }

    template <typename TYPE> void create_2d(TYPE**& data, int N) {
        data = new TYPE * [N];
        for (int i = 0; i < N; i++) {
            data[i] = new TYPE[N];
        }
    }

    //std::vector<std::vector<double>> furion_chche = std::vector<std::vector<double>>(Furion::N, std::vector<double>(Furion::N));


    void interp2(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, std::vector<std::vector<double> >& V, std::vector<double>& x, std::vector<double>& y, int n, int nx, int ny, string Type);
    void interp2_1(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& V, std::vector<double>& x, std::vector<double>& y, int n, int nx, int ny, string Type);
    void reshape(std::vector<std::vector<double> >& output, std::vector<double>& input, int x, int y);
    inline int point_inside_triangle(double x[4], double y[4]);

    void scatteredInterpolant(std::vector<double>& result, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& X_, std::vector<double>& Y_, std::vector<double>& value, int N);
    void scatteredInterpolant_2d_complex(std::vector<std::vector<std::complex<double>> >& result, std::vector<double>& X, std::vector<double>& Y, std::vector<std::vector<double> >& X_, std::vector<std::vector<double> >& Y_, std::vector<std::vector<std::complex<double>> >& value, int N);
    void linspace(std::vector<double>& x, double min, double max, int N);
    double Max(std::vector<double>& X, int n);
    double Min(std::vector<double>& X, int n);
    void FFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N);
    void iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N);
    void FFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N);
    void iFFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N);



}

#endif



