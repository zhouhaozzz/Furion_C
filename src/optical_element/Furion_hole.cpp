#include "Furion_hole.h"

using namespace Furion_NS;

Furion_Hole::Furion_Hole()
{
    cout << "Furion_Hole ³õÊ¼»¯" << endl;
}

Furion_Hole::~Furion_Hole()
{

}

void Furion_Hole::Furion_hole(Beam* beam_in, std::vector<std::vector<double> >& center_x, std::vector<std::vector<double> >& center_y, double r, int N)
{
	double r2 = r * r;
	std::vector<std::vector<std::complex<double>> > V;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			if (std::pow((beam_in->X[i][j] - center_x[i][j]) * (beam_in->X[i][j] - center_x[i][j]) + (beam_in->Y[i][j] - center_y[i][j]) * (beam_in->Y[i][j] - center_y[i][j]), 2) < r2)
			{
				V[i][j] = beam_in->field[i][j];
			}
			else
			{
				V[i][j] = std::complex<double>(0, 0);
			}
		}
	}

	beam_out = new Beam(beam_in->X, beam_in->Y, V, beam_in->wavelength, beam_in->N);
}



