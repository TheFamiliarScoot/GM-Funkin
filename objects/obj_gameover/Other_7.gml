image_speed = 1;
image_index = 0;
if sprite_index = die_sprite {
	sprite_index = die_loop_sprite;
	image_index = 0;
}
if sprite_index = die_retry_sprite {
	image_speed = 0;	
}