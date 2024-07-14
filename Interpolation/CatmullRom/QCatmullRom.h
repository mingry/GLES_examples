#pragma once

#include "glm/glm.hpp"
#include "glm/ext.hpp"
#include <iostream>

// https://en.wikipedia.org/wiki/Centripetal_Catmull%E2%80%93Rom_spline

static float alpha = 0.5f;

static glm::quat Remap(float a, float b, glm::quat c, glm::quat d, float u)
{
    if ( (b-a) < glm::epsilon<float>() )
    {
        return c;
    }
	return glm::mix(c, d, (u - a) / (b - a));
}


static float GetKnotInterval(glm::quat a, glm::quat b)
{
	return glm::pow(glm::length2(glm::log(a*glm::inverse(b))), 0.5f * alpha);
}

glm::quat QCatmullRom(glm::quat q0, glm::quat q1, glm::quat q2, glm::quat q3, float t)
{
    // calculate knots
	const float k0 = 0;
	float k1 = GetKnotInterval(q0, q1);
	float k2 = GetKnotInterval(q1, q2) + k1;
	float k3 = GetKnotInterval(q2, q3) + k2;

	// evaluate the point
	float u = glm::mix(k1, k2, t);
	glm::quat A1 = Remap(k0, k1, q0, q1, u);
	glm::quat A2 = Remap(k1, k2, q1, q2, u);
	glm::quat A3 = Remap(k2, k3, q2, q3, u);
	glm::quat B1 = Remap(k0, k2, A1, A2, u);
	glm::quat B2 = Remap(k1, k3, A2, A3, u);

	return Remap(k1, k2, B1, B2, u);

}