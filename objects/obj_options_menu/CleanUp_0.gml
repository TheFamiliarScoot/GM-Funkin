if !opt.customization.usepreset {
	global.gfobject = global.chars[opt.customization.gfobject].object;
	global.dadobject = global.chars[opt.customization.dadobject].object;
	global.bfobject = global.chars[opt.customization.bfobject].object;
	global.bgobject = global.stages[opt.customization.bgobject].object;
}
else {
	var set = global.presets[selectpreset];

	global.dadobject = set.dad;
	global.gfobject = set.gf;
	global.bfobject = set.bf;
	global.bgobject = set.stage;
}