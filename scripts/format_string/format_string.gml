// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function format_string() {
	// Universal counter
	var ctr = 0;
	
	// No arguments?
	if argument_count = 0 {
		show_error("format_string: No arguments supplied", true);
	}
	
	// Argument 1 should always be a string
	if !is_string(argument[0]) {
		show_error("format_string: Argument 0 is not a string", true);	
	}
	var str = argument[0];
	if argument_count = 1 { return str;	}

	var arg_struct = {};
	repeat argument_count - 1 {
		try {
			var tester = "Test" + argument[ctr + 1];
		}
		catch (e) {
			show_error("format_string: Argument " + string(ctr + 1) + " could not be converted to a string", true);
		}
		variable_struct_set(arg_struct,"arg" + string(ctr),argument[ctr + 1]);
		++ctr;	
	}
	ctr = 0;

	var format_strings = [];
	
	repeat string_length(str) {
		var cur = string_char_at(str,ctr + 1);
		if cur = "{" {
			if string_char_at(str,ctr + 2) = "{" { ++ctr; }
			else {
				var curFmt = "";
				while cur != "}" {
					cur = string_char_at(str,ctr + 1);
					curFmt = curFmt + cur;
					++ctr;
				}
				array_push(format_strings,curFmt);
			}
		}
		if ctr > string_length(str) {
			break;
		}
		++ctr;
	}
	ctr = 0;
	if array_length(format_strings) > argument_count - 1 {
		show_error("format_string: Too little arguments to format string with", true);	
	}
	repeat array_length(format_strings) {
		var actual = format_strings[ctr];
		actual = string_replace(actual,"{","");
		actual = string_replace(actual,"}","");
		
		if actual = "" {
			actual = string(ctr);
		}

		str = string_replace(str,format_strings[ctr],variable_struct_get(arg_struct,"arg" + actual));
		++ctr;
	}
	ctr = 0;
	
	return str;
}

function string_split(str, char) {
	var ctr = 0;
	if string_length(char) > 1 { show_error("string_split: Argument 2 MUST be a char", true); }
	
	var ret = [];
	
	if char = "" {
		repeat string_length(str) {
			var cur = string_char_at(str,ctr + 1);
			array_push(ret,cur);
			++ctr;
		}		
	}
	else {
		var toPush = "";
		repeat string_length(str) {
			var cur = string_char_at(str,ctr + 1);
			if cur = char {
				array_push(ret,toPush);
				toPush = "";
			}
			else {
				toPush += cur;
			}
			++ctr;
		}
		array_push(ret,toPush);
	}
	
	return ret;
}