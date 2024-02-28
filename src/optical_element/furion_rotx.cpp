#include "Furion_Rotx.h"

using namespace Furion_NS;

Furion_Rotx::Furion_Rotx()
{

}

Furion_Rotx::~Furion_Rotx()
{
    
}

void Furion_Rotx::furion_rotx(double t, std::vector<double>& matrix)
{
    double ct = cos(t);
    double st = sin(t);
    double data[9] = {1, 0, 0, 0, ct, -st, 0, st, ct};

    for (int i = 0; i < 9; i++)
    {
        matrix[i] = data[i];
    }
}

