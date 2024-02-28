#include "g_Furion_slits.h"

using namespace Furion_NS;

G_Furion_Slits::G_Furion_Slits(G_Beam* beam_in, double center_x, double center_y, double width, double height)
    //: beam_out(beam_in)
{
    cout << "³õÊ¼»¯G_Furion_Slits" << endl;
    int n = beam_in->n;

    beam_out = new G_Beam(beam_in->XX, beam_in->YY, beam_in->phi, beam_in->psi, beam_in->lambda, n);
    
    for (int i = 0; i < n; i++)
    {
        if (!(std::abs(beam_in->XX[i] - center_x) < width / 2 && std::abs(beam_in->YY[i] - center_y) < height / 2))
        {
            beam_out->XX[i] = 0;
            beam_out->YY[i] = 0;
            beam_out->phi[i] = 0;
            beam_out->psi[i] = 0;
        }
    }
    //cout << Count << endl;
}

G_Furion_Slits::~G_Furion_Slits()
{
    delete beam_out;
    cout << "G_Furion_Hole Îö¹¹" << endl;
}

