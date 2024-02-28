#include "Furion_bisection.h"

using namespace Furion_NS;

Furion_Bisection::Furion_Bisection()
{

}

Furion_Bisection::~Furion_Bisection()
{

}

void Furion_Bisection::Furion_bisection(double& x1, double& y1, double& z1, double& error_Final, double& t_Final, double t_Min, double t_Max, double x0, double y0, double z0, double l0, double m0, double n0, double epsilon, double R, double rho, int n)
{
    std::vector<double> p_Min(3);
    std::vector<double> p_Max(3);
    p_Min[0] = x0 + t_Min * l0;
    p_Min[1] = y0 + t_Min * m0;
    p_Min[2] = z0 + t_Min * n0;
    p_Max[0] = x0 + t_Max * l0;
    p_Max[1] = y0 + t_Max * m0;
    p_Max[2] = z0 + t_Max * n0;

    double rho_Error_min, rho_Error_max;
    rho_Error_min = std::sqrt((p_Min[0] * p_Min[0])) + std::pow((std::sqrt((p_Min[2] * p_Min[2]) + (p_Min[1] * p_Min[1])) - R + rho), 2) - rho;
    rho_Error_max = std::sqrt((p_Max[0] * p_Max[0])) + std::pow((std::sqrt((p_Max[2] * p_Max[2]) + (p_Max[1] * p_Max[1])) - R + rho), 2) - rho;

    double t_Mid, rho_Error_mid;
    std::vector<double> p_Mid(3);
    t_Final = 0;
    error_Final = 0;
    t_Mid = (t_Max + t_Min) / 2;
    p_Mid[0] = x0 + t_Mid * l0;
    p_Mid[1] = y0 + t_Mid * m0;
    p_Mid[2] = z0 + t_Mid * n0;
    rho_Error_mid = std::sqrt((p_Mid[0] * p_Mid[0])) + std::pow((std::sqrt((p_Mid[2] * p_Mid[2]) + (p_Mid[1] * p_Mid[1])) - R + rho), 2) - rho;

    while (1)
    {
        if (rho_Error_min == 0)
        {
            t_Final = t_Min;
            error_Final = 0;
            break;
        }
        else if (rho_Error_max == 0)
        {
            t_Final = t_Max;
            error_Final = 0;
            break;
        }
        else if (rho_Error_mid == 0)
        {
            t_Final = t_Mid;
            error_Final = 0;
            break;
        }
        else if (std::abs(rho_Error_max) < epsilon)
        {
            t_Final = t_Max;
            error_Final = rho_Error_max;
            break;
        }
        else
        {
            t_Max = t_Mid;
            rho_Error_max = rho_Error_mid;

            if (rho_Error_mid <= 0)
            {
                t_Min = t_Mid;
                rho_Error_min = rho_Error_mid;
            }
            else
            {
                t_Max = t_Mid;
                rho_Error_max = rho_Error_mid;
            }
        }

        t_Mid = (t_Min + t_Max) / 2;
    }

    x1 = x0 + t_Final * l0;
    y1 = y0 + t_Final * m0;
    z1 = z0 + t_Final * n0;
}