/// @description Insert description here
// You can write your code in this editor
if texture != "none" && texturegroup_get_status(texture) == texturegroup_status_loaded {
	texturegroup_unload(texture);
}