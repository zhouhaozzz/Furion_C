#pragma once
#ifndef FUR_G_PLANE_FOCUS_H_
#define FUR_G_PLANE_FOCUS_H_
#include "Furion.h"
#include "g_oe.h"
namespace Furion_NS
{
	class G_Furion_Plane_Mirror : public G_Oe
	{

	public:
		G_Furion_Plane_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating);
	
	};

}

#endif