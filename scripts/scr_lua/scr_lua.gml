// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function new_lua_state() {
	var state = lua_state_create();
	lua_global_set(state, "os", undefined)
	lua_global_set(state, "io", undefined)
	lua_add_function(state, "string", string);
	lua_add_function(state, "log", l_log);
	lua_add_function(state, "loadJson", read_json_lua);
	lua_add_function(state, "loadConductorData", load_conductor_data);
	lua_add_function(state, "createCharacter", create_character);
	lua_add_function(state, "createStrum", create_strum);
	lua_add_function(state, "createConductor", create_conductor);
	lua_add_function(state, "getCharacter", l_get_character);
	return state
}

function clear_lua_state(state) {
	lua_state_destroy(state)
}

function call_lua(func, args) {	
	// songscript
	try {
		if global.songscript > -1 {
			var value = lua_call(global.songscript, func, args);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) { }
	
	// packscript
	try {
		if global.packscript > -1 {
			var value = lua_call(global.packscript, func, args);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) { }
	
	return undefined;
}

function l_log(msg) {
	show_debug_message(msg);	
}

function l_get_character(idx) {
	return [ global.bfinstance, global.dadinstance, global.gfinstance ];
}