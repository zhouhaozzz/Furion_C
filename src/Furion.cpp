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
#include "Furion_cylinder_ellipse_Mirror.h"


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
	no_surfe = new No_Surfe();
	Surfefile_From_Shadow* surfM1 = new Surfefile_From_Shadow("G_shadow.dat");
	//Surfefile_From_Shadow* surfM5 = new Surfefile_From_Shadow("M5_shadow03.dat");
	//Surfefile_From_Shadow* surG = new Surfefile_From_Shadow("G_shadow03.dat");

	double wavelength = 1.e-9;

	grating = new Grating(230.e3, 2.0984e-2, 0., wavelength);

	source = new Source(4.e-3, N, 42.78e-6, 1.e-9);
	Beam* b2 = source->beam_out(); 
	Beam b3 = b2->translate(186); //delete b2;

	//Furion_plane_Mirror = new Furion_Plane_Mirror(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	//Furion_plane_Mirror->run(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	//Beam b5 = Furion_plane_Mirror->beam_out->translate(10);
	
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			//cout << b5.field[i][j] << "  ";
		}
		//cout << endl;
	}

	Furion_cylinder_ellipse_Mirror = new Furion_Cylinder_Ellipse_Mirror(&b3, 0., 0., 270., 12.e-3, no_surfe, 196, 98, grating, 0);
	Furion_cylinder_ellipse_Mirror->run(&b3, 0., 0., 270., 12.e-3, no_surfe, 196, 98, grating, 0);

	cout << Furion_cylinder_ellipse_Mirror->beam_out->X[0][0] << endl;
	//Beam b6 = 
	//cout << boost::math::fabs(std::complex(3, 100)) << endl;

	//delete this->Furion_plane_Mirror;

#endif // !WAVE


}

Furion::~Furion()
{
	cout << "Furion的析构" << endl;
}

void Furion_NS::reshape(double** output, double* input, int x, int y)
{
	for (int i = 0; i < x; ++i)
	{
		for (int j = 0; j < y; ++j)
		{
			int index = i + j * x;
			output[i][j] = input[index];
		}
	}
}

void Furion_NS::interp2(double* Vq, double* X, double* Y, double** V, double* x, double* y, int n, int nx, int ny, string Type)
{
	const gsl_interp2d_type* T;
	if (Type == "liner") {
		T = gsl_interp2d_bilinear;
	}
	else if (Type == "cubic")
	{
		T = gsl_interp2d_bicubic;
	}
	else
	{
		cout << Type << " interpolation type does not exist, you can select: liner and cubic" << endl;
		exit(0);
	}
	//const size_t nx = this->numRows;
	//const size_t ny = this->numCols;

	double* za = new double[nx * ny];


	gsl_spline2d* spline = gsl_spline2d_alloc(T, nx, ny);
	gsl_interp_accel* xacc = gsl_interp_accel_alloc();
	gsl_interp_accel* yacc = gsl_interp_accel_alloc();

	/* set z grid values */
	for (int i = 0; i < nx; i++)
	{
		for (int j = 0; j < ny; j++)
		{
			gsl_spline2d_set(spline, za, i, j, V[i][j]);
		}
	}

	/* initialize interpolation */
	gsl_spline2d_init(spline, Y, X, za, nx, ny);

	/* interpolate N values in x and y and print out grid for plotting */
	for (int i = 0; i < n * n; i++)
	{
		Vq[i] = gsl_spline2d_eval(spline, y[i], x[i], xacc, yacc);
		//cout << x[i] << "  ";
	}
	//cout << endl;

	gsl_spline2d_free(spline);
	gsl_interp_accel_free(xacc);
	gsl_interp_accel_free(yacc);

	destory_1d(za);
}

void Furion_NS::interp2_1(double* Vq, double* X, double* Y, double* V, double* x, double* y, int n, int nx, int ny, string Type)
{
	const gsl_interp2d_type* T;
	if (Type == "liner") {
		T = gsl_interp2d_bilinear;
	}
	else if (Type == "cubic")
	{
		T = gsl_interp2d_bicubic;
	}
	else
	{
		cout << Type << " interpolation type does not exist, you can select: liner and cubic" << endl;
		exit(0);
	}
	//const size_t nx = this->numRows;
	//const size_t ny = this->numCols;

	double* za = new double[nx * ny];


	gsl_spline2d* spline = gsl_spline2d_alloc(T, nx, ny);
	gsl_interp_accel* xacc = gsl_interp_accel_alloc();
	gsl_interp_accel* yacc = gsl_interp_accel_alloc();

	/* set z grid values */
	for (int i = 0; i < nx; i++)
	{
		for (int j = 0; j < ny; j++)
		{
			gsl_spline2d_set(spline, za, i, j, V[i * ny + j]);
		}
		
	}
	//exit(0);

	double xx[5] = { -0.002,-0.001,0,0.001,0.002 };
	double yy[5] = {-0.002,-0.001,0,0.001,0.002};

	/* initialize interpolation */
	gsl_spline2d_init(spline, Y, X, za, nx, ny);
	//exit(0);

	/* interpolate N values in x and y and print out grid for plotting */
	for (int i = 0; i < nx; i++)
	{
		for (int j = 0; j < ny; j++)
		{
			Vq[i * nx + j] = gsl_spline2d_eval(spline, y[i], x[j], xacc, yacc);
		}
	}
	//exit(0);
	gsl_spline2d_free(spline);
	gsl_interp_accel_free(xacc);
	gsl_interp_accel_free(yacc);

	destory_1d(za);
}

void Furion_NS::linspace(double* x, double min, double max, int N)
{
	double step = (max - min) / (N - 1);
	for (int i = 0; i < N; i++)
	{
		x[i] = min + i * step;
	}
}

//散点插值，在数据范围外插值失效，待改进
void Furion_NS::scatteredInterpolant(double* result, double* X, double* Y, double* X_, double* Y_, double* value, int N)
{
#ifdef CGAL_INTER
	typedef CGAL::Exact_predicates_inexact_constructions_kernel K;
	typedef CGAL::Delaunay_triangulation_2<K>                   Delaunay_triangulation;
	typedef CGAL::Interpolation_traits_2<K>                     Traits;
	typedef K::FT                                               Coord_type;
	typedef K::Point_2                                          Point;
	typedef std::map<Point, Coord_type, K::Less_xy_2>         Coord_map;
	typedef CGAL::Data_access<Coord_map>                      Value_access;

	Delaunay_triangulation T;
	Coord_map value_function;

	int N2 = N * N;
	for (int i = 0; i < N2; ++i)
	{
		K::Point_2 p(X_[i], Y_[i]);
		T.insert(p);
		value_function.insert(std::make_pair(p, value[i]));
	}

	double X_min = X_[0];
	double X_max = X_[N2];
	double Y_min = Y_[0];
	double Y_max = Y_[N2];

	for (int i = 0; i < N2; ++i)
	{
		Coord_type res;
		if (X[i] > X_min && X[i] < X_max && Y[i] > Y_min && Y[i] > Y_[0] < Y_max)
		{
			K::Point_2 p(X[i], Y[i]);
			std::vector<std::pair<Point, Coord_type> > coords;
			Coord_type norm = CGAL::natural_neighbor_coordinates_2(T, p, std::back_inserter(coords)).second;
			res = CGAL::linear_interpolation(coords.begin(), coords.end(), norm, Value_access(value_function));
			result[(i % N) * N + int(i / N)] = CGAL::to_double(res);
		}
		else
		{
			result[(i % N) * N + int(i / N)] = value[i];
		}
	}

#else
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			result[i + j * N] = value[i * N + j];
		}
	}

#endif

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