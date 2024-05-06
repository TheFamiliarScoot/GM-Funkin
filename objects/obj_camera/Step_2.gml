#macro view view_camera[0]

if instance_exists(global.target) {
	var _spd = d(2/game_get_speed(gamespeed_fps));
	x += ((global.target.x + global.target.camOffX) - x) * _spd;
	y += ((global.target.y + global.target.camOffY) - y) * _spd;
	curzoom += (global.cam.zoom - curzoom) * _spd;
	curangle += (global.cam.angle - curangle) * _spd;
	var _vw = global.view_width*curzoom;
	var _vh = global.view_height*curzoom;
	var _vb = (bump - 1) * 0.75;
	camera_set_view_size(view,_vw - (_vw * _vb),_vh - (_vh * _vb));
	var _cur_w = camera_get_view_width(view);
	var _cur_h = camera_get_view_height(view);
	camera_set_view_pos(view,x-_cur_w/2,y-_cur_h/2);
	if global.paused { camera_set_view_angle(view,0); }
	else { camera_set_view_angle(view,curangle); }
}

//view_set_xport(view_current,sin(ct)*100);
//view_set_yport(view_current,cos(ct)*100);
//ct += 0.05;
//ui.angle = cos(ct)*15;