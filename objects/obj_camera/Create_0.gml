/// @description game cam
window_set_size(global.view_width*global.window_scale,global.view_height*global.window_scale);

surface_resize(application_surface,global.view_width*global.window_scale,global.view_height*global.window_scale);

display_set_gui_size(global.view_width,global.view_height);

x = target.x + target.camOffX;
y = target.y + target.camOffY;

alarm[0] = 1;

zoom = 1;
angle = 0;
curzoom = zoom;
curangle = angle;

window_set_color(c_black);

bump = 1;