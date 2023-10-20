#include "g_tracing_test.h"


using namespace Furion_NS;


int main()
{
    int i = 0;
    double beamsize[5] = { 0.113155108251141,0.134122084191793,0.137907788181078,0.139653456385901,0.145485139180038 };
    for (int i = 0; i < 5; i++)
    {
        beamsize[i] = beamsize[i] * 1e-3 / 2.3548;
    }
    double divergence[5] = { 3.9,4.9731,6.6307,8.2884,9.1 };
    for (int i = 0; i < 5; i++)
    {
        divergence[i] = divergence[i] * 1e-6 / 2.3548;
    }
    double Lambda[5] = { 1,1.55,2,2.5,3 };
    for (int i = 0; i < 5; i++)
    {
        Lambda[i] = Lambda[i] * 1e-9;
    }
    double sigma_beamsize = beamsize[i];
    double sigma_divergence = divergence[i];
    double lambda = Lambda[i];

    int n = 100000;
    G_Source g_source(sigma_beamsize, sigma_divergence, n, lambda, 1);
   // delete g_source.beam_out;
    double theta = 6.397e-3;
    //G_Source* g_source = new G_Source(sigma_beamsize, sigma_divergence, n, lambda,1);
    G_Beam* b1 = g_source.beam_out;
    Grating* g= new Grating(230e3, 2.0984e-2, 1, lambda);
    No_Surfe* s= new No_Surfe();

    G_Beam* b11 = &(b1->translate(217));

    G_Furion_Plane_Mirror* g_plane = new G_Furion_Plane_Mirror(b11, 0, 0, 0.0, theta, s, g);

    G_Beam* b2 = g_plane->beam_out;
    G_Beam b3 = b2->translate(108);

   int N = b3.n;
   /* 
    G_Furion_Hole g_hole(b1, 0, 0, 25e-6, &N);
    G_Beam* b2 = g_hole.beam_out;

    double a = tool_stderr(b2->XX, N);*/

    b3.plot_sigma(0, 0, N);

    //system("C:/Users/hukai/anaconda3/python python_plot/Furion_plot4_6sigma.py");

    cout << "Hello, world!" << endl;
    cout << "Hello, world!11" << endl;
    return 0;


}
