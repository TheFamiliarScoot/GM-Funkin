if no_antialiasing { gpu_set_texfilter(false); }
if is_custom {
	var curframe = cursprite.frames[floor(animtimer) % array_length(cursprite.frames)];
	var offset = variable_struct_get(offsets,curspritename);
	var sprx = (x+mainOffX-offset[0]) + (-curframe[4] * image_xscale);
	var spry = (y+mainOffY-offset[1]) + (-curframe[5] * image_yscale);
	draw_sprite_part_ext(
		customsprite,
		0,
		curframe[0],
		curframe[1],
		curframe[2],
		curframe[3],
		sprx,
		spry,
		image_xscale,
		image_yscale,
		c_white,
		1
	);
	animtimer += animspeed * d((room_speed / 24) * 0.1) * 0.25;
	if floor(animtimer) = array_length(cursprite.frames) - 1 { animspeed = 0; }
}
else { draw_self(); }
gpu_set_texfilter(opt.antialiasing);