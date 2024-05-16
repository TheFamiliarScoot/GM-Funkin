if !opt.customization.usepreset {
	global.gf = global.chars[opt.customization.gfobject];
	global.dad = global.chars[opt.customization.dadobject];
	global.bf = global.chars[opt.customization.bfobject];
	global.bg = global.stages[opt.customization.bgobject];
}
else {
	var set = global.presets[selectpreset];

	global.dad = global.chars[set.dad];
	global.gf = global.chars[set.gf];
	global.bf = global.chars[set.bf];
	global.bg = global.stages[set.stage];
}