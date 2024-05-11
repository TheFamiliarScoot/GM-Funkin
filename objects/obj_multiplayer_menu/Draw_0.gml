draw_self();
draw_font_text("LOBBY",room_width/2,40,true,40,1,true);

if instance_exists(server) {
	var clen = array_length(server.clients);
	for (var i = 0; i < clen; i++) {
		var cl = server.clients[i];
		draw_font_text(cl.name, 100, 100 + 40 * i, false);
		draw_sprite(global.chars[cl.character].icon, 0, 150 + string_length(cl.name) * 50, 100 + 40 * i);
	}	
}

if prompting_leave {
	draw_set_alpha(0.5);
	draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}