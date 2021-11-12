/// @description Unpause
sprite_delete(pausesprite);
sprite_delete(uisprite);
uicopy = -1;
FMODGMS_Chan_ResumeChannel(chi);
FMODGMS_Chan_ResumeChannel(chv);
instance_destroy(obj_pause_menu);
instance_destroy(obj_scrollmenu);
instance_activate_all();