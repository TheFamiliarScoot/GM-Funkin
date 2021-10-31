draw_enable_swf_aa(opt.antialiasing);
draw_set_swf_aa_level(0.5);
gpu_set_texfilter(opt.antialiasing);
var vw = global.view_width/2;
var vh = global.view_height/2;
if global.paused {
	if sprite_exists(pausesprite) {
		draw_sprite(pausesprite,0,lastcamerax-(vw),lastcameray-(vh));
	}
}