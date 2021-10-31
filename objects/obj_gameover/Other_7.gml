if sprite_index = spr_bf_die {
	sprite_index = spr_bf_die_loop;
	FMODGMS_Snd_PlaySound(dsnd_loop,deathmusic);
}
if sprite_index = spr_bf_die_retry {
	image_speed = 0;	
}