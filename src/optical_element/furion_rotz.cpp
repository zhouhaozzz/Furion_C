#include "Furion_Rotz.h"

using namespace Furion_NS;

Furion_Rotz::Furion_Rotz()
{

}

Furion_Rotz::~Furion_Rotz()
{
    
}

void Furion_Rotz::furion_rotz(double t, double *matrix)
{
    double ct = cos(t * _Pi / 180.0);
    double st = sin(t * _Pi / 180.0);
    double data[9] = {ct, -st, 0, st, ct, 0, 0, 0, 1};

    for (int i = 0; i < 9; i++)
    {
        matrix[i] = data[i];
    }
}
