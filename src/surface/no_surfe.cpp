#include "no_surfe.h"

using namespace Furion_NS;

No_Surfe::No_Surfe() : meri_X(nullptr), sag_Y(nullptr), V(nullptr), adress(nullptr)
{

}

No_Surfe::~No_Surfe()
{
   
}

void No_Surfe::value(double *Vq, double *Z, double *X, int n)
{
    for (int i = 0; i < n; i++) 
    {
        Vq[i] = 0;
    }

}