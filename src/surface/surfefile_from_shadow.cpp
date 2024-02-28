#include "surfefile_from_shadow.h"
#include <gsl/gsl_math.h>
#include <gsl/gsl_interp2d.h>
#include <gsl/gsl_spline2d.h>
//#include <boost/interpolator/linear_interpolator.hpp>
using namespace Furion_NS;

Surfefile_From_Shadow::Surfefile_From_Shadow(const char* EXP_file) : No_Surfe(), numCols(0), numRows(0)
{
    cout << "Surfefile_From_Shadow的初始化" << endl;
    
    ifstream filein;
    filein.open(EXP_file);//导入数据
    if (filein.fail())
    {
        cout << "read " << EXP_file << " failed" << endl;
        exit(0);
    }

    std::vector<std::vector<double>> data, data1, data2;
    std::string line;
    while (getline(filein, line)) {
        istringstream iss(line);
        std::vector<double> row;
        double value;
        while (iss >> value) {
            row.push_back(value);
        }
        data.push_back(row);
    }

    filein.close();

    this->meri_X = {};
    for (size_t i = 1; i < data.size(); ++i) //Remove first row of data
    {
        data1.push_back(data[i]);
    }
    this->meri_X = data1[0]; //Get the meridian coordinates
    this->meri_X.pop_back(); //Drop the last number

    this->sag_Y = {};
    for (size_t i = 1; i < data1.size(); ++i) //Remove first row of data
    {
        data2.push_back(data1[i]);
        this->sag_Y.push_back(data1[i][0]);
    }

    this->V = {};
    for (const auto& row : data2) {
        std::vector<double> newRow;
        for (size_t j = 1; j < row.size(); ++j) {
            newRow.push_back(row[j]);
        }
        this->V.push_back(newRow);
    }

    this->numRows = this->sag_Y.size();
    this->numCols = this->meri_X.size();

    cout << numRows << " " << numCols << endl;
}

Surfefile_From_Shadow::~Surfefile_From_Shadow()
{
    cout << "Surfefile_From_Shadow的析构" << endl;
}

void Surfefile_From_Shadow::meshgrid(std::vector<std::vector<double>>& X, std::vector<std::vector<double>>& Y, const std::vector<double>& x, const std::vector<double>& y)
{
    size_t xSize = x.size();
    size_t ySize = y.size();

    for (size_t i = 0; i < ySize; ++i) 
    {
        X.push_back(x);
    }

    for (size_t i = 0; i < ySize; ++i)
    {
        vector<double> newRowX;
        for (size_t j = 0; j < xSize; ++j)
        {
            newRowX.push_back(y[i]);
        }
        Y.push_back(newRowX);
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

void Surfefile_From_Shadow::value(std::vector<double>& Vq, std::vector<double>& X, std::vector<double>& Y, int n)
{
    cout << "Surfefile_From_Shadow de value" << endl;
    Furion_NS::interp2(Vq, this->meri_X, this->sag_Y, this->V, X, Y, n, this->numRows, this->numCols, "liner");
}


