#include "Furion_Vector_Angle.h"

using namespace Furion_NS;

Furion_Vector_Angle::Furion_Vector_Angle()
{

}

Furion_Vector_Angle::~Furion_Vector_Angle()
{

}
void Furion_Vector_Angle::Furion_vector_angle(double *Phi, double *Psi, double *L, double *M, int n)
{
    //int n = Furion::n;

    for (int i = 0; i < n; i++)
    {
        Psi[i] = asin(M[i]);
        Phi[i] = asin(L[i]/cos(Psi[i]));
    }
}