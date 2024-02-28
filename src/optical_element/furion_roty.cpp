#include "Furion_Roty.h"

using namespace Furion_NS;

Furion_Roty::Furion_Roty()
{

}

Furion_Roty::~Furion_Roty()
{
    
}

void Furion_Roty::furion_roty(double t, std::vector<double>& matrix)
{
    double ct = cos(t);
    double st = sin(t);
    double data[9] = {ct, 0, -st, 0, 1, 0, st, 0, ct};

    for (int i = 0; i < 9; i++)
    {
        matrix[i] = data[i];
    }
}

