draw_self();

if menu.selection < array_length(songs) {
	var txt = "< " + songs[menu.selection].difficulties[seldifficulty] + " >";
	draw_font_text(txt, room_width - (string_length(txt) * 40 * 0.5), 40, false, 40, 0.5);
}