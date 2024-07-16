#version 320 es
precision highp float;

layout (location=0) out vec4 color;
in vec2 fs_tex_coords;

uniform sampler2D screen_tex;
uniform sampler2D depth_tex;

float near = 1.0f;
float far = 1000.0f;

///// depth of field
float focusDepth = 10.f;
float focusRange = 3.f;
float depthVar = 1.0f;
vec2 texelSize;
float cam_factor = 1.0f;

float to_distance(float depth_colour)
{
    float dist = (2.0*near*far) / (far + near - depth_colour*(far - near)); 
    return dist;
}


float calculateBlurAmount(float depth) {
  float depthDiff = abs(depth - focusDepth);
  return clamp((depthVar - focusRange) / focusRange, 0.0, 1.0);
}

vec4 get_blurred_pixel(vec2 tc)
{   
    float depth_colour = texture(depth_tex, tc).r;

    float distance_to_pixel = to_distance(depth_colour);

    float x = clamp(distance_to_pixel, 0.0f, 2.0f*focusDepth) / (2.0f*focusDepth);

    // tent function
    if(x > 0.5)
         x = 1.0 - x;

    // x = 1.0 - pow(x, 1.0/10.0);
	x *= 2.0; // from 0 to 1
x *= 2.0; // from 0 to 2
x -= 1.0; // from -1 to 1

x = abs(x);
x = pow(x, 10.0);

   const float pi_times_2 = 6.28318530718; // Pi*2
   vec2 img_size= vec2(textureSize(screen_tex, 0));
    
    float directions = 16.0; // BLUR directions (Default 16.0 - More is better but slower)
    float quality = 10.0; // BLUR quality (Default 4.0 - More is better but slower)
    float size = 8.0; // BLUR size (radius)

    vec2 radius = vec2(size/img_size.x * cam_factor, size/img_size.y * cam_factor);

   vec4 blurred_colour = texture(screen_tex, tc);
    
    for( float d=0.0; d<pi_times_2; d+= pi_times_2/directions)
        for(float i=1.0/quality; i<=1.0; i+=1.0/quality)
            blurred_colour += texture( screen_tex, tc + vec2(cos(d),sin(d))*radius*x*i);    
    
    // Output to screen
    blurred_colour /= quality * directions - 15.0;

    return blurred_colour;
}


void main() {
//   texelSize = 1.0 / vec2(textureSize(screen_tex, 0));
//   vec2 uv = gl_FragCoord.xy * texelSize;
//   float depth = to_distance(texture(depth_tex, uv).r);
//   float blurAmount = 1.0f;// calculateBlurAmount(depth);
//   color = gaussianBlur(screen_tex, uv, blurAmount);
//   color = texture(screen_tex, fs_tex_coords);

	color = get_blurred_pixel(fs_tex_coords);
}