texture_prefetch("mainmenu");

timer = 0;

var file = working_directory + "keybinds.ini";
if !file_exists(file) {
	ini_open(file);
	ini_write_real("Keys","Up",ord("W"));
	ini_write_real("Keys","Down",ord("S"));
	ini_write_real("Keys","Left",ord("A"));
	ini_write_real("Keys","Right",ord("D"));
}
else {
	ini_open(file);
}

global.keys = {up: ord("W"), down: ord("S"), left: ord("A"), right: ord("D")}
global.keys.up = ini_read_real("Keys","Up",ord("W"));
global.keys.down = ini_read_real("Keys","Down",ord("S"));
global.keys.left = ini_read_real("Keys","Left",ord("A"));
global.keys.right = ini_read_real("Keys","Right",ord("D"));

ini_close();

setupstate = 1;

current = 0;

global.selectedsong = "";
global.selecteddifficulty = "";
global.selectedpack = "";

packs = read_text("assets/songs/packlist.txt");
songs = [];

menuenabled = true;