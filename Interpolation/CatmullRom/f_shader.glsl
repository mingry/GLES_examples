#version 320 es
precision highp float;

in vec3 fs_position;

uniform int shading_mode; // to be set 1 in the initialization

layout (location = 0) out vec4 color;

void main()
{
	vec3 x_tangent = dFdx(fs_position);
	vec3 y_tangent = dFdy(fs_position);
	vec3 N = normalize(cross(x_tangent, y_tangent));

	vec3 L = vec3(0.5f, 0.5f, 1.f);
	L = normalize(L);

	float diffuse = clamp(dot(L, N), 0.2f, 1.f);

	color = vec4(diffuse, diffuse, diffuse, 1.f) * vec4(0.3f, 0.6f, 1.f, 1.f);
}