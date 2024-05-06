if alarm[1] > 0 {
	var normalpha = (game_get_speed(gamespeed_fps)*4 - alarm[1]) / (game_get_speed(gamespeed_fps)*4 - 0);
	draw_set_alpha(normalpha);
	draw_rectangle_color(0,0,global.view_width,global.view_height,c_black,c_black,c_black,c_black,false);
	draw_set_alpha(1);
}