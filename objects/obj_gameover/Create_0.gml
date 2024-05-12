sprite_index = die_sprite;
image_xscale = scale;
image_yscale = scale;
with obj_ui_parent { instance_destroy(id); }
with obj_strum_parent { instance_destroy(id); }
obj_ingame_ui.ui.vis = false;
instance_destroy(global.bgobject);
audio_play_sound(die_sound,0,false);
alarm[0] = 60;
alarm[2] = music_start_frame;
dsnd_loop = fmod_system_create_stream(music, FMOD_MODE.DEFAULT);
dsnd_end = fmod_system_create_stream(music_end, FMOD_MODE.LOOP_OFF);
deathmusic = fmod_system_play_sound(dsnd_loop, true);
fmod_channel_control_set_volume(deathmusic, 0.5);
retried = false;