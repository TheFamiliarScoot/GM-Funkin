var xcenter = room_width/2;
var ycenter = (room_height/2) - 120;
gpu_set_tex_filter(false);
draw_bg_sprite(spr_school,1,xcenter,ycenter,view_camera[0],6,0.9,0.9);
draw_bg_sprite(spr_school,0,xcenter,ycenter,view_camera[0],6,0.1,0.3);
draw_bg_sprite(spr_school,2,xcenter,ycenter,view_camera[0],6,0.1,0.1);
draw_bg_sprite(spr_school,3,xcenter,ycenter,view_camera[0],6,0.1,0.1);
draw_bg_sprite(spr_bg_trees,floor(timer),xcenter,ycenter,view_camera[0],6,0.25,0.25);
draw_bg_sprite(spr_bg_petals,floor(timer),xcenter,ycenter,view_camera[0],6,0.25,0.25);
if cond.beathit {
	image_index = 0;
	image_speed = 1;
}
for (var i = 0; i < 3; i += 1) {
	draw_bg_sprite(sprite_index,image_index,(xcenter-1098)+(1200*i),ycenter,view_camera[0],6,0.1,0.1);	
}
gpu_set_tex_filter(opt.antialiasing);
event_user(0); // draw characters
timer += d(0.2);