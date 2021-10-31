// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_bg_sprite(spr,subimg,_x,_y,scrollcam,scale,scrollfacx,scrollfacy) {
	var z = 1;
	if instance_exists(obj_camera) { z = obj_camera.curzoom; }
	var xdraw = lerp(_x,camera_get_view_x(scrollcam)+(global.view_width*z)/2,scrollfacx);
	var ydraw = lerp(_y,camera_get_view_y(scrollcam)+(global.view_height*z)/2,scrollfacy);
	draw_sprite_ext(spr,subimg,xdraw,ydraw,scale,scale,0,c_white,1);
}