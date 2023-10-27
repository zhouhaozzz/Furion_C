#include "Furion_plane_Mirror.h"

using namespace Furion_NS;

Furion_Plane_Mirror::Furion_Plane_Mirror(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
    : W_Oe(beam_in, ds, di, chi, theta, surface, grating)//, grating(grating)
{
    cout << "Furion_plane_Mirror 初始化" << endl;
    //test();
}

Furion_Plane_Mirror::~Furion_Plane_Mirror()
{
    //delete ct;
}

void Furion_Plane_Mirror::run(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
{
    cout << "Furion_Plane_Mirror的set_center" << endl;
    reflect(beam_in, ds, di, chi, theta);
}

void Furion_Plane_Mirror::tracing()
{
    cout << "Furion_Plane_Mirror的tracing" << endl;
    No_Surfe* no_surfe = new No_Surfe();
    this-> g_mirror= new G_Furion_Plane_Mirror(this->gbeam_in, this->ds, this->di, this->chi, this->theta, no_surfe, 0, 0, this->grating);
    g_mirror->run(this->gbeam_in, this->ds, this->di, this->chi, this->theta, no_surfe, 0, 0, this->grating);
}

void Furion_Plane_Mirror::create_w_beam(double* s_phase)
{
    int N2 = N * N;
    if (this->grating->m == 0)
    {
        double* Phase = new double[N2];
        for (int i = 0; i < N2; i++)
        {
            Phase[i] = this->g_mirror->Phase[i] + s_phase[i];
        }
        
        double** phase1;
        create_2d(phase1, N);
        reshape(phase1, Phase,N,N);
        destory_1d(Phase);

        std::complex<double>** Field_new;
        create_2d(Field_new, N);
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                Field_new[i][j] = std::abs(this->beam_in->field[i][j]) * std::exp(std::complex<double>(0, this->beam_in->phase_field[i][j]+phase1[i][j]));
            }
        }
        destory_2d(phase1, N);
        
        this->beam_out = new Beam(this->beam_in->X, this->beam_in->Y, Field_new, this->beam_in->wavelength, N);
    }
}

void Furion_NS::reshape(double** output, double* input, int x, int y)
{
    for (int i = 0; i < x; ++i) {
        for (int j = 0; j < y; ++j) {
            int index = i + j * x;
            output[i][j] = input[index];
        }
    }
}