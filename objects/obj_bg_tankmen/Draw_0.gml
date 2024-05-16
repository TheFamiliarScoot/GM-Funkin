/// @description Insert description here
// You can write your code in this editor

// clouds

// battlegrounds
draw_bg_sprite(spr_tankmenbg_static,5,room_width/2,room_height/2,view_camera[0],1,1,1,c_white,1);
draw_bg_sprite(spr_tankmenbg_static,3,room_width/2,room_height/2,view_camera[0],1.2,0.8,0.8,c_white,1);
draw_bg_sprite(spr_tankmenbg_static,2,room_width/2,room_height/2,view_camera[0],1.1,0.7,0.7,c_white,1);
draw_bg_sprite(spr_tankmenbg_static,1,room_width/2,room_height/2,view_camera[0],1.1,0.65,0.65,c_white,1);
draw_bg_sprite(spr_tankmenbg_static,1,room_width/2,room_height/2,view_camera[0],1.1,0.65,0.65,c_white,1);

// watchtower
event_perform_object(watchtower, ev_draw, 0);

// tank dude
event_perform_object(tank, ev_draw, 0);

// ground
draw_bg_sprite(spr_tankmenbg_static,0,room_width/2,room_height/2,view_camera[0],1.15,0,0,c_white,1);

// characters
event_user(0);

// audience