var bftex = "char_" + global.bf.filename;
var gftex = "char_" + global.gf.filename;
var dadtex = "char_" + global.dad.filename;
var stagetex = "bg_" + global.bg.filename;
textures_to_load = [ bftex, gftex, dadtex, stagetex ];
curtex = 0;
loaded_last_group = true;
loaded_conductor_data = false;
instance_destroy(obj_transition);