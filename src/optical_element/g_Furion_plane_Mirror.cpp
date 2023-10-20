#include "g_Furion_plane_Mirror.h"

using namespace Furion_NS;

G_Furion_Plane_Mirror::G_Furion_Plane_Mirror(G_Beam* beam_in, double ds, double di, double chi, double theta, No_Surfe* surface, Grating* grating)
	:G_Oe( beam_in, ds,  di, chi, theta, surface,  grating)
{
	this->reflect(beam_in, ds, di, chi, theta);
}