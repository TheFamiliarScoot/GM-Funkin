// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_anim(inst,sprt) {
	with inst {
		sprite_index = sprt;
		image_index = 0;
		image_speed = 1;
	}
}

function play_miss_sfx() {
	audio_play_sound(asset_get_index("snd_miss" + string(irandom_range(0,2))),0,false);	
}

function play_anim_d(inst,sprt){
	with inst {
		sprite_index = sprt;
		image_index = 0;
		d_image_speed = 1;
	}
}

function change_hp (amt) {
	var a = amt;
	if opt.player1 { a = -amt; } 
	global.hp = clamp(global.hp + a,0,global.maxhp);
	var check = false;
	if opt.player1 { check = global.hp >= global.maxhp }
	else { check = global.hp <= 0}
	if check && opt.blueballing && !instance_exists(obj_gameover) {
		if room = room_play && !opt.player1 { 
			instance_create_layer(global.bfobject.x,global.bfobject.y,"Instances",obj_gameover);
		}
		else if room = room_play { room_transition(room_menu);	}
	}
}

function miss(char, penalty, key) {
	if opt.missnotes {
		with char { event_user(key + 4); }
		change_hp(penalty);
		if instance_exists(obj_conductor) {
			obj_conductor.vocalsmuted = true;
		}
		global.misses += 1;
		global.combo = 0;
	}
}

function draw_ui(ui) {
	var _c = dcos(ui.angle);
	var _s = dsin(ui.angle);
	var _x = ui.center_x;  //surface origin x
	var _y = ui.center_y;  //surface origin y
	var rc_x = global.view_width/2 + ui.pos_x;
	var rc_y = global.view_height/2 + ui.pos_y;

	draw_surface_ext(ui.surface,rc_x - (_c * _x - _s * _y) * ui.scale, rc_y - (_c * _y + _s * _x) * ui.scale,ui.scale,ui.scale,ui.angle,c_white,1);
}

function draw_ui_fake(ui, spr) {
	var _c = dcos(ui.angle);
	var _s = dsin(ui.angle);
	var _x = ui.center_x;  //surface origin x
	var _y = ui.center_y;  //surface origin y
	var rc_x = global.view_width/2 + ui.pos_x;
	var rc_y = global.view_height/2 + ui.pos_y;

	draw_sprite_ext(spr,0,rc_x - (_c * _x - _s * _y) * ui.scale, rc_y - (_c * _y + _s * _x) * ui.scale,ui.scale,ui.scale,ui.angle,c_white,1);
}

function room_transition(rm) {
	with instance_create_layer(0,0,"Instances",obj_blank) {
		roomtogoto = rm;
		instance_change(obj_transition,true);
	}
}