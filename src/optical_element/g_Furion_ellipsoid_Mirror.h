#pragma once

#ifndef FUR_G_FURION__ELLIPSOID_MIRROR_H_
#define FUR_G_FURION__ELLIPSOID_MIRROR_H_

#include "Furion.h"
//#include "g_oe.h"
//#include "g_cylinder_ellipse.h"
#include "g_Furion_cylinder_ellipse_Mirror.h"

namespace Furion_NS
{
    class G_Furion_ellipsoid_Mirror : public G_Furion_Cylinder_Ellipse_Mirror
    {
    public:

        G_Furion_ellipsoid_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating);
        ~G_Furion_ellipsoid_Mirror();

        void set_center(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, double r1, double r2, Grating* grating) ;
    };
}

#endif

