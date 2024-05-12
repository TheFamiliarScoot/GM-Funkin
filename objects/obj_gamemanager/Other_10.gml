/// @description Unpause
sprite_delete(pausesprite);
sprite_delete(uisprite);
uicopy = -1;
instance_destroy(obj_pause_menu);
instance_destroy(obj_scrollmenu);
instance_activate_all();
with all {
	event_user(15);	
}