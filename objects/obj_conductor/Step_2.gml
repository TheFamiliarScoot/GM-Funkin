if !playing {
	return;	
}

if !countingdown && fmod_channel_get_position(chi, FMOD_TIMEUNIT.MS) >= fmod_sound_get_length(ins, FMOD_TIMEUNIT.MS) && !instance_exists(obj_transition) {
	room_transition(room_menu);
	if !opt.botplay {
		write_score(global.selectedsong.name,global.selecteddifficulty,global.score,global.highcombo,global.misses,global.ratings,global.accuracy);
	}
	instance_destroy(id);
	return;
}