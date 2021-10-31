if room = room_play {
	if global.paused {
		sprite_delete(pausesprite);
		sprite_delete(uisprite);
		uicopy = -1;
		instance_destroy(obj_pause_menu);
	}
	FMODGMS_Snd_Unload(ins);
	FMODGMS_Snd_Unload(voc);
	FMODGMS_Chan_RemoveChannel(chi);
	FMODGMS_Chan_RemoveChannel(chv);
}