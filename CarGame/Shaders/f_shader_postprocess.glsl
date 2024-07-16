#version 320 es
precision highp float;

layout (location=0) out vec4 color;
in vec2 fs_tex_coords;

uniform sampler2D screen_tex;

// void main()
// { 
//     color = vec4(texture(screen_tex, fs_tex_coords).rgb, 1.0);
// }


void color_inversion()
{
	color = vec4(vec3(1.0 - texture(screen_tex, fs_tex_coords)), 1.0);
}

////// gaussian blur
void gaussian_blur()
{
	const float kernel[25] = float[25](
		1.0, 4.0, 6.0, 4.0, 1.0,
		4.0, 16.0, 24.0, 16.0, 4.0,
		6.0, 24.0, 36.0, 24.0, 6.0,
		4.0, 16.0, 24.0, 16.0, 4.0,
		1.0, 4.0, 6.0, 4.0, 1.0
	);
	vec2 texel_size = 1.0 / vec2(textureSize(screen_tex, 0));
	vec3 result = vec3(0.0);

	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			vec2 offset = vec2(i - 2, j - 2) * texel_size;
			result += texture(screen_tex, fs_tex_coords + offset).rgb * kernel[i*5+j];
		}
	}

	result /= 256.0;
 	result = clamp(result, 0.0, 1.0);
	color = vec4(result, 1.0);

}



////// edge detection
void edge_detection()
{
	const vec3 kernel[9] = vec3[](
		vec3(-1.0, -1.0, 0.0),
		vec3(-1.0,  0.0, 1.0),
		vec3(-1.0,  1.0, 0.0),
		vec3( 0.0, -1.0, 1.0),
		vec3( 0.0,  0.0, -4.0),
		vec3( 0.0,  1.0, 1.0),
		vec3( 1.0, -1.0, 0.0),
		vec3( 1.0,  0.0, 1.0),
		vec3( 1.0,  1.0, 0.0)
	);
	vec2 texel_size = 1.0 / vec2(textureSize(screen_tex, 0));
	vec3 result = vec3(0.0);
	for (int i = 0; i < 9; i++)
	{
		vec2 offset = vec2(kernel[i].x, kernel[i].y) * texel_size;
		result += texture(screen_tex, fs_tex_coords + offset).rgb * kernel[i].z;
	}
	result = clamp(result, 0.0, 1.0);
	color = vec4(result, 1.0);
}

////// sharpen
void sharpen()
{
	const vec3 kernel[9] = vec3[](
		vec3(-1.0, -1.0, 0.0),
		vec3(-1.0,  0.0, -1.0),
		vec3(-1.0,  1.0, 0.0),
		vec3( 0.0, -1.0, -1.0),
		vec3( 0.0,  0.0, 5.0),
		vec3( 0.0,  1.0, -1.0),
		vec3( 1.0, -1.0, 0.0),
		vec3( 1.0,  0.0, -1.0),
		vec3( 1.0,  1.0, 0.0)
	);
	vec2 texel_size = 1.0 / vec2(textureSize(screen_tex, 0));
	vec3 result = vec3(0.0);
	for (int i = 0; i < 9; i++)
	{
		vec2 offset = vec2(kernel[i].x, kernel[i].y) * texel_size;
		result += texture(screen_tex, fs_tex_coords + offset).rgb * kernel[i].z;
	}
	result = clamp(result, 0.0, 1.0);
	color = vec4(result, 1.0);
}



////// pixelation
void pixelation()
{
	vec2 texel_size = 15.0 / vec2(textureSize(screen_tex, 0));
	vec2 uv = fs_tex_coords;
	vec2 xy = uv / texel_size;
	vec2 ixy = floor(xy);
	vec2 uv_n = ixy * texel_size;
	color = texture(screen_tex, uv_n);
}


////// kuwahara
void kuwahara()
{
	const int radius = 5;
	vec2 texel_size = 1.0 / vec2(textureSize(screen_tex, 0));
	vec3 result = vec3(0.0);
	vec3 min_color = vec3(1.0);
	vec3 max_color = vec3(0.0);
	for (int i = -radius; i <= radius; i++)
	{
		for (int j = -radius; j <= radius; j++)
		{
			vec2 offset = vec2(i, j) * texel_size;
			vec3 color = texture(screen_tex, fs_tex_coords + offset).rgb;
			if (dot(color, color) < dot(min_color, min_color))
			{
				min_color = color;
			}
			if (dot(color, color) > dot(max_color, max_color))
			{
				max_color = color;
			}
			result += color;
		}
	}
	result = min(min(min_color, max_color), result / float((2 * radius + 1) * (2 * radius + 1)));
	color = vec4(result, 1.0);
}


////// 
void main()
{ 
	pixelation();
	return;
	vec2 center = vec2(0.5, 0.5);
	float radius = 0.3;

	if (distance(fs_tex_coords, center) < radius) {
		// gaussian_blur();		
		pixelation();
	}
	else {
    	color = vec4(texture(screen_tex, fs_tex_coords).rgb, 1.0);
	}
}