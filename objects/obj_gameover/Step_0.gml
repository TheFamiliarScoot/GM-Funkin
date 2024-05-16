if input_check_pressed(vk_enter, gp_face1) {
	if !retried {
		sprite_index = die_retry_sprite;
		fmod_channel_control_stop(deathmusic);
		deathmusic = fmod_system_play_sound(dsnd_end, false);
		fmod_channel_control_set_volume(deathmusic, 0.5);
		retried = true;
		alarm[0] = 1;
		alarm[1] = game_get_speed(gamespeed_fps) * 4;
		alarm[2] = 0;
	}
	else if retried && alarm[1] > 0 {
		room_transition(room_load);
		fmod_channel_control_stop(deathmusic);
		fmod_sound_release(dsnd_loop);
		fmod_sound_release(dsnd_end);
		visible = false;
	}	
}
if input_check_pressed(vk_escape, gp_face2) && !instance_exists(obj_transition) {
	room_transition(room_entrypoint);
}