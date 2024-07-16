#version 320 es

layout (location = 0) in vec3 vs_position;
layout (location = 1) in vec2 vs_tex_coords;

out vec2 fs_tex_coords;

void main()
{
    gl_Position = vec4(vs_position, 1.0); 
	fs_tex_coords = vs_tex_coords;
}  
