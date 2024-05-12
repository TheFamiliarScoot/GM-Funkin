if room = room_play {
	if global.paused {
		sprite_delete(pausesprite);
		sprite_delete(uisprite);
		uicopy = -1;
		instance_destroy(obj_pause_menu);
	}
}