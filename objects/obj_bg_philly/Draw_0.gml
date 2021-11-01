draw_bg_sprite(spr_bg_philly,0,room_width/2,room_height/2,view_camera[0],1,0.9,0.9);
draw_bg_sprite(spr_bg_philly,2,room_width/2,room_height/2,view_camera[0],0.85,0.7,0.7);

// windows
draw_bg_sprite(spr_bg_philly,4,room_width/2,room_height/2,view_camera[0],0.85,0.7,0.7,wincolors[curcolor],winalpha);

if cond.beathit {
	winalpha = 1;
	curcolor = (curcolor + 1) % 5;
}

draw_bg_sprite(spr_bg_philly,1,room_width/2,(room_height/2)-100,view_camera[0],1.2,0,0);
// train
draw_bg_sprite(spr_bg_philly,3,room_width/2,(room_height/2)-100,view_camera[0],1.2,0,0);
event_user(0); // draw characters

winalpha -= d(0.005);