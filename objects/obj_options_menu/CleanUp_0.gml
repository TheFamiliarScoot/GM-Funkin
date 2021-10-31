if !opt.customization.usepreset {
	global.gfobject = global.chars[opt.customization.gfobject];
	global.dadobject = global.chars[opt.customization.dadobject];
	global.bfobject = global.chars[opt.customization.bfobject];
	global.bgobject = global.stages[opt.customization.bgobject];
}
else {
	var set = global.presets[selectpreset];

	global.dadobject = set[0];
	global.gfobject = set[1];
	global.bfobject = set[2];
	global.bgobject = set[3];
}