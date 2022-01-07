// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function read_json(file_path){
	var file = file_text_open_read(file_path);
	var json_text = "";
	while !file_text_eof(file) {
		json_text = json_text + file_text_read_string(file);
		file_text_readln(file);
	}
	file_text_close(file);
	return json_parse(json_text);
}

function read_json_map(file_path){
	var file = file_text_open_read(file_path);
	var json_text = "";
	while !file_text_eof(file) {
		json_text = json_text + file_text_read_string(file);
		file_text_readln(file);
	}
	file_text_close(file);
	return json_decode(json_text);
}

function read_text(file_path){
	var file = file_text_open_read(file_path);
	var ret = [];
	while !file_text_eof(file) {
		array_push(ret,file_text_read_string(file));
		file_text_readln(file);
	}
	file_text_close(file);
	return ret;
}

function difficulty_to_file(song,diff) {
	var diffaddstring = "";
	if diff != "normal" {diffaddstring = "-" + diff}
	return song + diffaddstring + ".json";
}

function get_packs(dir) {
	var packs = []
	var file = file_find_first(dir + "/*",fa_directory)
	if file != "" {
		while file != "" {
			if directory_exists(dir + "/" + file) {
				if file_exists(dir + "/" + file + "/songlist.txt") {
					array_push(packs,file);	
				}
			}
			file = file_find_next();
		}
	}
	file_find_close();
	
	return packs;
}

function get_songs(pack) {
	var list = read_text("assets/songs/" + pack + "/songlist.txt");
	var songs = []
	
	for (var i = 0; i < array_length(list); i += 1) {
		try {
			var finalsong = {
				name: "",
				difficulties: []
			}
			var split = string_split(list[i],":");
			finalsong.name = split[0];
			if array_length(split) < 2 {
				finalsong.difficulties = ["easy","normal","hard"];
			}
			else {
				var diffs = string_split(split[1],",");
				if diffs[0] = "" && array_length(diffs) = 1 {
					finalsong.difficulties = ["easy","normal","hard"];	
				}
				else {
					finalsong.difficulties = diffs;
				}
			}
			array_push(songs,finalsong);
		}
		catch (e) {
			show_debug_message("weird malformity in songlist.txt");
		}
	}
	show_debug_message(songs);
	return songs;
}

function try_load_scores(file) {
	var stats = ds_map_secure_load(file);
	if !ds_exists(stats, ds_type_map) {
		show_debug_message("did not load")
		stats = ds_map_create();
	}
	ds_map_add(stats,"dummy",-69);
	return stats;
}