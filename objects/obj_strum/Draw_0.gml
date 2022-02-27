var stype = notetype[type % 4];
var ovsprite = 0;
var key = type % 4;

var p = global.pixelui;

var nsub = 0;

// 0 - static
// 1 - pressed
// 2 - confirm
// 3 - tail
// 4 - end



if opt.usenoteskin {
	switch sprite_index {
		case nsprite[p][1]: nsub = 2; break;
		case nsprite[p][2]: nsub = 0; break;
		default: nsub = 0;
	}
}
else {
	switch sprite_index {
		case nsprite[p][1]: ovsprite = osprite[p][1]; break;
		case nsprite[p][2]: ovsprite = osprite[p][2]; break;
		default: ovsprite = osprite[p][5]; break;
	}
}
if enabled {
	var col1 = stype.color;
	var col2 = c_white;
	
	var s_ang = stype.ang;
	if opt.usenoteskin {
		if global.noteopt.no_rotate { s_ang = 0; }
		if global.noteopt.no_aa { gpu_set_texfilter(false); }
	}

	if p { gpu_set_texfilter(false); }
	if opt.usenoteskin {
		if sprite_index = nsprite[p][2] {
			draw_sprite_ext(customoverlay,nsub,x,y,image_xscale,image_yscale,s_ang+visualangle,col2,image_alpha);
			draw_sprite_ext(customsprite,nsub,x,y,image_xscale,image_yscale,s_ang+visualangle,col1,image_alpha);
		}
		else if sprite_index = nsprite[p][5] {
			draw_sprite_ext(customoverlay,nsub,x,y,image_xscale,image_yscale,s_ang+visualangle,col2,image_alpha);
		}
		else {
			draw_sprite_ext(customsprite,nsub,x,y,image_xscale,image_yscale,s_ang+visualangle,col1,image_alpha);
			ovalpha(true);
			draw_sprite_ext(customoverlay,nsub,x,y,image_xscale,image_yscale,s_ang+visualangle,col2,image_alpha);
			ovalpha(false);
		}
	}
	else {
		draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,stype.ang+visualangle,col1,image_alpha);
		ovalpha(true);
		draw_sprite_ext(ovsprite,image_index,x,y,image_xscale,image_yscale,stype.ang+visualangle,col2,image_alpha);
		ovalpha(false);
	}
	for (var i = -2; i < 3; i += 1) {
		if i + cond.section < 0 { continue; }
		if i + cond.section >= cond.sectioncount { continue; }

		var ctr = 0;

		repeat array_length(global.sections[cond.section + i][group][type % global.keyamt]) {
			var note = global.sections[cond.section + i][group][type % global.keyamt][ctr];
			var diff = cond.notepos - note.position;
			var real_y = diff * global.notescroll;
			var thistype = notetype[note.type % 4];
			var noteLimitY = 900;
			var tailLength = note.length;
			var boundsCheck = real_y < -noteLimitY || real_y > noteLimitY;
			var tailBoundLength = tailLength*global.realscroll;
			var tailBounds = real_y < -noteLimitY - tailBoundLength || real_y > noteLimitY + tailBoundLength;

			var aox = sin(degtorad(image_angle));
			var aoy = cos(degtorad(image_angle));

			var lengthdiff = tailLength - note.covered;
			var tailY = (y + ((real_y*aoy)+(note.covered * -global.notescroll)));
			var tailscale = lengthdiff * -global.notescroll;
			var endY = (y+(tailLength*-global.notescroll))+(real_y*aoy);
			
			var endh = 64;
			if opt.usenoteskin { endh = global.noteopt.size_tail[1]; }
	
			var endscale = (clamp(lengthdiff,0,endh)/endh)*-global.notescroll;
			
			switch note.special {
				case 0:
					col1 = thistype.color;
					col2 = c_white;
					break;
				case 1:
					col1 = c_black;
					col2 = c_red;
					break;
				case 2:
					col1 = c_white;
					col2 = c_lime;
					break;
				case 3:
					col1 = c_yellow;
					col2 = c_red;
					break;
				case 4:
					col1 = c_red;
					col2 = c_black;
					break;
			}
			if !note.completed && !tailBounds {
				if opt.usenoteskin {
					var n = global.noteopt;
					draw_sprite_ext(customtail,0,x+(real_y*aox),tailY,0.75*scalemod,tailscale/n.size_tail[1],image_angle,col1,0.75);
					ovalpha(true);
					draw_sprite_ext(customtoverlay,0,x+(real_y*aox),tailY,0.75*scalemod,tailscale/n.size_tail[1],image_angle,col2,0.75);
					ovalpha(false);
					draw_sprite_ext(customtail,1,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,col1,0.75);
					ovalpha(true);
					draw_sprite_ext(customtoverlay,1,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,col2,0.75);
					ovalpha(false);
				}
				else {
					draw_sprite_ext(nsprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,col1,0.75);
					ovalpha(true);
					draw_sprite_ext(osprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,col2,0.75);
					ovalpha(false);
					draw_sprite_ext(nsprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,col1,0.75);
					ovalpha(true);
					draw_sprite_ext(osprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,col2,0.75);
					ovalpha(false);
				}
			}
			var n_ang = thistype.ang;
			if opt.usenoteskin { if global.noteopt.no_rotate { n_ang = 0; } }
			if !note.hit && !boundsCheck {
				if opt.usenoteskin {
					draw_sprite_ext(customsprite, 1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,n_ang,col1,1);
					ovalpha(true);
					draw_sprite_ext(customoverlay, 1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,n_ang,col2,1);	
					ovalpha(false);
				}
				else {
					draw_sprite_ext(nsprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,col1,1);
					ovalpha(true);
					draw_sprite_ext(osprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,col2,1);
					ovalpha(false);
				}
			}
	
			// doing this in here because this is where i process notes anyways
			if !isbot {
				var notecheck = false;
				if !global.options.usedownscroll { notecheck = real_y < -global.options.inputleniency }
				else { notecheck = real_y > global.options.inputleniency }
				if !note.hit && notecheck && !note.missed {
					if note.special <= 0 {
						miss(tiedCharacter,-0.04,key);
						note.missed = true;
						global.notesplayed += 1;
						recalc_accuracy();		
					}
					else {
						if note.special = 3 {
							die();
						}
					}
				}
			}

			++ctr;
		}
		gpu_set_texfilter(opt.antialiasing);
	}
}