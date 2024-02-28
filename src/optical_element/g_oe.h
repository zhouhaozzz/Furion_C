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

        //double *X_;                     //Output beam X coordinates
        //double *Y_;                     //Output beam Y coordinates
        //double *PSI;                   //Output beam PHI Angle
        //double *PHI;                   //Output beam PSI Angle
        //double* Phase;                 //Output parameter
        //double *L1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        //double *M1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        //double *N1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        //double *X1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        //double *Y1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        //double *Z1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        //double *X2;
        //double *Y2;
        //double *Z2;
        //double *cos_Alpha;
        std::vector<double> X_;                     //Output beam X coordinates
        std::vector<double> Y_;                     //Output beam Y coordinates
        std::vector<double> PSI;                   //Output beam PHI Angle
        std::vector<double> PHI;                   //Output beam PSI Angle
        std::vector<double> Phase;                 //Output parameter
        std::vector<double> L1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        std::vector<double> M1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        std::vector<double> N1;          //Beam line direction in the optical component coordinate system [L1 M1 N1]
        std::vector<double> X1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        std::vector<double> Y1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        std::vector<double> Z1;          //Beam position [X1,Y1,Z1] in the optical component coordinate system unit m
        std::vector<double> X2;
        std::vector<double> Y2;
        std::vector<double> Z2;
        std::vector<double> cos_Alpha;


        double theta;       //Grazing Angle of incidence
        double chi;         //Direction of optical components
        double Cff;
        double theta2;

        int n;

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
        virtual void source_to_oe(std::vector<double>& X, std::vector<double>& Y, double ds, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N);
        void matrixMulti33(std::vector<double>& matrix, std::vector<double>& matrix1, std::vector<double>& matrix2);  //XYZ:1*3; LMN:1*n
        void matrixMulti(std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& matrix, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N, double dx, int n);  //XYZ:1*3; LMN:1*n
        void matrixMulti0(std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2, std::vector<double>& matrix, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N, int n);  //XYZ:1*3; LMN:1*n
        virtual void intersection(std::vector<double>& T);
        virtual void normal(std::vector<double>& Nx, std::vector<double>& Ny, std::vector<double>& Nz);
        virtual void h_slope(std::vector<double>& h_slope, std::vector<double>& Y2);
        void oe_to_image(std::vector<double>& X3, std::vector<double>& Y3, std::vector<double>& Z3, std::vector<double>& L3, std::vector<double>& M3, std::vector<double>& N3, std::vector<double>& X2, std::vector<double>& Y2, std::vector<double>& Z2, double di, std::vector<double>& L2, std::vector<double>& M2, std::vector<double>& N2);

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
