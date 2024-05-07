event_inherited();

depth = 0;

if texture != "none" {
	texture_prefetch(texture);
}

self.holding = false;
self.lastStep = 0;
if !is_custom {
	idle_sprite = asset_get_index(idle_sprite);	
	up_sprite = asset_get_index(up_sprite);	
	down_sprite = asset_get_index(down_sprite);	
	left_sprite = asset_get_index(left_sprite);	
	right_sprite = asset_get_index(right_sprite);	
}

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

//custom_sprite = load_json_sprite(name);