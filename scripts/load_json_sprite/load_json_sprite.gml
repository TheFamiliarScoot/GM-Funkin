// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function load_json_sprite(name){
	var ctr = 0;
	var ctr2 = 0;
	
	var dummy_surf = surface_create(2,2);
	
	var ret = {
		sprites: {},
		atlas: sprite_add("assets/sprites/" + name + "/atlas.png",1,false,false,0,0)
	};
	
	var sprite_obj = read_json("assets/sprites/" + name + "/sprite.json");
	var atlas_obj = read_json("assets/sprites/" + name + "/atlas.json");
	
	repeat array_length(sprite_obj.sprites) {
		var spriteToAdd = {
			index: sprite_duplicate(spr_custom),
			frames: []
		}
		var curSprite = sprite_obj.sprites[ctr];
		
		repeat array_length(curSprite.frames) {
			var frameToAdd = {
				size: [],
				offset: []
			}
			
			var indexToGrab = string_format(string(ctr2),4,0);
			indexToGrab = string_replace_all(indexToGrab," ","0");
			
			var current = variable_struct_get(atlas_obj.frames, curSprite.prefix + indexToGrab);
			frameToAdd.size[0] = current.frame.w;
			frameToAdd.size[1] = current.frame.h;
			frameToAdd.offset[0] = current.frame.x;
			frameToAdd.offset[1] = current.frame.y;
			array_push(spriteToAdd.frames, frameToAdd);
			sprite_add_from_surface(spriteToAdd.index,dummy_surf,0,0,0,0,false,false);
			++ctr2;
		}
		ctr2 = 0;
		array_push(ret.sprites,spriteToAdd);
		++ctr;
	}
	ctr = 0;
	return ret;
}

function change_sprite(the_id, the_asset) {
	with the_id {
		image_index = 0;
		image_speed = 1;
		if is_custom {
			sprite_index = variable_instance_get(id,the_asset).index;
		}
		else {
			sprite_index = name;
		}
		
	}
}