if !loaded_conductor_data {
	show_debug_message("loading song");
	global.conductordata = load_conductor_data(global.selectedpack, global.selectedsong, global.selecteddifficulty);
	loaded_conductor_data = true;
	show_debug_message("loaded song");
}
else if loaded_last_group {
	show_debug_message("loading " + textures_to_load[curtex]);
	texturegroup_load(textures_to_load[curtex]);
	loaded_last_group = false;
}
else if texture_is_ready(textures_to_load[curtex]) {
	loaded_last_group = true;
	show_debug_message("loaded " + textures_to_load[curtex]);
	curtex++;
	if curtex >= array_length(textures_to_load) {
		room_transition(room_play, true);
		instance_destroy(id);
	}
}