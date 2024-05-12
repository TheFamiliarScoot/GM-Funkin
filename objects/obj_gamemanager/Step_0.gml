if !global.paused {
	fmod_system_update();
}

if input_check_pressed(vk_enter, gp_start) && !global.paused && room = room_play && !instance_exists(obj_gameover) {
	global.paused = !global.paused;
	if global.paused {
		pausesprite = sprite_create_from_surface(application_surface,0,0,global.view_width*global.window_scale,global.view_height*global.window_scale,0,0,0,0);
		uicopy = obj_ingame_ui.ui;
		uisprite = sprite_create_from_surface(uicopy.surface,0,0,global.view_width,global.view_height,0,0,0,0);
		lastcamerax = obj_camera.x;
		lastcameray = obj_camera.y;
		with all {
			event_user(14);	
		}
		instance_deactivate_all(true);
		instance_create_layer(0,0,"UI",obj_pause_menu);
	}
}

if input_check_pressed(ord("R"), gp_select) { die(); }