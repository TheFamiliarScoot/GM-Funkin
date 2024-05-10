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

function play_anim_ind(inst,sprt,custom,dlta) {
	with inst {
		if custom {
			cursprite = variable_struct_get(spritedata,sprt);
			curspritename = sprt;
			animtimer = 0;
			animspeed = 1;
		}
		else {
			if dlta {
				sprite_index = sprt;
				image_index = 0;
				d_image_speed = 1;
			}
			else {
				sprite_index = sprt;
				image_index = 0;
				image_speed = 1;		
			}
		}
	}
}

function get_hp_penalty() {
	if variable_struct_exists(global.gimmicks,"hp_penalty_multiplier") {
		return global.gimmicks.hp_penalty_multiplier;	
	}
	return opt.hpmult;
}

function get_hp_gain() {
	if variable_struct_exists(global.gimmicks,"hp_gain_multiplier") {
		return global.gimmicks.hp_gain_multiplier;	
	}
	return opt.hpgainmult;
}

function change_hp(amt,cankill=true) {
	var a = 0;
	var m = 0;
	
	if amt < 0 { m = get_hp_penalty(); }
	else if amt > 0 { m = get_hp_gain(); }
	
	if opt.player1 { a = -amt * m; }
	else { a = amt * m; }
	
	global.hp = clamp(global.hp + a,0,global.maxhp);
	
	var check = false;
	if opt.player1 { check = global.hp >= global.maxhp }
	else { check = global.hp <= 0 }

	if check && cankill { die(); }
}

function die() {
	global.hp = opt.player1 * 2;
	
	if room = room_play {
		if instance_exists(obj_conductor) {
			instance_destroy(obj_conductor);	
		}
		if opt.blueballing && !instance_exists(obj_gameover) {
			var obj = global.bfinstance;
			if opt.player1 { 
				obj = global.dadinstance;	
			}
			if obj.gameover_obj != noone {
				instance_create_layer(obj.x,obj.y,"Instances",obj.gameover_obj);	
			}
			else {
				room_transition(room_menu);
			}
		}	
	}
}

function miss(char, penalty, key) {
	if opt.missnotes {
		with char { event_user(key + 4); }
		change_hp(penalty);
		if instance_exists(obj_conductor) {
			obj_conductor.vocalsmuted[char.playside] = true;
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

function room_transition(rm, inst = false) {
	instance_create_layer(0,0,"Instances",obj_transition,{roomtogoto: rm, instant: inst});
}

function create_custom_char(nm,_x,_y,_lyr,side) {
	return instance_create_layer(_x,_y,_lyr,obj_custom_char,{loadname: nm, playside: side});
}

function spawn_char(_x,_y,_layer,side,_id) {
	return instance_create_layer(_x,_y,_layer,_id,{playside: side});
}

/*
function draw_note_tail(sprite,_x,_y,length) {
	if length < 0 { return; }
	for (var i = 0; i < length; i += 1) {
		draw_sprite_part_ext(sprite,3,0,100-(i%100),200,-1,_x+i,_y+length,);
	}
}
*/

function create_scroll_menu(_x,_y,_layer,chc) {
	return instance_create_layer(_x,_y,_layer,obj_scrollmenu,{choices: chc});
}