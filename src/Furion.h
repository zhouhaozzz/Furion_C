#pragma once

#ifndef FUR_FURION_H_
#define FUR_FURION_H_

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
        class Grating* grating;            // Grate setting
        class Source* source;
        class Beam* beam;
        class No_Surfe* no_surfe;
        class Furion_Plane_Mirror* Furion_plane_Mirror;

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
}

#endif



