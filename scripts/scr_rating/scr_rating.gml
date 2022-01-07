// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function check_rating(ms){
	// stolen from kadeengine sorry love u dawg
	var ts = 1;
	var rating = "sick";
    if (ms <= 166 * ts && ms >= 135 * ts) rating = "shit";
    if (ms < 135 * ts && ms >= 90 * ts) rating = "bad";
    if (ms < 90 * ts && ms >= 45 * ts) rating = "good";
    if (ms < 45 * ts && ms >= -45 * ts) rating = "sick";
    if (ms > -90 * ts && ms <= -45 * ts) rating = "good";
    if (ms > -135 * ts && ms <= -90 * ts) rating = "bad";
    if (ms > -166 * ts && ms <= -135 * ts) rating = "shit";
	
	return rating;
}

function rate(ms) {
	var rat = check_rating(ms);
	var ind = 0;
	
	var ratx = 0;
	if opt.middlescroll {
		ratx = opt.player1 ? 150 : global.view_width - 150;
	}
	else {
		ratx = global.view_width / 2;
	}
	
	switch rat {
		case "sick": ind = 0; global.score += 350; change_hp(0.1); global.ratings.sick += 1 break;
		case "good": ind = 1; global.score += 200; change_hp(0.04); global.ratings.good += 1 break;
		case "bad": ind = 2; change_hp(-0.06); global.ratings.bad += 1 break;
		case "shit": ind = 3; global.score -= 300; change_hp(-0.2); global.ratings.shit += 1 break;
		default: ind = 0; break;
	}
	
	with instance_create_layer(ratx, global.view_height / 2,"UI",obj_blank) {
		image_index = ind;
		time = ms;
		instance_change(obj_rating,true);
	}
}

function recalc_accuracy() {
	global.accuracy = max(0, global.noteshit / global.notesplayed * 100)	
}