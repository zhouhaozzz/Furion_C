#include "Furion_angle_To_angle.h"

using namespace Furion_NS;

Furion_Angle_To_Angle::Furion_Angle_To_Angle()
{

}

Furion_Angle_To_Angle::~Furion_Angle_To_Angle()
{
    
}

void Furion_Angle_To_Angle::Furion_angle_To_angle(std::vector<double>& X1, std::vector<double>& Y1, std::vector<double>& PHI, std::vector<double>& PSI, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& Phi, std::vector<double>& Psi, int n)
{
    for (int i = 0; i < n; i++)
    {
        PHI[i] = Phi[i];
        PSI[i] = std::atan(std::tan(Psi[i]) / std::cos(Phi[i]));
        X1[i] = X[i];
        Y1[i] = Y[i];
    }
}

void Furion_Angle_To_Angle::Furion_angle_To_angle(std::vector<std::vector<double> >& X1, std::vector<std::vector<double> >& Y1, std::vector<std::vector<double> >& PHI, std::vector<std::vector<double> >& PSI, std::vector<std::vector<double> >& X, std::vector<std::vector<double> >& Y, std::vector<std::vector<double> >& Phi, std::vector<std::vector<double> >& Psi, int n1, int n2)
{
    for (int i = 0; i < n1; i++)
    {
        for (int j = 0; j < n2; j++)
        {
            PHI[i][j] = Phi[i][j];
            PSI[i][j] = std::atan(std::tan(Psi[i][j]) / std::cos(Phi[i][j]));
            X1[i][j] = X[i][j];
            Y1[i][j] = Y[i][j];
        }
    }
}




