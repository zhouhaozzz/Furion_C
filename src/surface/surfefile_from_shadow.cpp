#include "surfefile_from_shadow.h"
#include <gsl/gsl_math.h>
#include <gsl/gsl_interp2d.h>
#include <gsl/gsl_spline2d.h>
//#include <boost/interpolator/linear_interpolator.hpp>
using namespace Furion_NS;

Surfefile_From_Shadow::Surfefile_From_Shadow(const char* EXP_file) : No_Surfe(), numCols(0), numRows(0)
{
    cout << "Surfefile_From_Shadow的初始化" << endl;
    //vector<vector<double>>* meriX_ = new std::vector<std::vector<double>>;
    //vector<vector<double>>* sagY_ = new std::vector<std::vector<double>>;
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
    //meshgrid(meriX_, sagY_, x, y);

    //vector<vector<double>>& Xd = grid.first;
    //vector<vector<double>>& Yd = grid.second; 

    this->numRows = y.size();
    this->numCols = x.size();
    
    this->meri_X = new double [numCols];
    this->sag_Y = new double [numRows];
    this->V = new double* [numRows];

    cout << numRows << " " << numCols<< endl;
    //exit(0);
    for (size_t i = 0; i < numRows; i++) {
        this->sag_Y[i] = y[i];

        this->V[i] = new double[numCols];
        for (size_t j = 0; j < numCols; j++) {
            
            this->V[i][j] = (*(V_))[i][j];
        }

    }

    for (size_t i = 0; i < numCols; i++) {
        this->meri_X[i] = x[i];
    }

    //delete[] V_;

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
    Furion_NS::interp2(Vq, this->meri_X, this->sag_Y, this->V, X, Y, n, this->numRows, this->numCols, "liner");
}


