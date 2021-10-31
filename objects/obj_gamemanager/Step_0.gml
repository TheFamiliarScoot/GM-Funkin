if keyboard_check_pressed(vk_enter) && room = room_play && !instance_exists(obj_gameover) {
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
	else {
		sprite_delete(pausesprite);
		sprite_delete(uisprite);
		uicopy = -1;
		FMODGMS_Chan_ResumeChannel(chi);
		FMODGMS_Chan_ResumeChannel(chv);
		instance_destroy(obj_pause_menu);
		instance_activate_all();
	}
}