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

function read_json_lua(file_path) {
	return read_json("assets/songs/" + global.selectedpack + "/" + file_path);	
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
	return song + (diff != "normal" ? ("-" + diff) : "") + ".json";
}

function get_folders(dir,file_to_exist) {
	var dirs = []
	var file = file_find_first(dir + "/*",fa_directory)
	if file != "" {
		while file != "" {
			if directory_exists(dir + "/" + file) {
				if file_exists(dir + "/" + file + "/" + file_to_exist) {
					array_push(dirs,file);	
				}
			}
			file = file_find_next();
		}
	}
	file_find_close();
	
	return dirs;
}

function get_songs(pack) {
	var list = read_text("assets/songs/" + pack + "/songlist.txt");
	var songs = []
	
	for (var i = 0; i < array_length(list); i += 1) {
		try {
			var finalsong = {
				name: "",
				fileName: "",
				chartType: "",
				difficulties: [],
				instLocation: "",
				voicesLocations: ["", ""]
			}
			var split = string_split(list[i],":");
			finalsong.name = split[0];
			finalsong.fileName = split[0];
			finalsong.chartType = "old";
			finalsong.instLocation = split[0] + "/Inst.ogg";
			finalsong.voicesLocations[1] = split[0] + "/Voices.ogg";
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

function get_gimmicks_song(song) {
	var path = "assets/songs/" + global.selectedpack + "/" + song + "/gimmicks.json";
	if !file_exists(path) { return global.gimmicks; }
	var gimmicks = read_json(path);

	return gimmicks;
}

function get_gimmicks_pack(pack) {
	var path = "assets/songs/" + pack + "/gimmicks.json";
	if !file_exists(path) { return -1; }
	var gimmicks = read_json(path);

	return gimmicks;
}

function get_songs_from_current_pack() {
	var songlist = call_lua("getSongList");
	if !is_undefined(songlist) && is_array(songlist) {
		var songs = [];
		for (var i = 0; i < array_length(songlist); i++) {
			var songinfo = lua_call(global.packscript, "getSong", songlist[i]);
			if !is_undefined(songinfo) {
				array_push(songs, songinfo);	
			}
		}
		if array_length(songs) > 0 {
			return songs;	
		}
	}
	if file_exists("assets/songs/" + global.selectedpack + "/songlist.txt") {
		return get_songs(global.selectedpack);
	}
	return undefined;
}