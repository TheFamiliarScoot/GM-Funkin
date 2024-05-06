texture_prefetch("mainmenu");

timer = 0;



setupstate = 0;

current = 0;

global.selectedsong = {};
global.selecteddifficulty = "";
global.selectedpack = "";

packs = get_folders("assets/songs","songlist.txt");
songs = [];

menuenabled = true;

global.stats = try_load_scores("scores.dat")
deletingstats = false;

menu = create_scroll_menu(140,400,layer_get_id("Menus"),
	["pack chooser", "options", "exit"]
);

lastchoices = [];