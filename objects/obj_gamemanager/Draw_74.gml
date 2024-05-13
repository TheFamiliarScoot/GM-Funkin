if global.paused {
	if sprite_exists(pausesprite) {
		draw_sprite(pausesprite,0,0,0);
	}
	if sprite_exists(uisprite) {
		draw_ui_fake(uicopy,uisprite);	
	}
}