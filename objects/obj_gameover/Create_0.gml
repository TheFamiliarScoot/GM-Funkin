with obj_ui_parent { instance_destroy(id); }
with obj_strum_parent { instance_destroy(id); }
instance_destroy(obj_conductor);
audio_stop_sync_group(mus);
obj_camera.ui.vis = false;
instance_destroy(global.bgobject);
audio_play_sound(snd_death,0,false);
alarm[0] = 60;
deathmusic = FMODGMS_Chan_CreateChannel();
dsnd_loop = FMODGMS_Snd_LoadSound("assets/music/gameOver.ogg");
dsnd_end = FMODGMS_Snd_LoadSound("assets/music/gameOverEnd.ogg");
FMODGMS_Snd_Set_LoopMode(dsnd_loop,FMODGMS_LOOPMODE_NORMAL,infinity);
retried = false;