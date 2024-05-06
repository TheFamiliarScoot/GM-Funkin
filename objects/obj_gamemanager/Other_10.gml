/// @description Unpause
sprite_delete(pausesprite);
sprite_delete(uisprite);
uicopy = -1;
fmod_channel_control_set_paused(chi, false);
if chv1 > -1 { fmod_channel_control_set_paused(chv1, false); }
if chv2 > -1 { fmod_channel_control_set_paused(chv2, false); }
instance_destroy(obj_pause_menu);
instance_destroy(obj_scrollmenu);
instance_activate_all();