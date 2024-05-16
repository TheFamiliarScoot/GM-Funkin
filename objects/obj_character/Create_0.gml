event_inherited();

depth = 0;

if texture != "none" {
	load_textures(texture);
}

self.holding = false;
self.lastStep = 0;

var templeft = left_sprite;
var tempright = right_sprite;
if invert {
	if playside = 1 {
		image_xscale = scale;
	}
	else if playside = 0 {
		image_xscale = -scale;
		camOffX = -camOffX;
		left_sprite = tempright;
		right_sprite = templeft;
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