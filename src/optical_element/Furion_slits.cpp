#include "Furion_slits.h"

using namespace Furion_NS;

Furion_Slits::Furion_Slits()
{
	cout << "Furion_Slits ³õÊ¼»¯" << endl;
}

Furion_Slits::~Furion_Slits()
{

}

void Furion_Slits::Furion_slits(Beam* beam_in, double center_x, double center_y, double width, double height, int N)
{
    std::vector<std::vector<std::complex<double>> > V;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			V[i][j] = std::complex<double>(!(std::abs(beam_in->X[i][j] - center_x) < width / 2 && std::abs(beam_in->Y[i][j] - center_y) < height / 2), 0);
		}
	}

	beam_out = new Beam(beam_in->X, beam_in->Y, V, beam_in->wavelength, beam_in->N);
}
