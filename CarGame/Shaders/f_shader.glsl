#version 320 es
precision highp float;

in vec4 fs_color;
in vec3 fs_normal;


layout (location = 0) out vec4 color;

uniform vec3 light_dir;	

// void vignette() {
// 	//  vignette
// 	vec2 img_size = vec2(800.f, 600.f);
// 	vec2 center = vec2(400.f, 300.f);
// 	float radius = 500.0f;
// 	float softness = 0.5f;
// 	float strength = 1.0f;

// 	vec2 uv = gl_FragCoord.xy / img_size;
// 	float dist = distance(uv, center / img_size); // dist \in [0,1]
// 	float vignette = smoothstep(radius / img_size.x, radius / img_size.x * (1.f - softness), dist);
// 	color.rgb *= vignette * strength;
// }

void main()
{
	
	vec3 L = normalize(-light_dir);
	vec3 N = normalize(fs_normal);

	float diffuse = clamp(dot(L, N), 0.2f, 1.f);

	color = vec4(diffuse, diffuse, diffuse, 1.f) * fs_color;

	// post process
	// vignette();
}