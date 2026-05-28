// src/levels/jumbotron_screen.gdshader
shader_type spatial;
render_mode Laberration, diffuse_burley, specular_schlick_ggx;

uniform sampler2D viewport_texture : source_color, hint_screen_texture;
uniform float emission_intensity : hint_range(1.0, 5.0) = 2.5;
uniform float pixel_density : hint_range(64.0, 512.0) = 256.0;

void fragment() {
	// 1. Convert standard texture coordinates into segmented pixel blocks
	vec2 pixelated_uv = floor(UV * pixel_density) / pixel_density;
	
	// 2. Sample our live SubViewport texture array
	vec4 screen_color = texture(viewport_texture, pixelated_uv);
	
	// 3. Inject a subtle scanning line screen matrix pattern
	float scanline = sin(pixelated_uv.y * pixel_density * 3.14159) * 0.08;
	vec3 final_color = screen_color.rgb - vec3(scanline);
	
	// 4. Output values directly into the Spatial Engine Render Pipeline
	ALBEDO = final_color;
	EMISSION = final_color * emission_intensity; // Makes the display glow into the stadium fog
	ROUGHNESS = 0.4;
	METALLIC = 0.1;
}
