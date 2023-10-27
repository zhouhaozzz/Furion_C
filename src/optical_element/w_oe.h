#pragma once

#ifndef FUR_W_OE_H_
#define FUR_W_OE_H_

#include "Furion.h"
#include "g_beam.h"
#include "beam.h"
#include "grating.h"
#include "no_surfe.h"
#include "Furion_phase_unwrap2.h"
#include "g_Furion_plane_Mirror.h"



namespace Furion_NS
{

    class W_Oe
    {
    public:
        double chi;         //Direction of optical components
        double ds;
        double Cff;
        double di;
        double theta;       //Grazing Angle of incidence

        int N;

        Beam* beam_out;
        Beam* beam_in;
        G_Beam* gbeam_in;
        Grating* grating;
        No_Surfe* surface;

        G_Furion_Plane_Mirror* g_mirror;

        Furion_Phase_Unwrap2 f_p_u2;

        W_Oe(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        virtual ~W_Oe();
        
        void reflect(Beam* beam_in, double ds, double di, double chi, double theta);
        virtual void tracing();
        void create_g_beam();
        virtual void create_w_beam(double* s_phase);
        double mean_diff(double** X, int N, int n);
        void gradient(double** Fx, double** Fy, double** optical_path, double dx, double dy, int N);
    };
}

#endif



//double sum = 0;
//double sum1 = 0;
//double sum2 = 0;
//for (int i = 0; i < Furion::n; i++)
//{
//    sum = sum + fabs(T[i] + T1[i]);
//    sum1 = sum1 + fabs(this->Phase[i]);
//    sum2 = sum2 + fabs(this->Phase[i]);
//}
//cout << sum << " " << sum1 << " " << sum2 << endl;
