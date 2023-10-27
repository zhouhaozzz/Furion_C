#include "Furion.h"
#include <chrono>
// #include <mpi.h>
//#include <Eigen/Dense>
#include <gsl/gsl_math.h>
#include <gsl/gsl_interp2d.h>
#include <gsl/gsl_spline2d.h>
#include <gsl/gsl_fft_complex.h>
#include <fftw3.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_complex.h>
#include <gsl/gsl_complex_math.h>

using namespace Furion_NS;

void interp2d_test()
{
    const gsl_interp2d_type* T = gsl_interp2d_bilinear;
    const size_t N = 100;             /* number of points to interpolate */
    const double xa[] = { 0.0, 1.0 }; /* define unit square */
    const double ya[] = { 0.0, 1.0 };
    const size_t nx = sizeof(xa) / sizeof(double); /* x grid points */
    const size_t ny = sizeof(ya) / sizeof(double); /* y grid points */
    //double* za = malloc(nx * ny * sizeof(double));
    double* za = new double[nx * ny];
    gsl_spline2d* spline = gsl_spline2d_alloc(T, nx, ny);
    gsl_interp_accel* xacc = gsl_interp_accel_alloc();
    gsl_interp_accel* yacc = gsl_interp_accel_alloc();
    size_t i, j;

    double xx[] = { 0.0, 1.0 };
    double* x1 = new double[2];
    x1[0] = 0.0;
    x1[1] = 1.0;

    /* set z grid values */
    gsl_spline2d_set(spline, za, 0, 0, 0.0);
    gsl_spline2d_set(spline, za, 0, 1, 1.0);
    gsl_spline2d_set(spline, za, 1, 1, 0.5);
    gsl_spline2d_set(spline, za, 1, 0, 1.0);

    /* initialize interpolation */
    gsl_spline2d_init(spline, x1, xx, za, nx, ny);

    /* interpolate N values in x and y and print out grid for plotting */
    for (i = 0; i < N; ++i)
    {
        double xi = i / (N - 1.0);

        for (j = 0; j < N; ++j)
        {
            double yj = j / (N - 1.0);
            double zij = gsl_spline2d_eval(spline, xi, yj, xacc, yacc);

            printf("%f %f %f\n", xi, yj, zij);
        }
        printf("\n");
    }

    gsl_spline2d_free(spline);
    gsl_interp_accel_free(xacc);
    gsl_interp_accel_free(yacc);
    delete[] za;
    //free(za);

}

void fft_2d()
{
    const int rows = 4;
    const int cols = 4;

    fftw_complex* data = (fftw_complex*)fftw_malloc(sizeof(fftw_complex) * rows * cols);

    // 填充示例数据
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            data[i * cols + j][0] = i + j;
            data[i * cols + j][1] = 0.0;
        }
    }

    fftw_plan plan = fftw_plan_dft_2d(rows, cols, data, data, FFTW_FORWARD, FFTW_ESTIMATE);

    // 执行二维FFT
    fftw_execute(plan);

    // 输出频域数据
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            std::cout << "Freq[" << i << "][" << j << "]: " << data[i * cols + j][0] << " + " << data[i * cols + j][1] << "i" << std::endl;
        }
    }

    fftw_destroy_plan(plan);
    fftw_free(data);
}

int main(int argc, char* argv[])
{
    auto start = std::chrono::high_resolution_clock::now();
    srand((unsigned)time(NULL));

    int rank = 0;
    int size = 1;

    //interp2d_test();
    //fft_2d();

    // MPI_Init(0, 0);
    // MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    // MPI_Comm_size(MPI_COMM_WORLD, &size);

    auto furion = new Furion(rank, size);

        //double* h0 = new double[1e8];
    //delete[] h0;
    //double* h_U = (double*)malloc(1e8 * sizeof(double));
    //double

    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Execution time: " << duration.count() / 1e6 << " seconds" << std::endl;

    // MPI_Finalize();

    return 0;
}