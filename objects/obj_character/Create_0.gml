event_inherited();

depth = 0;

self.holding = false;
self.lastStep = 0;

var templeft = left_sprite;
var tempright = right_sprite;
var tempmissleft = left_miss_sprite;
var tempmissright = right_miss_sprite;
var tempaltleft = left_alt_sprite;
var tempaltright = right_alt_sprite;
if invert {
	if playside = 1 {
		image_xscale = scale;
	}
	else if playside = 0 {
		image_xscale = -scale;
		camOffX = -camOffX;
		left_sprite = tempright;
		right_sprite = templeft;
		left_miss_sprite = tempmissright;
		right_miss_sprite = tempmissleft;
		left_alt_sprite = tempaltright;
		right_alt_sprite = tempaltleft;
	}
	else {
		image_xscale = -scale;
	}
}
else {
	if playside = 1 {
		image_xscale = -scale;
		camOffX = -camOffX;
		left_sprite = tempright;
		right_sprite = templeft;
		left_miss_sprite = tempmissright;
		right_miss_sprite = tempmissleft;
		left_alt_sprite = tempaltright;
		right_alt_sprite = tempaltleft;
	}
	else if playside = 0 {
		image_xscale = scale;
	}
	else {
		image_xscale = scale;	
	}
}
image_yscale = scale;

danced = false;
missed = false;

//custom_sprite = load_json_sprite(name);