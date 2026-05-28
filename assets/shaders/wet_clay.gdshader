shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;

uniform vec4 clay_color : source_color = vec4(0.8, 0.6, 0.4, 1.0);
uniform float glossiness : hint_range(0.0, 1.0) = 0.5;
uniform float rim_strength : hint_range(0.0, 2.0) = 0.8;

void fragment() {
    ALBEDO = clay_color.rgb;
    METALLIC = 0.0;
    ROUGHNESS = 1.0 - glossiness;
    
    // Add rim lighting to emphasize the "sculpted" edges
    RIM = rim_strength;
}
