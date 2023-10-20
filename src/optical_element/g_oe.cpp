#include "G_Oe.h"
#include "g_beam.h"

using namespace Furion_NS;

G_Oe::G_Oe(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
    : beam_in(beam_in), grating(grating), surface(surface), theta(theta), chi(chi), beam_out(beam_in), Cff(0), theta2(0), n(beam_in->n)
{
    //beam_out = nullptr;
    // beam_out = G_Beam((this->X_, this->Y_, beam_in->phi, beam_in->psi, beam_in->lambda))
}

G_Oe::~G_Oe()
{
    delete X_, Y_, PHI, PSI, Phase;
    delete L1, M1, N1, X1, Y1, Z1, X2, Y2, Z2, cos_Alpha;
}

void G_Oe::reflect(G_Beam* beam_in, double ds, double di, double chi, double theta)
{
    //int n = 1000;
    double *L = new double[this->n];
    double *M = new double[this->n];
    double *N = new double[this->n];
    double *T = new double[this->n];
    double *T1 = new double[this->n];
    double *Nx = new double[this->n];
    double *Ny = new double[this->n];
    double *Nz = new double[this->n];
    double *hslope = new double[this->n];
    double *L2 = new double[this->n];
    double *M2 = new double[this->n];
    double *N2 = new double[this->n];
    double *X3 = new double[this->n];
    double *Y3 = new double[this->n];
    double *Z3 = new double[this->n];
    double *L3 = new double[this->n];
    double *M3 = new double[this->n];
    double *N3 = new double[this->n];

    f_a_v.Furion_angle_vector(beam_in->phi, beam_in->psi, L, M, N, this->n);               //[phi,psi]-&gt; [L,M,N] angles are converted to unit vectors

    source_to_oe(beam_in->XX, beam_in->YY, ds, L, M, N);           //From light source coordinate system to optical component coordinate system

    intersection(T);                                      //The intersection of light and optical components

    normal(Nx, Ny, Nz);                                   //mormal Find reflection vector

    h_slope(hslope, this->Y2);      //Calculate the surface slope error    Find the slope of the corresponding position

    this->theta2 = Pi / 2 - asin(sin(Pi / 2 - theta) - grating->n0 * grating->m * grating->lambda_G);
    this->Cff = cos(Pi / 2 - this->theta2) / cos(Pi / 2 - this->theta);
    
    f_r_v.Furion_reflect_Vector(this->cos_Alpha, L2, M2, N2, this->L1, this->M1, this->N1, Nx, Ny, Nz, grating->lambda_G, grating->m, grating->n0, grating->b, this->Z2, hslope, this->Cff, n);
    
    oe_to_image(X3, Y3, Z3, L3, M3, N3, this->X2, this->Y2, this->Z2, di, L2, M2, N2);

    for (int i = 0; i < n; i++)
    {
        T1[i] = -Z3[i] / N3[i];
        this->X_[i] = X3[i] + T1[i]*L3[i];
        this->Y_[i] = Y3[i] + T1[i]*M3[i];
        this->Phase[i] = (T[i]+T1[i])/beam_in->lambda*2*Pi - grating->n0*grating->m*2*Pi*Z2[i] - 0.5 * grating->m*grating->b*grating->n0*2*Pi*(Z2[i]*Z2[i]);
    }
    
    f_v_a.Furion_vector_angle(this->PHI, this->PSI, L3, M3, this->n);
    
    beam_out = new G_Beam((this->X_), (this->Y_), (this->PHI), (this->PSI), beam_in->lambda, n);

    delete[] L,M,N;
    delete[] T, T1;
    delete[] Nx, Ny, Nz;
    delete[] hslope;
    delete[] L2, M2, N2;
    delete[] X3, Y3, Z3, L3, M3, N3;
}

void G_Oe::source_to_oe(double *X, double *Y, double ds, double *L, double *M, double *N)
{
    int n = this->n;
    double* OS = new double[9];
    double *OS_0 = new double[9];
    double *OS_1 = new double[9]; 
    f_rx.furion_rotx(theta, OS_0);
    f_rz.furion_rotz(chi, OS_1);

    double *Z = new double[1];
    Z[0] = -ds;
    matrixMulti33(OS, OS_0, OS_1);
    matrixMulti0(this->X1, this->Y1, this->Z1, OS, X, Y, Z, n);

    matrixMulti(this->L1, this->M1, this->N1, OS, L, M, N, 0, n);

    delete[] Z, OS_0, OS_1;
    cout << " G_Oe的source_to_oe" << endl;
}

void G_Oe::matrixMulti(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, double dx, int n)  //XYZ:1*3; LMN:1*n
{
    for (int i = 0; i < n; i++)
    {
        L2[i] = matrix[0] * L[i] + matrix[1] * M[i] + matrix[2] * N[i];
        M2[i] = matrix[3] * L[i] + matrix[4] * M[i] + matrix[5] * N[i];
        N2[i] = matrix[6] * L[i] + matrix[7] * M[i] + matrix[8] * N[i] + dx;
    }
}

void G_Oe::matrixMulti33(double* matrix, double* matrix1, double* matrix2)  //XYZ:1*3; LMN:1*n
{
    for (int i = 0; i < 3; i++)
    {
        matrix[i] = matrix1[0] * matrix2[i] + matrix1[1] * matrix2[i + 3] + matrix1[2] * matrix2[i + 6];
        matrix[i + 3] = matrix1[3] * matrix2[i] + matrix1[4] * matrix2[i + 3] + matrix1[5] * matrix2[i + 6];
        matrix[i + 6] = matrix1[6] * matrix2[i] + matrix1[7] * matrix2[i + 3] + matrix1[8] * matrix2[i + 6];
    }
}

void G_Oe::matrixMulti0(double* L2, double* M2, double* N2, double* matrix, double* L, double* M, double* N, int n)  //XYZ:1*3; LMN:1*n
{
    for (int i = 0; i < n; i++)
    {
        L2[i] = matrix[0] * L[i] + matrix[1] * M[i] + matrix[2] * N[0];
        M2[i] = matrix[3] * L[i] + matrix[4] * M[i] + matrix[5] * N[0];
        N2[i] = matrix[6] * L[i] + matrix[7] * M[i] + matrix[8] * N[0];
    }
}


void G_Oe::intersection(double *T)
{
    int n = this->n;

    for (int i = 0; i < n; i++) 
    {
        T[i] = this->Y1[i] / this->M1[i];
        this->X2[i] = this->X1[i] + T[i]*this->L1[i];
        this->Y2[i] = 0;
        this->Z2[i] = this->Z1[i] + T[i]*this->N1[i];
    }
    cout << " G_Oe的intersection" << endl;

}

void G_Oe::normal(double *Nx, double *Ny, double *Nz)
{
    int n = this->n;

    for (int i = 0; i < n; i++) 
    {
        Nx[i] = 0;
        Ny[i] = 0;
        Nz[i] = 0;
    }

    cout << "G_Oe的normal" << endl;
}

void G_Oe::h_slope(double *h_slope, double *Y2)
{
    int n = this->n;
    double *h0  = new double[Furion::n];
    double *h1  = new double[Furion::n];
    double *delta_Z1  = new double[Furion::n];
    double *delta_Z  = new double[Furion::n];
    double *delta_X  = new double[Furion::n];
    surface->value(h0, this->Z2, this->X2, n);

    for (int i = 0; i < n; i++) 
    {
        delta_Z1[i] = sqrt(this->L1[i]*this->L1[i] + this->N1[i]*this->N1[i]);
        delta_Z[i] = 1e-10 * this->N1[i] * delta_Z1[i] + this->Z2[i];
        delta_X[i] = 1e-10 * this->L1[i] * delta_Z1[i] + this->X2[i];
    }

    surface->value(h1, delta_Z, delta_X, n);

    for (int i = 0; i < n; i++) 
    {
        h_slope[i] = (h1[i]-h0[i]) / 1e-10;
        Y2[i] = h0[i] + Y2[i];
    }

    delete[] h0, h1, delta_Z1, delta_Z, delta_X;
    cout << " G_Oe的h_slope" << endl;

}

void G_Oe::oe_to_image(double *X3, double *Y3, double *Z3, double *L3, double *M3, double *N3, double *X2, double *Y2, double *Z2, double di, double *L2, double *M2, double *N2)
{
    int n = this->n;

    double* OS = new double[9];
    double *OS_0 = new double[9];
    double *OS_1 = new double[9]; 

    f_rx.furion_rotx(this->theta2, OS_0);
    matrixMulti(X3, Y3, Z3, OS_0, X2, Y2, Z2, -di, n);
    //for (int i = 0; i < n; i++) {Z3[i] = Z3[i] -di;}

    f_rz.furion_rotz(-1 * this->chi, OS_0);
    f_rx.furion_rotx(this->theta2, OS_1);
    matrixMulti33(OS, OS_0, OS_1);
    matrixMulti(L3, M3, N3, OS, L2, M2, N2, 0, n);

    cout << " G_Oe的oe_to_image" << endl;

    delete[] OS, OS_0, OS_1;
}
