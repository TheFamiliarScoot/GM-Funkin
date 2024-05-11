event_inherited();

customsprite = 0;
customoverlay = 0;
customtail = 0;
customtoverlay = 0;

if opt.usenoteskin {
	customsprite = global.noteskin;
	customoverlay = global.noteskin_o;
	customtail = global.noteskin_tail;
	customtoverlay = global.noteskin_tailo;
}
	
nsprite = [
	[spr_note_static,spr_note_pressed,spr_note_confirm,spr_note_tail,spr_note_end,spr_blank],
	[spr_pixel_note_static,spr_pixel_note_pressed,spr_pixel_note_confirm,spr_pixel_note_tail,spr_pixel_note_end,spr_blank]
];

osprite = [
	[spr_nover_static,spr_nover_pressed,spr_nover_confirm,spr_nover_tail,spr_nover_end,spr_note_strum],
	[spr_pixel_nover_static,spr_blank,spr_pixel_nover_confirm,spr_pixel_nover_tail,spr_pixel_nover_end,spr_pixel_note_strum]
];

scalemod = 1;
if opt.usenoteskin { scalemod = global.noteopt.scale; }

//if global.keyamt = 6 { scalemod = 0.8; }
if global.pixelui { scalemod *= 8; }

group = 0;
// this kinda sucks a little

if tiedCharacter = global.dadinstance { group = 1; }
if tiedCharacter = global.bfinstance { group = 0; }

notetype = global.ntype[global.keyamt];

image_xscale = 0.75 * scalemod;
image_yscale = 0.75 * scalemod;

lastnote = noone;
lasttime = 0;

visualangle = 0;

play_anim_d(id,nsprite[global.pixelui][5]);