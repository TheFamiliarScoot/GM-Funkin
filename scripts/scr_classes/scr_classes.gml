function Note(t,str,l) constructor {
	position = t;      // position of the note
	type = str;        // note type
	length = l;        // length of the note
	hit = false;       // if the note was hit
	missed = false;    // if the note was missed
	covered = 0;       // how much of the length of the note was covered
	completed = false; // if the hold note was actually finished
	timehit = 0;       // ms at which the note was hit
	special = 0;       // special note type
}

function Event(t,str,v) constructor {
	position = t;      // position of the event
	type = str;        // type of the event
	value = v;         // value struct of the event
	played = false;    // if the event was played
}

function TimeChange(t,b,n,dn) constructor {
	position = t;      // position of the time change
	bpm = b;           // the new bpm to be set
	numerator = n;     // the numerator of the new time signature
	denominator = dn;  // the denominator of the new time signature
	played = false;	
}

function PackInfo(fn, n, dc, s, w, l) constructor {
	filename = fn;
	name = n;
	description = dc;
	songs = s;
	weeks = w;
	logo = l;
}

function load_pack_info(pack) {
	var json = read_json("packs/" + pack + "/pack.json");
	
	var name = "???";
	if variable_struct_exists(json, "name") {
		name = json.name;	
	}
	
	var description = "No description";
	if variable_struct_exists(json, "description") {
		description = json.description;	
	}
	
	var songs = [];
	if variable_struct_exists(json, "songs") {
		songs = json.songs;	
	}
	
	var weeks = [];
	if variable_struct_exists(json, "weeks") {
		weeks = json.weeks;	
	}
	
	var logo = noone;
	var logoloc = "packs/" + pack + "/logo.png";
	if file_exists(logoloc) {
		logo = sprite_add(logoloc,1,false,false,0,0);
	}
	
	return new PackInfo(pack, json.name, description, songs, weeks, logo);
}

function delete_pack_info(pack) {
	if pack.logo != noone {
		sprite_delete(pack.logo);	
	}
}

function Character(name, object, icon, default_sprite) constructor {
	self.name = name;
	self.object = object;
	self.icon = icon;
	self.default_sprite = default_sprite;
}

function Stage(name, object) constructor {
	self.name = name;
	self.object = object;
}

function Preset(name, stage, bf, gf, dad) constructor {
	self.name = name;
	self.stage = stage;
	self.bf = bf;
	self.gf = gf;
	self.dad = dad;
}