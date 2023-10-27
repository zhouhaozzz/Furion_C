#include "g_furion_hole.h"

using namespace Furion_NS;

G_Furion_Hole::G_Furion_Hole(G_Beam* beam_in, double center_x, double center_y, double r)
    //: beam_out(beam_in)
{
    cout << "��ʼ��G_Furion_Hole" << endl;
    int n = beam_in->n;

    beam_out = new G_Beam(beam_in->XX, beam_in->YY, beam_in->phi, beam_in->psi, beam_in->lambda, n);
    
    int Count = 0;
    for (int i = 0; i < n; i++)
    {
        if (sqrt((beam_in->XX[i] - center_x) * (beam_in->XX[i] - center_x) + (beam_in->YY[i] - center_y) * (beam_in->YY[i] - center_y)) < r)
        {
            beam_out->XX[Count] = beam_in->XX[i];
            beam_out->YY[Count] = beam_in->YY[i];
            beam_out->phi[Count] = beam_in->phi[i];
            beam_out->psi[Count] = beam_in->psi[i];
            Count = Count + 1;
        }
    }
    beam_out->n = Count;
    beam_in->n = Count;
    //cout << Count << endl;

    for (int i = Count; i < n; i++)
    {
        beam_out->XX[i] = 0;
        beam_out->YY[i] = 0;
        beam_out->phi[i] = 0;
        beam_out->psi[i] = 0;
    }
}

G_Furion_Hole::~G_Furion_Hole()
{
    delete beam_out;
    cout << "G_Furion_Hole ����" << endl;
}

