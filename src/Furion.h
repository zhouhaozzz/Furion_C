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

#include <mpi.h>

using namespace std;

#define Pi 3.1415926536
#define E  2.71828

namespace Furion_NS
{
    class Furion
    {
    public:
        class Grating* grating;            // Grate setting
        class G_Source* g_source;
        class G_Beam* g_beam;
        class No_Surfe* no_surfe;
        class G_Furion_Cylinder_Ellipse_Mirror* g_Furion_cylinder_ellipse_Mirror;

        Furion(int rank1, int size1);
        ~Furion();

        void init();

        size_t i = 0;
        const static int n = 100000;
        double Lambda[5] = { 1, 1.55, 2, 2.5, 3 };
        double pre_Mirror_theta[5] = { 0.82448, 1.0266, 1.1662, 1.3039, 1.4285 };
        double grating_theta[5] = { 6.397, 7.9674, 9.0524, 10.124, 11.093 };
        double beamsize[5] = { 0.113155108251141, 0.134122084191793, 0.137907788181078, 0.139653456385901, 0.145485139180038 };
        double divergence[5] = { 3.9, 4.9731, 6.6307, 8.2884, 9.1 };
        double lambda, psigmax, psigmay, vsigmax, vsigmay;
    };
}

#endif



