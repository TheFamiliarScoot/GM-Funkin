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