#include "Furion_cylinder_ellipse_Mirror.h"

using namespace Furion_NS;

Furion_Cylinder_Ellipse_Mirror::Furion_Cylinder_Ellipse_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating, double flag)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating), r1(r1), r2(r2), flag(flag)
{
    cout << "Furion_Cylinder_Ellipse_Mirror 初始化" << endl;
    //test();
}

Furion_Cylinder_Ellipse_Mirror::~Furion_Cylinder_Ellipse_Mirror()
{
    //delete ct;
    delete this->beam_in ;
}

void Furion_Cylinder_Ellipse_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating, double flag)
{
    cout << "Furion_Cylinder_Ellipse_Mirror的run" << endl;
    reflect(beam_in, ds, di, chi, theta);

}

std::string Furion_Cylinder_Ellipse_Mirror::tracing()
{
    cout << "Furion_Cylinder_Ellipse_Mirror的tracing" << endl;
    
    this->g_FCE_mirror = new G_Furion_Cylinder_Ellipse_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, surface, this->r1, this->r2, this->grating);
    this->g_FCE_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, surface, this->r1, this->r2, this->grating);
    return ("Furion_Cylinder_Ellipse_Mirror");
}

void Furion_Cylinder_Ellipse_Mirror::create_w_beam(std::vector<double>& s_phase)
{
    if (1)
    {
        //double* phase_0 = new double[this->N2];
        //double* phase_interp = new double[this->N2];
        std::vector<double> phase_0(this->N2);
        std::vector<double> phase_interp(this->N2);
        for (int i = 0; i < this->N; i++) {
            for (int j = 0; j < this->N; j++) {
                phase_0[i * this->N + j] = this->g_FCE_mirror->Phase[i * this->N + j] + s_phase[i * this->N + j] + beam_in->phase_field[i][j];
            }
        }
        Furion_NS::scatteredInterpolant(phase_interp, this->beam_in->XX, this->beam_in->YY, this->g_FCE_mirror->X_, this->g_FCE_mirror->Y_, phase_0, this->N);

        //double* field_interp = new double[this->N2];
        std::vector<double> field_interp(this->N2);
        for (int i = 0; i < this->N; i++){
            for (int j = 0; j < this->N; j++){
                phase_0[i * this->N + j] = std::abs(this->beam_in->field[i][j]);
            }
        }
        Furion_NS::scatteredInterpolant(field_interp, this->beam_in->XX, this->beam_in->YY, this->g_FCE_mirror->X_, this->g_FCE_mirror->Y_, phase_0, this->N);
        //destory_1d(phase_0);
        phase_0.clear();

        //double** X_new1;
        //double** Y_new1;
        //create_2d(X_new1, this->N);
        //create_2d(Y_new1, this->N);
        std::vector<std::vector<double> > X_new1(N, std::vector<double>(N));
        std::vector<std::vector<double> > Y_new1(N, std::vector<double>(N));

        Furion_NS::reshape(X_new1, this->beam_in->XX, this->N, this->N);
        Furion_NS::reshape(Y_new1, this->beam_in->YY, this->N, this->N);


        //std::complex<double>** Field_new;
        //create_2d(Field_new, this->N);
        std::vector<std::vector<std::complex<double>> > Field_new(N, std::vector<std::complex<double>>(N));
        if (this->flag == 0)
        {
            for (int i = 0; i < this->N; i++) {
                for (int j = 0; j < this->N; j++) {
                    Field_new[i][j] = std::fabs(field_interp[i * N + j]) * std::exp(std::complex<double>(0, phase_interp[i * N + j]));
                }
            }
            //destory_1d(phase_interp);
            //destory_1d(field_interp);
            phase_interp.clear();
            field_interp.clear();

            this->beam_out = new Beam(X_new1, Y_new1, Field_new, this->beam_in->wavelength, N);

        }
        else
        {
            double L = Furion_NS::Max(this->beam_in->X[0], N) - Furion_NS::Min(this->beam_in->X[0], N);
            //double* x = new double[this->N];
            //double* y = new double[this->N];
            //double* y_new1 = new double[this->N];
            std::vector<double> x(this->N);
            std::vector<double> y(this->N);
            std::vector<double> y_new1(this->N);

            
            //double* phase1 = new double[this->N2];
            //double* field1 = new double[this->N2];
            std::vector<double> phase1(this->N2);
            std::vector<double> field1(this->N2);

            Furion_NS::linspace(x, -L / 2, L / 2, this->N);
            for (int i = 0; i < this->N; i++) {
                y[i] = x[i];
                y_new1[i] = Y_new1[i][0];
                //cout << y_new1[i] << endl;
            }

            Furion_NS::interp2_1(phase1, X_new1[0], y_new1, phase_interp, x, y, this->N2, this->N, this->N, "cubic");
            //exit(0);
            Furion_NS::interp2_1(field1, X_new1[0], y_new1, field_interp, x, y, this->N2, this->N, this->N, "cubic");
            //destory_1d(x);
            //destory_1d(y);
            //destory_1d(y_new1);
            //destory_1d(phase_interp);
            //destory_1d(field_interp);
            x.clear();
            y.clear();
            y_new1.clear();
            phase_interp.clear();
            field_interp.clear();

            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    Field_new[i][j] = std::fabs(phase1[i * N + j]) * std::exp(std::complex<double>(0, field1[i * N + j]));
                }
            }
            //destory_1d(phase1);
            //destory_1d(field1);
            phase1.clear();
            field1.clear();

            this->beam_out = new Beam(X_new1, Y_new1, Field_new, this->beam_in->wavelength, N);
        }
    }
}






