#version 320 es

layout (location = 0) in vec3 vs_position;

uniform mat4 proj_matrix;
uniform mat4 view_matrix;
uniform mat4 model_matrix;

out vec3 fs_position;

void main()
{
	gl_Position = proj_matrix * view_matrix * model_matrix * vec4(vs_position, 1.f);
	fs_position = (view_matrix * model_matrix * vec4(vs_position, 1.f)).xyz;
}