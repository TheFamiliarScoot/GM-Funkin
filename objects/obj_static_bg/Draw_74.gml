draw_self();
if instance_exists(obj_gameover) {
	if obj_gameover.sprite_index = spr_bf_die_loop {
		draw_font_text("RETRY?", global.view_width/2, global.view_height/2, false, 48, 1, true, 1);	
	}
}