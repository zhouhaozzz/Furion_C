#include "Furion_Angle_Vector.h"

using namespace Furion_NS;

Furion_Angle_Vector::Furion_Angle_Vector()
{

}

Furion_Angle_Vector::~Furion_Angle_Vector()
{
    
}

void Furion_Angle_Vector::Furion_angle_vector(double* Phi, double* Psi, double* L, double* M, double* N, int n)
{
    //int n = Furion::n;

    for (int i = 0; i < n; i++)
    {
        L[i] = sin(Phi[i]) * cos(Psi[i]);
        M[i] = sin(Psi[i]);
        N[i] = cos(Phi[i]) * cos(Psi[i]);
    }

}




