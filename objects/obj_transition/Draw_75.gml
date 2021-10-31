var normscale = 0;
/*
if in {
	normscale = alarm[1] / maxframes;
	draw_set_color(c_black);
	draw_rectangle(0,0,global.view_width,global.view_height*normscale,false);
	draw_set_color(c_white);
}
else {
	normscale = alarm[0] / maxframes;
	draw_set_color(c_black);
	draw_rectangle(0,global.view_height*normscale,global.view_width,global.view_height,false);
	draw_set_color(c_white);
}
*/
if in {
	normscale = d_alarm[1] / maxframes;
	var inscale = global.view_height-(global.view_height*normscale);
	draw_set_color(c_black);
	draw_rectangle(0,0,global.view_width,inscale,false);
	draw_set_color(c_white);
	draw_primitive_begin(pr_trianglelist);
	draw_vertex_color(0,inscale,c_black,1);
	draw_vertex_color(global.view_width,inscale,c_black,1);
	draw_vertex_color(0,inscale+200,c_black,0);
	draw_vertex_color(global.view_width,inscale,c_black,1);
	draw_vertex_color(0,inscale+200,c_black,0);
	draw_vertex_color(global.view_width,inscale+200,c_black,0);
	draw_primitive_end();
}
else {
	normscale = d_alarm[0] / maxframes;
	var outscale = global.view_height-(global.view_height*normscale);
	draw_set_color(c_black);
	draw_rectangle(0,global.view_height,global.view_width,outscale,false);
	draw_set_color(c_white);
	draw_primitive_begin(pr_trianglelist);
	draw_vertex_color(0,outscale+1,c_black,1);
	draw_vertex_color(global.view_width,outscale+1,c_black,1);
	draw_vertex_color(0,outscale-200,c_black,0);
	draw_vertex_color(global.view_width,outscale+1,c_black,1);
	draw_vertex_color(0,outscale-200,c_black,0);
	draw_vertex_color(global.view_width,outscale-200,c_black,0);
	draw_primitive_end();
}