#include "g_source.h"
#include "g_beam.h"
#include <chrono>
using namespace Furion_NS;

G_Source::G_Source(double sigma_beamsize, double sigma_divergence, int n, double lambda, int rank1) : beam_out(XX, YY, phi, psi, lambda, n)
{
    cout << "G_Source�ĳ�ʼ��" << endl;
    this->XX = new double[beam_out.n];
    this->YY = new double[beam_out.n];
    this->phi = new double[beam_out.n];
    this->psi = new double[beam_out.n];

    normrnd(this->XX, 0, sigma_beamsize, n, 1, rank1);// Normal random number
    normrnd(this->YY, 0, sigma_beamsize, n, 2, rank1);
    normrnd(this->phi, 0, sigma_divergence, n, 3, rank1);
    normrnd(this->psi, 0, sigma_divergence, n, 4, rank1);

    beam_out = G_Beam(this->XX, this->YY, this->phi, this->psi, lambda, n);
}

G_Source::~G_Source()
{
    destory_1d(XX);
    destory_1d(YY);
    destory_1d(psi);
    destory_1d(phi);
    cout << "G_Source������" << endl;
}

void G_Source::normrnd(double* resultArray, double mu, double sigma_beamsize, int n, int n1, int rank1)
{
    auto now = std::chrono::system_clock::now();
    auto duration = now.time_since_epoch();
    long long int timestamp = duration.count();
    unsigned int seed = static_cast<unsigned int>(rank1+n1) + static_cast<unsigned int>(timestamp);
    std::default_random_engine generator(seed);
    std::normal_distribution<double> distribution(mu, sigma_beamsize);

    // Generate random numbers
    for (int i = 0; i < n; ++i) {
        resultArray[i] = distribution(generator);
    }
}
