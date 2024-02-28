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
#include "g_Furion_cylinder_ellipse_Mirror.h"
#include "g_Furion_cyliner_parabolic_collimation_Mirror.h"
#include "g_Furion_cyliner_parabolic_focus_Mirror.h"
#include "g_Furion_ellipsoid_Mirror.h"
#include "g_Furion_paraboid_collimation_Mirror.h"
#include "g_Furion_paraboid_focus_Mirror.h"
#include "g_Furion_cyliner_spherical_Mirror.h"
#include "g_Furion_spherical_Mirror.h"
#include "g_Furion_toroid_Mirror.h"

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
        int N2;

        Beam* beam_out;
        Beam* beam_in;
        G_Beam* gbeam_in;
        Grating* grating;
        No_Surfe* surface;

        //template <class G_Furion_Plane_Mirror*, class G_Furion_Cylinder_Ellipse_Mirror*> gg;

        //template <typename TYPE> void destory_1d(TYPE*& data)

        G_Furion_Plane_Mirror* g_mirror;
        G_Furion_Cylinder_Ellipse_Mirror* g_FCE_mirror;
        G_Furion_Cyliner_Parabolic_Collimation_Mirror* g_FCPC_mirror;
        G_Furion_Cyliner_Parabolic_Focus_Mirror* g_FCPF_mirror;
        G_Furion_ellipsoid_Mirror* g_FE_mirror;
        G_Furion_Paraboid_Collimation_Mirror* g_FPC_mirror;
        G_Furion_Paraboid_Focus_Mirror* g_FPF_mirror;
        G_Furion_Cyliner_Spherical_Mirror* g_FCS_mirror;
        G_Furion_Spherical_Mirror* g_FS_mirror;
        G_Furion_Toroid_Mirror* g_FT_mirror;

        Furion_Phase_Unwrap2 f_p_u2;

        W_Oe(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        virtual ~W_Oe();
        
        void reflect(Beam* beam_in, double ds, double di, double chi, double theta);
        virtual std::string tracing();
        void create_g_beam();
        virtual void create_w_beam(std::vector<double>& s_phase);
        double mean_diff(std::vector<std::vector<double> >& X, int N, int n);
        void gradient(std::vector<std::vector<double> >& Fx, std::vector<std::vector<double> >& Fy, std::vector<std::vector<double> >& optical_path, double dx, double dy, int N);
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
