#include "Furion_Plot_Sigma.h"

using namespace Furion_NS;

Furion_Plot_Sigma::Furion_Plot_Sigma()
{

}

Furion_Plot_Sigma::~Furion_Plot_Sigma()
{

}

void Furion_Plot_Sigma::Furion_plot_sigma(std::vector<double>& X, std::vector<double>& Y, std::vector<double>& Phi, std::vector<double>& Psi, int rank1, int n)
{
	ofstream fileout("data/Furion_plot_sigma_" + inttoStr(rank1+1) + ".dat");
	fileout << std::fixed;
	fileout << std::setprecision(15);

	for (int i = 0; i < n; i++)
	{
		fileout << X[i] << " ";
	}
	fileout << "\n";
	for (int i = 0; i < n; i++)
	{
		fileout << Y[i] << " ";
	}
	fileout << "\n";
	for (int i = 0; i < n; i++)
	{
		fileout << Phi[i] << " ";
	}
	fileout << "\n";
	for (int i = 0; i < n; i++)
	{
		fileout << Psi[i] << " ";
	}
	fileout << "\n";

	fileout.close();
}

string Furion_Plot_Sigma::inttoStr(int s)
{
    string c = "";
    int m = s;
    int n=0;

    while(m>0)
    {
        n++;
        m/=10;
    }

    for (int i = 0; i < n; i++)
    {
        c = (char)(s % 10 + 48) + c;
        s /= 10;
    }
    return c;
}