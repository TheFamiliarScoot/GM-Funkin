packinfo = [];

var packlist = get_folders("packs", "pack.json");
var plen = array_length(packlist);
for (var i = 0; i < plen; i++) {
	array_push(packinfo, load_pack_info(packlist[i]));
}

xoffset = 0;
selectedpack = 0;

depth = -100;

selected = false;