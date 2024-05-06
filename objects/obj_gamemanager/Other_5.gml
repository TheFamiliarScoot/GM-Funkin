if room = room_play {
	if global.paused {
		sprite_delete(pausesprite);
		sprite_delete(uisprite);
		uicopy = -1;
		instance_destroy(obj_pause_menu);
	}
	fmod_sound_release(ins);
	if voc1 > -1 { fmod_sound_release(voc1); }
	if voc2 > -1 { fmod_sound_release(voc2); }
}