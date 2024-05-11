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