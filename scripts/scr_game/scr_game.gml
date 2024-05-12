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

function change_hp(amt,cankill=true) {
	var a = 0;
	var m = 1;
	
	// TODO: reimplement
	//if amt < 0 { m = get_hp_penalty(); }
	//else if amt > 0 { m = get_hp_gain(); }
	
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

function conductor_start(c) {
	c.playing = true;
}

function create_character(c,_x,_y,_layer,side,_id) {
	return instance_create_layer(_x,_y,_layer,_id,{conductor: c, playside: side});
}

function create_conductor(c,_x,_y,_layer) {
	return instance_create_layer(_x, _y, _layer, obj_conductor, c);
}

function create_strum(c,_x,_y,layer,idx,owner,key_kb=-1,key_gp=-1) {
	return instance_create_layer(_x,_y,layer,obj_strum,{conductor: c, type: idx, tiedCharacter: owner, thisKey: key_kb, thisKeyGP: key_gp});
}

function create_strums_default(c) {
	var ctr = 0;

	var strumKeys = [
		global.keys.left,
		global.keys.down,
		global.keys.up,
		global.keys.right,
		global.keys.left,
		global.keys.down,
		global.keys.up,
		global.keys.right
	]

	var strumKeysGp = [
		gp_shoulderlb,
		gp_shoulderl,
		gp_shoulderr,
		gp_shoulderrb,
		gp_shoulderlb,
		gp_shoulderl,
		gp_shoulderr,
		gp_shoulderrb
	]

	repeat 8 {
		// position
		var xx = 0;
		var yy = 0;
		if opt.middlescroll { xx = global.mid_strum_positions[ctr % 4]; }
		else { xx = global.strum_positions[ctr % 8]; }

		if !opt.usedownscroll {
			yy = 100;
		}
		else {
			yy = global.view_height - 100;
		}
		
		// character
		var ch = noone;
		if floor(ctr / 4) % 2 {
			ch = global.dadinstance;
		}
		else { 
			ch = global.bfinstance;
		}
		
		// create
		with create_strum(c, xx, yy, "UI", ctr, ch, strumKeys[ctr], strumKeysGp[ctr]) {
			if opt.middlescroll { visible = tiedCharacter == global.player;	}
			isbot = opt.botplay || tiedCharacter != global.player;
		}
		++ctr;
	}
	ctr = 0;
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