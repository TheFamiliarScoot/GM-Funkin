/// @description Normal UI
var useds = opt.usedownscroll;
if ui.vis {
	if instance_exists(conductor) && conductor.beathit && opt.bump {
		bump = 1.03;	
	}
	bump = lerp(bump,1,d(0.05));
	ui.scale = bump;

	if !surface_exists(ui.surface) {
		ui.surface = surface_create(global.view_width,global.view_height);
	}
	surface_set_target(ui.surface);
	draw_clear_alpha(c_black,0);
	with obj_strum_parent { if visible { event_perform(ev_draw,0); } }
	with obj_ui_parent { if visible { event_perform(ev_draw,0); } }
	
	if instance_exists(conductor) && opt.timedisplay {
		var tdy = useds ? global.view_height-20 : 20;
		var minutes = string(floor(conductor.timeleft / 60));
		var secs = "";
		if conductor.timeleft % 60 < 10 { secs = "0" + string(floor(conductor.timeleft % 60)) }
		else { secs = string(floor(conductor.timeleft % 60)); }
		
		
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		gpu_set_texfilter(false);
		if conductor.countingdown draw_text_transformed(global.view_width/2,tdy,minutes + ":" + secs,2,2,0);
		gpu_set_texfilter(opt.antialiasing);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
	}

	var hpscale = 1.25;
	var hpcenterx = global.view_width/2;
	var hpcentery = useds ? 50 : global.view_height - 80;
	var _hx1 = hpcenterx-300*hpscale;
	var _hy1 = hpcentery-9*hpscale;
	var _hx2 = hpcenterx+300*hpscale;
	var _hy2 = hpcentery+9*hpscale;

	var normhp = global.hp / global.maxhp;
	var hppercent = normhp * 100;

	var leftfailing = hppercent > 80;
	var rightfailing = hppercent < 20;
	
	var lc = c_red;
	var rc = c_lime;
	
	if opt.specialcolors {
		lc = global.dadinstance.barcolor;
		rc = global.bfinstance.barcolor;
	}
	else if opt.player1 {
		lc = c_lime;
		rc = c_red;
	}
	
	var bfcon = rightfailing + (leftfailing * 2);
	var dadcon = leftfailing + (rightfailing * 2);

	draw_rectangle_color(_hx1,_hy1,_hx2,_hy2,c_black,c_black,c_black,c_black,false);
	draw_rectangle_color((_hx1+(4*hpscale))+(4*hpscale),_hy1+(4*hpscale),_hx2-(4*hpscale),_hy2-(4*hpscale),lc,lc,lc,lc,false);
	draw_rectangle_color(_hx2-((592*normhp)*hpscale),_hy1+(4*hpscale),_hx2-(4*hpscale),_hy2-(4*hpscale),rc,rc,rc,rc,false);
	if global.bfinstance.no_antialiasing { gpu_set_texfilter(false); }
	draw_sprite_ext(global.bfinstance.icon,bfcon,_hx2-((592*normhp)*hpscale),hpcentery,-iconscale,iconscale,0,c_white,1);
	gpu_set_texfilter(opt.antialiasing);
	if global.dadinstance.no_antialiasing { gpu_set_texfilter(false); }
	draw_sprite_ext(global.dadinstance.icon,dadcon,_hx2-((592*normhp)*hpscale),hpcentery,iconscale,iconscale,0,c_white,1);
	gpu_set_texfilter(opt.antialiasing);
	
	iconscale = clamp(iconscale - d(0.01),1,1.5);
	if instance_exists(conductor) && conductor.stephit && opt.bump { iconscale = 1.25; }

	draw_set_halign(fa_center);
	var centerx = global.view_width/2;
	var centery = useds ? 80 : global.view_height - 50;
	var mosty = useds ? 0 : global.view_height;
	var scoretext = "";
	var acc = "???";
	var rating = rating_text();
	if global.accuracy > 0 { acc = string(global.accuracy) + "%"; }
	if opt.botplay && !opt.player1 { scoretext = "BOTPLAY"; }
	else { scoretext =
		"Score: " + string(global.score) +
		" | Misses: " + string(global.misses) +
		" | Accuracy: " + acc +
		" | Rating: " + rating;
	}
	var ratingtext = 
		"Sicks: " + string(global.ratings.sick) + "\n" +
		"Goods: " + string(global.ratings.good) + "\n" +
		"Bads: " + string(global.ratings.bad) + "\n" +
		"Shits: " + string(global.ratings.shit) + "\n" +
		"Highest Combo: " + string(global.highcombo);
	draw_set_color(c_black);
	draw_text(centerx+1,centery,scoretext);
	draw_text(centerx-1,centery,scoretext);
	draw_text(centerx,centery+1,scoretext);
	draw_text(centerx,centery-1,scoretext);
	draw_set_color(c_white);
	draw_text(centerx,centery,scoretext);
	draw_set_halign(fa_left);
	draw_set_valign(useds ? fa_top : fa_bottom);
	draw_set_color(c_black);
	draw_text(1,mosty,ratingtext);
	draw_text(-1,mosty,ratingtext);
	draw_text(0,mosty+1,ratingtext);
	draw_text(0,mosty-1,ratingtext);
	draw_set_color(c_white);
	draw_text(0,mosty,ratingtext);
	draw_set_valign(fa_top);

	surface_reset_target();
	if global.pixelui { gpu_set_texfilter(false); }
	draw_ui(ui);
	gpu_set_texfilter(opt.antialiasing);
}
else {
	if surface_exists(ui.surface) { surface_free(ui.surface); }
}

//ui.angle = sin((cond.songpos / 128) * pi) * 4;