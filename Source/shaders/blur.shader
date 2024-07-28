shader_type canvas_item;

uniform float amount : hint_range(0, 5);

void fragment() {
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, amount);
}