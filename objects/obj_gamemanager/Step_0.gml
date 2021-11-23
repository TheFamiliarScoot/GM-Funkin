if input_check_pressed(vk_enter, gp_start) && !global.paused && room = room_play && !instance_exists(obj_gameover) && !obj_conductor.countingdown {
	global.paused = !global.paused;
	if global.paused {
		pausesprite = sprite_create_from_surface(application_surface,0,0,global.view_width*global.window_scale,global.view_height*global.window_scale,0,0,0,0);
		uicopy = obj_camera.ui;
		uisprite = sprite_create_from_surface(uicopy.surface,0,0,global.view_width,global.view_height,0,0,0,0);
		FMODGMS_Chan_PauseChannel(chi);
		FMODGMS_Chan_PauseChannel(chv);
		lastcamerax = obj_camera.x;
		lastcameray = obj_camera.y;
		instance_deactivate_all(true);
		instance_create_layer(0,0,"UI",obj_pause_menu);
	}
}

if input_check_pressed(ord("R"), gp_select) { die(); }