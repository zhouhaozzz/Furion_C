#include "Furion_Angle_Vector.h"

using namespace Furion_NS;

Furion_Angle_Vector::Furion_Angle_Vector()
{

}

Furion_Angle_Vector::~Furion_Angle_Vector()
{
    
}

void Furion_Angle_Vector::Furion_angle_vector(std::vector<double>& Phi, std::vector<double>& Psi, std::vector<double>& L, std::vector<double>& M, std::vector<double>& N, int n)
{
    for (int i = 0; i < n; i++)
    {
        L[i] = sin(Phi[i]) * cos(Psi[i]);
        M[i] = sin(Psi[i]);
        N[i] = cos(Phi[i]) * cos(Psi[i]);
    }
}

void Furion_Angle_Vector::Furion_angle_vector(std::vector<std::vector<double> >& Phi, std::vector<std::vector<double> >& Psi, std::vector<std::vector<double> >& L, std::vector<std::vector<double> >& M, std::vector<std::vector<double> >& N, int n1, int n2)
{
    for (int i = 0; i < n1; i++)
    {
        for (int j = 0; j < n2; j++)
        {
            L[i][j] = sin(Phi[i][j]) * cos(Psi[i][j]);
            M[i][j] = sin(Psi[i][j]);
            N[i][j] = cos(Phi[i][j]) * cos(Psi[i][j]);
        }
        
    }
}




