/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
var dir = "assets/sprites/chars/" + loadname + "/";

object = read_json(dir + "object.json");
name = loadname;

mainOffX = object.mainoffset[0];
mainOffY = object.mainoffset[1];

offsets = {};
variable_struct_set(offsets,object.anims.idle,object.offsets.idle);
variable_struct_set(offsets,object.anims.left,object.offsets.left);
variable_struct_set(offsets,object.anims.down,object.offsets.down);
variable_struct_set(offsets,object.anims.up,object.offsets.up);
variable_struct_set(offsets,object.anims.right,object.offsets.right);

idle_sprite = object.anims.idle;
left_sprite = object.anims.left;
down_sprite = object.anims.down;
up_sprite = object.anims.up;
right_sprite = object.anims.right;

invert = object.invert;

barcolor = make_color_rgb(
	object.hpcolor[0],
	object.hpcolor[1],
	object.hpcolor[2]
);

camOffX = object.cameraoffset[0];
camOffY = object.cameraoffset[1];

event_inherited();