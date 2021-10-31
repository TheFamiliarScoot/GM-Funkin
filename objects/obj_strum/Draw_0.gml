//var notes = variable_struct_get(global.strumgroups,group)[type % 4];
var stype = notetype[type % 4];
var ovsprite = 0;
var key = type % 4;

var p = global.pixelui;

// 0 - static
// 1 - pressed
// 2 - confirm
// 3 - tail
// 4 - end


switch sprite_index {
	case nsprite[p][1]: ovsprite = osprite[p][1]; break;
	case nsprite[p][2]: ovsprite = osprite[p][2]; break;
	default: ovsprite = osprite[p][5]; break;
}
if enabled {
	if p { gpu_set_texfilter(false); }
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,stype.ang+visualangle,stype.color,image_alpha);
	draw_sprite_ext(ovsprite,image_index,x,y,image_xscale,image_yscale,stype.ang+visualangle,c_white,image_alpha);
	for (var i = -1; i < 2; i += 1) {
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
	
			var endscale = (clamp(lengthdiff,0,64)/64)*-global.notescroll;
			if !note.completed && !tailBounds {
				switch note.special {
					case 0:
						draw_sprite_ext(nsprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,thistype.color,0.75);
						draw_sprite_ext(osprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,c_white,0.75);
						draw_sprite_ext(nsprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,thistype.color,0.75);
						draw_sprite_ext(osprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,c_white,0.75);
						break;
					case 1:
						draw_sprite_ext(nsprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,c_black,75);
						draw_sprite_ext(osprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,c_red,0.75);
						draw_sprite_ext(nsprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,c_black,0.75);
						draw_sprite_ext(osprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,c_red,0.75);
					case 2:
						draw_sprite_ext(nsprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,c_white,75);
						draw_sprite_ext(osprite[p][3],0,x+(real_y*aox),tailY,0.75*scalemod,tailscale,image_angle,c_lime,0.75);
						draw_sprite_ext(nsprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,c_white,0.75);
						draw_sprite_ext(osprite[p][4],0,x+(real_y*aox),endY,0.75*scalemod,endscale,image_angle,c_lime,0.75);
				}

			}
			if !note.hit && !boundsCheck {
				switch note.special {
					case 0:
						draw_sprite_ext(nsprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,thistype.color,1);
						draw_sprite_ext(osprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,c_white,1);
						break;
					case 1:
						draw_sprite_ext(nsprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,c_black,1);
						draw_sprite_ext(osprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,c_red,1);
						break;
					case 2:
						draw_sprite_ext(nsprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,c_white,1);
						draw_sprite_ext(osprite[p][0], -1, x+(real_y*aox), y + (real_y*aoy),0.75*scalemod,0.75*scalemod,thistype.ang,c_lime,1);
						break;
				}

			}
	
			// doing this in here because this is where i process notes anyways
			if !isbot {
				var notecheck = false;
				if !global.options.usedownscroll { notecheck = real_y < -global.options.inputleniency }
				else { notecheck = real_y > global.options.inputleniency }
				if !note.hit && notecheck && !note.missed && !(note.special > 0) {
					miss(tiedCharacter,-0.04,key);
					note.missed = true;
				}
				
			}

			++ctr;
		}
		gpu_set_texfilter(opt.antialiasing);
	}
}