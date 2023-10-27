#ifdef Geometric
#include "Furion.h"
#include "grating.h"
#include "g_source.h"
#include "g_beam.h"
#include "g_Furion_cylinder_ellipse_Mirror.h"
#include "g_Furion_ellipsoid_Mirror.h"
#include "g_Furion_paraboid_collimation_Mirror.h"
#include "g_Furion_paraboid_focus_Mirror.h"
#include "g_Furion_cyliner_parabolic_focus_Mirror.h"
#include "g_Furion_cyliner_parabolic_collimation_Mirror.h"
#include "g_furion_hole.h"
#include "no_surfe.h"
#include "surfefile_from_shadow.h"
#endif // Geometric

#ifdef WAVE
#include "Furion.h"
#include "grating.h"
#include "beam.h"
#include "Source.h"
#include "no_surfe.h"
#include "surfefile_from_shadow.h"
#include "Furion_plane_Mirror.h"

#endif // WAVE



//#define Pi 3.1415926536
#define E  2.7182818284590

using namespace Furion_NS; //////////

Furion::Furion(int rank1, int size1)
{
	std::cout << std::fixed;
	std::cout << std::setprecision(15);

#ifdef Geometric
	//nn = Furion::n;
	no_surfe = new No_Surfe();
	Surfefile_From_Shadow* surfM1 = new Surfefile_From_Shadow("G_shadow.dat");
	//Surfefile_From_Shadow* surfM5 = new Surfefile_From_Shadow("M5_shadow03.dat");
	//Surfefile_From_Shadow* surG = new Surfefile_From_Shadow("G_shadow03.dat");
	//for (const std::vector<double>& row : *(surG->V)) {
	//	for (double value : row) {
	//		std::cout << value << " ";
	//	}
	//	cout << row.size() << endl;
	//	std::cout << std::endl;
	//}
	//cout << surG->V->size() << endl;

	double wavelength = 1e-8;

	grating = new Grating(230e3, 2.0984e-2, 0, wavelength);

	for (int i = 0; i < sizeof(pre_Mirror_theta) / sizeof(double); i++)
	{
		Lambda[i] = Lambda[i] * 1e-9;
		pre_Mirror_theta[i] = pre_Mirror_theta[i] / 180 * Pi;
		grating_theta[i] = grating_theta[i] * 1e-3;
		beamsize[i] = beamsize[i] * 1e-3 / (2 * sqrt(2 * log(2)));
		divergence[i] = divergence[i] * 1e-6 / (2 * sqrt(2 * log(2)));
	}
	lambda = Lambda[i];
	psigmax = beamsize[i];
	psigmay = beamsize[i];
	vsigmax = divergence[i];
	vsigmay = divergence[i];

	g_source = new G_Source(psigmax, vsigmax, Furion::n, lambda, rank1);
	G_Beam b1 = g_source->beam_out.translate(196);
	//G_Beam b1 = g_source->beam_out;

	for (int i = 0; i < size1; i++)
	{
		if (i % size1 == rank1)
		{
			//g_Furion_cylinder_ellipse_Mirror = new G_Furion_Cylinder_Ellipse_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);
			//g_Furion_cylinder_ellipse_Mirror->run(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

			//g_Furion_ellipsoid_Mirror = new G_Furion_ellipsoid_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);
			//g_Furion_ellipsoid_Mirror->run(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

			//g_Furion_hole = new G_Furion_Hole(&b1, 0, 0, 25e-6);
			//cout << b1.n << endl;

			//g_Furion_paraboid_collimation_Mirror = new G_Furion_Paraboid_Collimation_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

			//g_Furion_paraboid_focus_Mirror = new G_Furion_Paraboid_Focus_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

			//g_Furion_cyliner_parabolic_collimation_Mirror = new G_Furion_Cyliner_Parabolic_Collimation_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);
			//g_Furion_cyliner_parabolic_collimation_Mirror->run(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

			//g_Furion_cyliner_parabolic_focus_Mirror = new G_Furion_Cyliner_Parabolic_Focus_Mirror(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);
			//g_Furion_cyliner_parabolic_focus_Mirror->run(&b1, 0, 0, 0, 7e-3, no_surfe, 196, 98, grating);

		}
	}

	// MPI_Barrier(MPI_COMM_WORLD);
	for (int i = 0; i < size1; i++)
	{
		//if (i % size1 == rank1) {G_Beam* b2 = g_Furion_cylinder_ellipse_Mirror->beam_out; b2->plot_sigma(0, rank1);}
		//if (i % size1 == rank1) {G_Beam* b2 = g_Furion_ellipsoid_Mirror->beam_out; b2->plot_sigma(98, rank1);}
		//if (i % size1 == rank1) { G_Beam* b2 = g_Furion_hole->beam_out; b2->plot_sigma(0, rank1); }
		//if (i % size1 == rank1) { G_Beam* b2 = g_Furion_paraboid_collimation_Mirror->beam_out; b2->plot_sigma(98, rank1); }
		//if (i % size1 == rank1) {G_Beam* b2 = g_Furion_paraboid_focus_Mirror->beam_out; b2->plot_sigma(185, rank1);}
		//if (i % size1 == rank1) { G_Beam* b2 = g_Furion_cyliner_parabolic_collimation_Mirror->beam_out; b2->plot_sigma(98, rank1); }
		//if (i % size1 == rank1) {G_Beam* b2 = g_Furion_cyliner_parabolic_focus_Mirror->beam_out; b2->plot_sigma(98, rank1);}
	}

	if (0)
	{
		std::string inputString = std::to_string(size1);
		std::string command = ("python python_plot/Furion_plot4_6sigma.py " + inputString);
		int returnCode = system(command.c_str());
		if (returnCode != 0)
		{
			std::cerr << "Python drawing script execution failed!" << std::endl;
		}
	}
#endif // !Geometric

#ifdef WAVE
	//no_surfe = new No_Surfe();
	Surfefile_From_Shadow* surfM1 = new Surfefile_From_Shadow("G_shadow.dat");
	//Surfefile_From_Shadow* surfM5 = new Surfefile_From_Shadow("M5_shadow03.dat");
	//Surfefile_From_Shadow* surG = new Surfefile_From_Shadow("G_shadow03.dat");

	double wavelength = 1.e-9;

	grating = new Grating(230.e3, 2.0984e-2, 0., wavelength);

	source = new Source(4.e-3, N, 42.78e-6, 1.e-9);
	Beam* b2 = source->beam_out(); 
	Beam b3 = b2->translate(186); //delete b2;

	Furion_plane_Mirror = new Furion_Plane_Mirror(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	Furion_plane_Mirror->run(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	Beam b5 = Furion_plane_Mirror->beam_out->translate(10);
	
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			cout << b3.field[i][j] << "  ";
		}
		cout << endl;
	}

	//delete this->Furion_plane_Mirror;

#endif // !WAVE


}

Furion::~Furion()
{
	cout << "FurionµÄÎö¹¹" << endl;
}

//ofstream fileout("data.dat");
//fileout << std::fixed;
//fileout << std::setprecision(15);
//
//for (int i = 0; i < Furion::n; i++)
//{
//	fileout << X[i] << " ";
//}
//fileout << "\n";
//for (int i = 0; i < Furion::n; i++)
//{
//	fileout << Y[i] << " ";
//}
//fileout << "\n";
//for (int i = 0; i < Furion::n; i++)
//{
//	fileout << Phi[i] << " ";
//}
//fileout << "\n";
//for (int i = 0; i < Furion::n; i++)
//{
//	fileout << Psi[i] << " ";
//}
//fileout << "\n";
//fileout.close();
//exit(0);