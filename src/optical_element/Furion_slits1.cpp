#include "Furion_slits1.h"

using namespace Furion_NS;

Furion_Slits1::Furion_Slits1()
{
	cout << "Furion_Slits1 ³õÊ¼»¯" << endl;
}

Furion_Slits1::~Furion_Slits1()
{

}

void Furion_Slits1::Furion_slits1(Beam* beam_in, double center_x, double center_y, double width, double height, int N)
{
    std::vector<std::vector<std::complex<double>> > V;
    int slit_X, slit_Y;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
            slit_X = (std::abs(beam_in->X[i][j] - center_x) <= width / 2) ? 1.0 : 0.0;
            slit_Y = (std::abs(beam_in->Y[i][j] - center_x) <= height / 2) ? 1.0 : 0.0;
            V[i][j] = beam_in->field[i][j] * std::complex<double>(slit_X, 0) * std::complex<double>(slit_Y, 0);
		}
	}

	beam_out = new Beam(beam_in->X, beam_in->Y, V, beam_in->wavelength, beam_in->N);
}
