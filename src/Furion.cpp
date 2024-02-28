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
	No_Surfe* no_surfe = new No_Surfe();
	Surfefile_From_Shadow* surfM1 = new Surfefile_From_Shadow("G_shadow.dat");
	//Surfefile_From_Shadow* surfM5 = new Surfefile_From_Shadow("M5_shadow03.dat");
	//Surfefile_From_Shadow* surG = new Surfefile_From_Shadow("G_shadow03.dat");

	//Surfefile_From_Shadow ss = Surfefile_From_Shadow("G_shadow.dat");

	double wavelength = 1.e-9;

	Grating* grating = new Grating(230.e3, 2.0984e-2, 0., wavelength);

	Source source = Source(4.e-3, N, 42.78e-6, 1.e-9);
	Beam b2 = source.beam_out(); 
	Beam b3 = b2.translate(186); //delete b2;

	Beam bb = b2.resize1(0.004);

	//destory_2d(bb.kk, this->N);
	//delete bb;

	//b2.destory();

	Furion_Plane_Mirror* Furion_plane_Mirror = new Furion_Plane_Mirror(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	Furion_plane_Mirror->run(&b3, 0., 0., 90., 12.e-3, surfM1, grating);
	//Beam b5 = Furion_plane_Mirror->beam_out->translate(10);
	
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			//cout << b5.field[i][j] << "  ";
		}
		//cout << endl;
	}

	//Furion_Cylinder_Ellipse_Mirror* Furion_cylinder_ellipse_Mirror = new Furion_Cylinder_Ellipse_Mirror(&b3, 0., 0., 270., 12.e-3, no_surfe, 196, 98, grating, 0);
	//Furion_cylinder_ellipse_Mirror->run(&b3, 0., 0., 270., 12.e-3, no_surfe, 196, 98, grating, 0);

	//cout << Furion_cylinder_ellipse_Mirror->beam_out->X[0][0] << endl;
	//Beam b6 = 
	//cout << boost::math::fabs(std::complex(3, 100)) << endl;
	//delete Furion_cylinder_ellipse_Mirror->beam_in;
	//delete this->Furion_plane_Mirror;

	//delete surfM1;

#endif // !WAVE


}

Furion::~Furion()
{
	cout << "Furion的析构" << endl;
}

void Furion_NS::reshape(std::vector<std::vector<double> >& output, std::vector<double>& input, int x, int y)
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

void Furion_NS::interp2(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, std::vector<std::vector<double> >& V, std::vector<double>& x, std::vector<double>& y, int n, int nx, int ny, string Type)
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
	double* X_ptr = X.data();
	double* Y_ptr = Y.data();


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
	gsl_spline2d_init(spline, Y_ptr, X_ptr, za, nx, ny);

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

void Furion_NS::interp2_1(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& V, std::vector<double>& x, std::vector<double>& y, int n, int nx, int ny, string Type)
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
	double* X_ptr = X.data();
	double* Y_ptr = Y.data();

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
	gsl_spline2d_init(spline, Y_ptr, X_ptr, za, nx, ny);
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

void Furion_NS::linspace(std::vector<double>& x, double min, double max, int N)
{
	double step = (max - min) / (N - 1);
	for (int i = 0; i < N; i++)
	{
		x[i] = min + i * step;
	}
}

//散点插值，在数据范围外插值失效，待改进
void Furion_NS::scatteredInterpolant(std::vector<double>& result, std::vector<double>& X, std::vector<double>& Y, std::vector<double>& X_, std::vector<double>& Y_, std::vector<double>& value, int N)
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

int Furion_NS::point_inside_triangle(double x[4], double y[4])
{
	double a = (x[2] - x[1]) * (y[0] - y[1]) - (y[2] - y[1]) * (x[0] - x[1]);
	double b = (x[3] - x[2]) * (y[0] - y[2]) - (y[3] - y[2]) * (x[0] - x[2]);
	double c = (x[1] - x[3]) * (y[0] - y[3]) - (y[1] - y[3]) * (x[0] - x[3]);

	if ((a >= 0 && b >= 0 && c >= 0) || (a < 0 && b < 0 && c < 0))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

void Furion_NS::scatteredInterpolant_2d_complex(std::vector<std::vector<std::complex<double>> >& result, std::vector<double>& X, std::vector<double>& Y, std::vector<std::vector<double> >& X_, std::vector<std::vector<double> >& Y_, std::vector<std::vector<std::complex<double>> >& value, int N)
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
	//for (int i = 0; i < N; i++)
	//{
	//	for (int j = 0; j < N; j++)
	//	{
	//		if (i>0)
	//	}
	//}
	
	
	
	for (int i = 0; i < N; i++)
	{
		//if ()
		for (int j = 0; j < N; j++)
		{
			result[i][j] = value[i][j];
		}
	}

#endif

}


double Furion_NS::Max(std::vector<double>& X, int n)
{
	double max = X[0];
	for (int i = 1; i < n; i++)
	{
		if (X[i] > max)
		{
			max = X[i];
		}
	}

	//double max_it = std::max_element(X.begin(), X.end());

	return max;
}

double Furion_NS::Min(std::vector<double>& X, int n)
{
	double min = X[0];
	for (int i = 1; i < n; i++)
	{
		if (X[i] < min)
		{
			min = X[i];
		}
	}

	return min;
}

void Furion_NS::FFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N)
{
	fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * N * N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			data[i * N + j][0] = field[i][j].real();
			data[i * N + j][1] = field[i][j].imag();
		}
	}

	fftw_plan plan = fftw_plan_dft_2d(N, N, data, data, FFTW_FORWARD, FFTW_ESTIMATE);
	fftw_execute(plan);

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[i][j] = std::complex<double>(data[i * N + j][0], data[i * N + j][1]);
		}
	}

	fftw_destroy_plan(plan);
	fftw_free(data);
}

void Furion_NS::iFFTW2(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N)
{
	fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * N * N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			data[i * N + j][0] = field[i][j].real();
			data[i * N + j][1] = field[i][j].imag();
		}
	}

	fftw_plan plan = fftw_plan_dft_2d(N, N, data, data, FFTW_BACKWARD, FFTW_ESTIMATE);
	fftw_execute(plan);

	double N2 = N * N;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[i][j] = std::complex<double>(data[i * N + j][0] / N2, data[i * N + j][1] / N2);
		}
	}

	fftw_destroy_plan(plan);
	fftw_free(data);
}

void Furion_NS::FFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N)
{
	int N2 = N / 2;

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[(i + N2) % N][(j + N2) % N] = field[i][j];
		}
	}
}

void Furion_NS::iFFTshift(std::vector<std::vector<std::complex<double>> >& output, std::vector<std::vector<std::complex<double>> >& field, int N)
{
	int N2 = N / 2 + 1;

	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			output[(i + N2) % N][(j + N2) % N] = field[i][j];
		}
	}
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