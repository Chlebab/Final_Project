shader_type canvas_item;

uniform vec4 color : source_color;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	float brightness = ((pixelColor.r * 0.299) + (pixelColor.g * 0.587) + (pixelColor.b * 0.114)) / 3.0;
	vec4 greyscale = vec4(brightness, brightness, brightness, pixelColor.a);
	COLOR = greyscale * color;
}
