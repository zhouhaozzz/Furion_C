#include "no_surfe.h"

using namespace Furion_NS;

No_Surfe::No_Surfe()// : meri_X(nullptr), sag_Y(nullptr), V(nullptr)
{
    cout << "No_Surfe�ĳ�ʼ��" << endl;
}

No_Surfe::~No_Surfe()
{
    cout << "No_Surfe������" << endl;
    this->meri_X.clear();
    this->sag_Y.clear();
    this->V.clear();
}

void No_Surfe::value(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, int n)
{
    cout << "No_Surfe de value" << endl;
    for (int i = 0; i < n; i++) 
    {
        Vq[i] = 0;
    }

}