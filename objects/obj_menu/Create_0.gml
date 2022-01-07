texture_prefetch("mainmenu");

timer = 0;



setupstate = 1;

current = 0;

global.selectedsong = {};
global.selecteddifficulty = "";
global.selectedpack = "";

packs = get_packs("assets/songs");
songs = [];

menuenabled = true;

global.stats = try_load_scores("scores.dat")
deletingstats = false;