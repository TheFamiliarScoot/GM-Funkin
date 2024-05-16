if texture != "none" && texturegroup_get_status(texture) == texturegroup_status_loaded {
	texturegroup_unload(texture);
}