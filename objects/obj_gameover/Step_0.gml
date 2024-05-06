if input_check_pressed(vk_enter, gp_face1) {
	if !retried {
		sprite_index = spr_bf_die_retry;
		FMODGMS_Chan_StopChannel(deathmusic);
		FMODGMS_Snd_PlaySound(dsnd_end,deathmusic);
		retried = true;
		alarm[1] = game_get_speed(gamespeed_fps) * 4;
	}
	else if retried && alarm[1] > 0 {
		room_transition(room_play);
		FMODGMS_Chan_RemoveChannel(deathmusic);
		FMODGMS_Snd_Unload(dsnd_end);
		FMODGMS_Snd_Unload(dsnd_loop);
		visible = false;
	}	
}
if input_check_pressed(vk_escape, gp_face2) && !instance_exists(obj_transition) {
	room_transition(room_menu);
}