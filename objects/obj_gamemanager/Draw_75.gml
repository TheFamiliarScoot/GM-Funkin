if show_counter {
	draw_set_font(fnt_vcr);
	draw_text(0,0,"FPS: " + string(fps) + "\nDelta: " + string(delta_time));
}