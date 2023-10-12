#pragma once

#ifndef FUR_G_OE_H_
#define FUR_G_OE_H_

#include "Furion.h"
#include "g_beam.h"
#include "grating.h"
#include "no_surfe.h"
#include "furion_angle_vector.h"
#include "furion_rotx.h"
#include "furion_rotz.h"
#include "furion_reflect_vector.h"
#include "furion_vector_angle.h"

namespace Furion_NS
{

    class G_Oe
    {
    public:

        double *X_ = new double[Furion::n];                     //Output beam X coordinates
        double *Y_ = new double[Furion::n];                     //Output beam Y coordinates
        double *PSI = new double[Furion::n];                   //Output beam PHI Angle
        double *PHI = new double[Furion::n];                   //Output beam PSI Angle
        double *Phase = new double[Furion::n];                 //Output parameter
        double *L1 = new double[Furion::n];          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        double *M1 = new double[Furion::n];          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        double *N1 = new double[Furion::n];          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        double *X1 = new double[Furion::n];          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        double *Y1 = new double[Furion::n];          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        double *Z1 = new double[Furion::n];          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        double *X2 = new double[Furion::n];
        double *Y2 = new double[Furion::n];
        double *Z2 = new double[Furion::n];
        double *cos_Alpha = new double[Furion::n];

        double theta;       //Grazing Angle of incidence
        double chi;         //Direction of optical components
        double Cff;
        double theta2;

        G_Beam* beam_out;
        G_Beam* beam_in;
        Grating* grating;
        No_Surfe* surface;



        G_Oe(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
        virtual ~G_Oe();

        class Furion_Angle_Vector f_a_v;
        class Furion_Rotx f_rx;
        class Furion_Rotz f_rz;
        class Furion_Reflect_Vector f_r_v;
        class Furion_Vector_Angle f_v_a;
        
        void reflect(G_Beam* beam_in, double ds, double di, double chi, double theta);
        virtual void source_to_oe(double *X, double *Y, double ds, double *L, double *M, double *N);
        void matrixMulti33(double* matrix, double* matrix1, double* matrix2);  //XYZ:1*3; LMN:1*n
        void matrixMulti(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, int n);  //XYZ:1*3; LMN:1*n
        void matrixMulti0(double *L2, double *M2, double *N2, double *matrix, double *L, double *M, double *N, int n);  //XYZ:1*3; LMN:1*n
        virtual void intersection(double *T);
        virtual void normal(double *Nx, double *Ny, double *Nz);
        virtual void h_slope(double *h_slope, double *Y2);
        void oe_to_image(double *X3, double *Y3, double *Z3, double *L3, double *M3, double *N3, double *X2, double *Y2, double *Z2, double di, double *L2, double *M2, double *N2);
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
