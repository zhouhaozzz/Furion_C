#include "w_oe.h"

using namespace Furion_NS;

W_Oe::W_Oe(Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
    : beam_in(beam_in), grating(grating), surface(surface), theta(theta), chi(chi), beam_out(nullptr), Cff(0), N(beam_in->N), ds(ds), di(di), N2(N*N)
{
    cout << "W_Oe 初始化" << endl;

}

W_Oe::~W_Oe()
{
    delete beam_out;
    delete beam_in;
    delete gbeam_in;
    delete grating;
    delete surface;
    //delete g_mirror;
    cout << "W_Oe 的析构" << endl;
}

void W_Oe::reflect(Beam* beam_in, double ds, double di, double chi, double theta)
{
    cout << "W_Oe de reflect" << endl;

    create_g_beam();

    string mirror = tracing();

    double* delta_h = new double[this->N2];
    double* phase_s = new double[this->N2];

    if (mirror == "Furion_Plane_Mirror")
    {
        this->surface->value(delta_h, this->g_mirror->Z2, this->g_mirror->X2, N);
        for (int i = 0; i < this->N2; i++)
        {
            phase_s[i] = -2 * 2 * _Pi / this->beam_in->wavelength * delta_h[i] * g_mirror->cos_Alpha[i];
        }
    }
    else if (mirror == "Furion_Cylinder_Ellipse_Mirror")
    {
        this->surface->value(delta_h, this->g_FCE_mirror->Z2, this->g_FCE_mirror->X2, N*N);
        for (int i = 0; i < this->N2; i++)
        {
            phase_s[i] = -2 * 2 * _Pi / this->beam_in->wavelength * delta_h[i] * g_FCE_mirror->cos_Alpha[i];
            //cout << phase_s[i] << endl;
        }
        //cout << endl;
    }

    create_w_beam(phase_s);
}

std::string W_Oe::tracing()
{
    cout << "G_Furion_ellipsoid_MirrorW_Oe的tracing" << endl;

    return ("w_oe");
}

void W_Oe::create_g_beam()
{
    cout << "W_Oe de create_g_beam" << endl;

    double** Phase_field;
    create_2d(Phase_field, N);
    f_p_u2.Furion_phase_unwrap2(Phase_field, this->beam_in->field, N);
    
    double** optical_path;
    create_2d(optical_path, N);
    create_2d(beam_in->phase_field, N);
    double Pi2 = 2 * _Pi;
    for (int i = 0; i < N; i++) 
    { 
        optical_path[i] = new double[N];
        for (int j = 0; j < N; j++)
        {
            optical_path[i][j] = Phase_field[i][j] / (Pi2)*beam_in->wavelength;
            beam_in->phase_field[i][j] = Phase_field[i][j];
            //cout << Phase_field[i][j] << " ";
        }
        //cout << endl;
    }

    destory_2d(Phase_field, N);

    double dx = mean_diff(beam_in->X, N, 0);
    double dy = mean_diff(beam_in->Y, N, 1);

    double** Fx;
    double** Fy;
    create_2d(Fx, N);
    create_2d(Fy, N);
    gradient(Fx, Fy, optical_path, dx, dy, N);
    destory_2d(optical_path, N);

    create_1d(beam_in->XX, this->N2);
    create_1d(beam_in->YY, this->N2);
    double* phi = new double[this->N2];
    double* psi = new double[this->N2];
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            beam_in->XX[i + N * j] = beam_in->X[i][j];
            beam_in->YY[i + N * j] = beam_in->Y[i][j];
            phi[i + N * j] = -atan(Fx[i][j]);
            psi[i + N * j] = -atan(Fy[i][j]);
        }
    }

    destory_2d(Fx, N);
    destory_2d(Fy, N);

    gbeam_in = new G_Beam(beam_in->XX, beam_in->YY, phi, psi, beam_in->wavelength, this->N2);
}

void W_Oe::create_w_beam(double* s_phase)
{
    cout << "W_Oe de create_g_beam" << endl;

    //double** Phase;
    //create_2d(Phase, N);
    //f_p_u2.Furion_phase_unwrap2(Phase, this->beam_in->field, N);

    this->beam_out = new Beam(this->beam_in->X, this->beam_in->Y, this->beam_in->field, this->beam_in->wavelength, N);

}

double W_Oe::mean_diff(double** X, int N, int n)
{
    double dx = 0;

    if (n == 0)
    {
        double dx = 0;
        for (int i = 1; i < N; i++)
        {
            dx = dx + (X[0][i] - X[0][i - 1]);
        }
        return dx / (N - 1);
    }
    else if (n == 1)
    {
        double dx = 0;
        for (int i = 1; i < N; i++)
        {
            dx = dx + (X[i][0] - X[i - 1][0]);
        }
        return dx / (N-1);
    }
    else
    {
        cout << "The mean diff function can only accept 0 and 1 as arguments" << endl;
        exit(0);
    }
}

void W_Oe::gradient(double** Fx, double** Fy, double** optical_path, double dx, double dy, int N) 
{
    // Fx
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (j == 0) {
                Fx[i][j] = (optical_path[i][j + 1] - optical_path[i][j]) / dx;
            }
            else if (j == N - 1) {
                Fx[i][j] = (optical_path[i][j] - optical_path[i][j - 1]) / dx;
            }
            else {
                Fx[i][j] = (optical_path[i][j + 1] - optical_path[i][j - 1]) / (2 * dx);
            }
        }
    }

    // Fy
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (i == 0) {
                Fy[i][j] = (optical_path[i + 1][j] - optical_path[i][j]) / dy;
            }
            else if (i == N - 1) {
                Fy[i][j] = (optical_path[i][j] - optical_path[i - 1][j]) / dy;
            }
            else {
                Fy[i][j] = (optical_path[i + 1][j] - optical_path[i - 1][j]) / (2 * dy);
            }
        }
    }
}
