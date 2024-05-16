/// @description Insert description here
// You can write your code in this editor
var z = 1;
if instance_exists(obj_camera) { z = obj_camera.curzoom; }
var xdraw = lerp(x,camera_get_view_x(view_camera[0])+(global.view_width*z)/2,1-scrollfacx);
var ydraw = lerp(x,camera_get_view_y(view_camera[0])+(global.view_height*z)/2,1-scrollfacy);
draw_sprite_ext(sprite_index, image_index, xdraw, ydraw, image_xscale, image_yscale, image_angle, image_blend, image_alpha);