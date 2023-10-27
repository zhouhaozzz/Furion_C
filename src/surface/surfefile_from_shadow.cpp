#include "surfefile_from_shadow.h"
#include <gsl/gsl_math.h>
#include <gsl/gsl_interp2d.h>
#include <gsl/gsl_spline2d.h>
//#include <boost/interpolator/linear_interpolator.hpp>
using namespace Furion_NS;

Surfefile_From_Shadow::Surfefile_From_Shadow(const char* EXP_file) : No_Surfe(), numCols(0), numRows(0)
{
    cout << "Surfefile_From_Shadow的初始化" << endl;
    vector<vector<double>>* meriX_ = new std::vector<std::vector<double>>;
    vector<vector<double>>* sagY_ = new std::vector<std::vector<double>>;
    vector<vector<double>>* V_ = new std::vector<std::vector<double>>;
    
    ifstream filein;
    filein.open(EXP_file);//导入数据
    if (filein.fail())
    {
        cout << "read " << EXP_file << " failed" << endl;
        exit(0);
    }

    //int File_line = Furion::surfefile_from_shadow::CountLine(EXP_file);//Gets the number of file lines
    vector<double> x, y, x0, y0;
    vector<vector<double>> data, data1, data2, data3;
    string line;
    while (getline(filein, line)) {
        istringstream iss(line);
        vector<double> row;
        double value;
        while (iss >> value) {
            row.push_back(value);
        }
        data.push_back(row);
    }

    filein.close();

    //cout << array2D.size();
    for (size_t i = 1; i < data.size(); ++i) //Remove first row of data
    {
        data1.push_back(data[i]);
    }
    x = data1[0]; //Get the meridian coordinates
    x.pop_back(); //Drop the last number

    for (size_t i = 1; i < data1.size(); ++i) //Remove first row of data
    {
        data2.push_back(data1[i]);
        y.push_back(data1[i][0]);
    }

    for (const auto& row : data2) {
        vector<double> newRow;
        for (size_t j = 1; j < row.size(); ++j) {
            newRow.push_back(row[j]);
        }
        (V_)->push_back(newRow);
    }

    //pair<vector<vector<double>>, vector<vector<double>>> grid = meshgrid(this->meri_X, this->sag_Y, x, y);
    meshgrid(meriX_, sagY_, x, y);

    //vector<vector<double>>& Xd = grid.first;
    //vector<vector<double>>& Yd = grid.second; 

    this->numRows = (meriX_)->size();
    this->numCols = (*(meriX_))[0].size();
    
    this->meri_X = new double* [numRows];
    this->sag_Y = new double* [numRows];
    this->V = new double* [numRows];

    for (size_t i = 0; i < numRows; i++) {
        this->meri_X[i] = new double[numCols];
        this->sag_Y[i] = new double[numCols];
        this->V[i] = new double[numCols];
        for (size_t j = 0; j < numCols; j++) {
            this->meri_X[i][j] = (*(meriX_))[i][j];
            this->sag_Y[i][j] = (*(sagY_))[i][j];
            this->V[i][j] = (*(V_))[i][j];
        }
    }

    cout << numRows << " " << numCols << endl;
   // exit(0);
}

Surfefile_From_Shadow::~Surfefile_From_Shadow()
{
    cout << "Surfefile_From_Shadow的析构" << endl;
}

void Surfefile_From_Shadow::meshgrid(vector<vector<double>>* X, vector<vector<double>>* Y, const vector<double>& x, const std::vector<double>& y)
{
    size_t xSize = x.size();
    size_t ySize = y.size();

    for (size_t i = 0; i < ySize; ++i) 
    {
        X->push_back(x);
    }

    for (size_t i = 0; i < ySize; ++i)
    {
        vector<double> newRowX;
        for (size_t j = 0; j < xSize; ++j)
        {
            newRowX.push_back(y[i]);
        }
        Y->push_back(newRowX);
    }
}

int Surfefile_From_Shadow::CountLine(const char* filename)
{
    ifstream ReadFile;
    int n = 0;
    string tmp;
    ReadFile.open(filename, ios::in);
    if (ReadFile.fail())
    {
        return 0;
    }
    else
    {
        while (getline(ReadFile, tmp, '\n'))
        {
            n++;
        }
        ReadFile.close();
        return n;
    }
}

void Surfefile_From_Shadow::value(double *Vq, double *X, double *Y, int n)
{
    cout << "Surfefile_From_Shadow de value" << endl;
    interp2(Vq, this->meri_X, this->sag_Y, this->V, X, Y, n);
}

int Surfefile_From_Shadow::interp2(double* Vq, double** X, double** Y, double** V, double* x, double* y, int n)
{
    const gsl_interp2d_type* T = gsl_interp2d_bilinear;

    const size_t nx = this->numRows;
    const size_t ny = this->numCols;

    double* xa = new double[nx];
    double* ya = new double[ny];
    double* za = new double[nx * ny];

    for (int i = 0; i < nx; i++)
    {
        xa[i] = Y[i][0];
    }
    for (int i = 0; i < ny; i++)
    {
        ya[i] = X[0][i];
    }
    
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
    gsl_spline2d_init(spline, xa, ya, za, nx, ny);

    /* interpolate N values in x and y and print out grid for plotting */
    for (int i = 0; i < n*n; i++)
    {
        Vq[i] = gsl_spline2d_eval(spline, y[i], x[i], xacc, yacc);
    }

    
    gsl_spline2d_free(spline);
    gsl_interp_accel_free(xacc);
    gsl_interp_accel_free(yacc);

    destory_1d(xa);
    destory_1d(ya);
    destory_1d(za);
     
    return 0;
}
