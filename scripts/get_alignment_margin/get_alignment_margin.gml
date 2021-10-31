// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_alignment_margin(var1,var2,alignment){
	var diff = var1 - var2;
	if (var1 = var2) {
		return "PERFECT"
	}
	if (var1 < var2) || (var1 < var2) {
		return "OFF BY " + string(diff);
	}
	if (diff < alignment) || (diff > alignment) {
		return "NOT ALIGNED"	
	}
}