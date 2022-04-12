/// @description game cam
window_set_size(global.view_width*global.window_scale,global.view_height*global.window_scale);

surface_resize(application_surface,global.view_width*global.window_scale,global.view_height*global.window_scale);

ui = {
	surface: -1,
	center_x: global.view_width/2,
	center_y: global.view_height/2,
	pos_x: 0,
	pos_y: 0,
	angle: 0,
	scale: 1,
	vis: true,
}

global.cam = {
	zoom: 1,
	angle: 0,
}

display_set_gui_size(global.view_width,global.view_height);

x = global.target.x + global.target.camOffX;
y = global.target.y + global.target.camOffY;

iconscale = 1;

alarm[0] = 1;

curzoom = global.cam.zoom;
curangle = global.cam.angle;

window_set_color(c_black);

bump = 1;