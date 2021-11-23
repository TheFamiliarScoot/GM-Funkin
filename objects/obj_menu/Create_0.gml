texture_prefetch("mainmenu");

timer = 0;



setupstate = 1;

current = 0;

global.selectedsong = "";
global.selecteddifficulty = "";
global.selectedpack = "";

packs = read_text("assets/songs/packlist.txt");
songs = [];

menuenabled = true;

stats = -1;