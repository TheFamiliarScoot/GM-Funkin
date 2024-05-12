/// @description game cam
window_set_size(global.view_width*global.window_scale,global.view_height*global.window_scale);

surface_resize(application_surface,global.view_width*global.window_scale,global.view_height*global.window_scale);

global.cam = {
	zoom: 1,
	angle: 0,
}

display_set_gui_size(global.view_width,global.view_height);

x = global.target.x + global.target.camOffX;
y = global.target.y + global.target.camOffY;

alarm[0] = 1;

curzoom = global.cam.zoom;
curangle = global.cam.angle;

window_set_color(c_black);

bump = 1;