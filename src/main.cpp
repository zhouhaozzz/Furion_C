#include "Furion.h"
#include <chrono>
// #include <mpi.h>
//#include <Eigen/Dense>

using namespace Furion_NS;

int main(int argc, char* argv[])
{
    auto start = std::chrono::high_resolution_clock::now();
    srand((unsigned)time(NULL));

    int rank = 0;
    int size = 1;

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